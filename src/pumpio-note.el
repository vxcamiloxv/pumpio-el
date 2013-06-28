;;; pumpio-note.el --- 

;; Copyright 2013 Christian
;;
;; Author: cnngimenez@lavabit.com
;; Version: $Id: pumpio-message.el,v 0.0 2013/06/28 15:42:03 cng Exp $
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
;;   (require 'pumpio-message)

;;; Code:

(provide 'pumpio-note)

(defconst pmpio-note-objecttype "note"
  "This is the objectType field" )

(defconst pmpio-note-elements '(uuid author content url updated published comments)
  "This are the allowed elements that a note can have.")

(defun pmpio-note-new (author content  &optional uuid url updated published)
  "Create a new note given the AUTHOR and CONTENT and return it."
  
  (let ((note (make-hash-table))
	)
    (puthash 'uuid uuid note)
    (puthash 'author author note)
    (puthash 'content content note)
    (puthash 'url url note)
    (puthash 'updated updated note)
    (puthash 'published published note)
    (puthash 'comments nil note)
    
    note
    )
  )

(defun pmpio-note-get (elt note)
  "Return the ELT element from the note.
ELT can be one of the `pmpio-note-elements' constants."
  (if (member elt pmpio-note-elements)
      (gethash elt note)
    (error "Element doesn't exists!")
    )
  )



(defun pmpio-note-add-comment (note comment)
  "Add one COMMENT into the NOTE."
  (let ((lst-com (gethash 'comments note))
	)
    (puthash 'comments (add-to-list 'lst-com comment t) note)
    )  
  )

;;; pumpio-message.el ends here
