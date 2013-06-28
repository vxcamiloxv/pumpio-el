;;; pumpio-http.el --- 

;; Copyright 2013 Christian
;;
;; Author: cnngimenez@lavabit.com
;; Version: $Id: pumpio-http.el,v 0.0 2013/06/28 15:37:43 cng Exp $
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
;;   (require 'pumpio-http)

;;; Code:

(provide 'pumpio-http)

(require 'pumpio-comment)
(require 'pumpio-note)

(require 'url)

(defun pmpio-http-assign-functions ()
  "Assign to the API the funcions needed for using pump-http."
  
  (setq pmpio-get-note-hook 'pmpio-http-get-note)
  )

(defun pmpio-http-get-note (uuid)
  "Make a get request for the UUID."
  
  (let ((url-request-extra-headers 
	 '(("Accept-Charset" . "utf-8")))
	(buffer-file-coding-system 'utf-8)
	)
    (let ((buffer (url-retrieve (pmpio-url-get-note uuid) 'pmpio-http-parse-note))
	  )
      ;; (kill-buffer buffer)
      )
    )
  )



					; Internal functions

(defun pmpio-http-parse-note-callback (status)  
  (pmpio-http-delete-headers)
  
  ;; parse the json information
  (let ((parsed (json-read)))
    ;; (pmpio-note-new 
    )
  )  

;;; pumpio-http.el ends here
