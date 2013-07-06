;;; pumpio-control.el --- 

;; Copyright 2013 Christian
;;
;; Author: cnngimenez@lavabit.com
;; Version: $Id: pumpio-control.el,v 0.0 2013/06/29 06:34:45 cng Exp $
;; Keywords: 
;; X-URL: not distributed yet

;; This program is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation; either version 2, or (at your option)
;; any later version.
;;
;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.
;;
;; You should have received a copy of the GNU General Public License
;; along with this program; if not, write to the Free Software
;; Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.

;;; Commentary:

;; 

;; Put this file into your load-path and the following into your ~/.emacs:
;;   (require 'pumpio-control)

;;; Code:

(provide 'pumpio-control)

(require 'pumpio-stream)
(require 'pumpio-note)


(defconst pumpio-buffer "PumpIO"
  "This is the PumpIO Buffer name.

By convenience, we like to use only one buffer for everything."
  )

(defun pmpio-ctrl-get-note (uuid)
  "Get the note identified by its UUID.

Ensure that this client is registered."
  (unless (pmpio-is-registered-p)
    (pmpio-register)
    )
  
  (pmpio-get-note uuid 'pmpio-ctrl-get-note-callback)
  )

(defun pmpio-ctrl-get-note-callback (note)
  "This is a callback function used when the note has been retrieved.

It simply create or get the buffer and write down the note."
  (with-current-buffer (get-buffer-create pumpio-buffer)
    (delete-region (point-min) (point-max))
    (pmpio-note-write note)
    (switch-to-buffer-other-window (current-buffer))
    )		     
  )

(defun pmpio-ctrl-get-major-feed (nickname)
  "Get the major feed for a user.

Ensure that this client is registered."
  (unless (pmpio-is-registered-p)
    (pmpio-register)
    )

  (pmpio-get-major-feed nickname 'pmpio-ctrl-get-major-feed-callback)
  )

(defun pmpio-ctrl-get-major-feed-callback (activities)
  "Callback function for `pmpio-ctrl-get-major-feed'."
  (with-current-buffer (get-buffer-create pumpio-buffer)
    (delete-region (point-min) (point-max))
    (dolist (act activities)
      (pmpio-write-activity act)
      )
    (switch-to-buffer-other-window (current-buffer))
    )		     
  )


					; Posting feature

(defvar pmpio-ctrl-selected-to nil
  "This variable has a list of people selected for completing the To field. In other words, these are the intended receptors of the message.

Is intended for temporary use, as soon as the post is sended correctly this variable will be cleaned.

This list can have these type of elements:

- string with the account address like \"acct:alice@microca.st\".
- symbol with the collection name like 'public or 'followers. See `pmpio-url-collections' variable.
")

(defvar pmpio-ctrl-selected-cc nil
  "Idem as `pmpio-ctrl-selected-to' but for carbon copy messages.")

(defun pmpio-ctrl-post-note ()
  "Create a new buffer for writing a note"
  (with-current-buffer (get-buffer-create pmpio-ctrl-post-buffer)
    
    ;; (pumpio-post-mode)
    (switch-to-buffer-other-window (current-buffer))
    )
  )

(defun pmpio-ctrl-post-current-buffer ()
  "Send a note to the server."
  (unless (pmpio-is-registered-p)
    (pmpio-register)
    )
   
  (pmpio-post-note pumpio-username
   (make-pmpio-note :content (buffer-string))
  )

;;; pumpio-control.el ends here
