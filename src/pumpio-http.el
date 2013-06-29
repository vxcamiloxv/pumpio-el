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
(require 'pumpio-urls)

(require 'url)
(require 'json)

(defvar pmpio-client-id nil
  "Client id for oauth authentication. This will be automatically setted by `pmpio-http-register-client' and its callback.")
(defvar pmpio-client-secret nil
  "Client secret for oauth authentication. This will be automatically setted by `pmpio-http-register-client' and its callback.")
(defvar pmpio-auth-token nil
  "Authorization token given by `oauth-authorize-app' when user has successfully finished the OAuth process.")

(defun pmpio-http-assign-functions ()
  "Assign to the API the funcions needed for using pump-http."
  
  (setq pmpio-get-note-hook 'pmpio-http-get-note)
  )

(defun pmpio-http-get-note (uuid fnc)
  "Make a get request for the UUID.

When the note is completely retrieved, I call the given function FNC.

FNC has to recieve one parameter: the note loaded."
  
  (let ((url-request-extra-headers 
	 '(("Accept-Charset" . "utf-8")))
	(buffer-file-coding-system 'utf-8)
	)
    (oauth-url-retrieve pmpio-auth-token (pmpio-url-get-note uuid) 'pmpio-http-parse-note-callback (list fnc))
    )  
  )



					; Internal functions

(defun pmpio-http-parse-note-callback (status fnc)
  (pmpio-http-delete-headers)
  
  ;; parse the json information
  (let* ((parsed (json-read))
	 (note     (make-pmpio-note 
		    :uuid (cdr (assoc 'uuid parsed))
		    :author (cdr (assoc 'preferredUsername (cdr (assoc 'author parsed))))
		    :content (cdr (assoc 'content parsed))
		    :published (cdr (assoc 'published parsed))
		    :updated (cdr (assoc 'updated parsed))
		    :url (cdr (assoc 'url parsed))
		    ;; :comments ... 
		    )
		   )
	 )
    
    (kill-buffer)
    (funcall fnc note)
    )
  )

(defun pmpio-http-register-client ()
  "Register the client dinamically."
  
  (let ((url-request-method "POST")
	(url-request-extra-headers	 
	 '(("Content-Type" . "application/json")
	   ("Accept-Charset" . "utf-8"))
	 )	  
	(buffer-file-coding-system 'utf-8)
	(url-request-data  "{ \"type\": \"client_associate\", \"application_name\": \"pumpio-el\", \"application_type\": \"native\" }")
	)
    (url-retrieve (pmpio-url-get-client-register) 'pmpio-http-process-registration-callback)  
    )
  )

(defun pmpio-http-process-registration-callback (status)
  "This is a callback function for `pmpio-http-register-client'.
Gets the client secret and client id and stores it at the `pmpio-client-secret' and `pmpio-client-id' variables"
  (pmpio-http-delete-headers)
  (let ((parsed (json-read))
	)
    (setq pmpio-client-secret (cdr (assoc 'client_secret parsed)))
    (setq pmpio-client-id (cdr (assoc 'client_id parsed)))	
    )
  (kill-buffer)

  ;; Authorize
  (setq pmpio-auth-token (oauth-authorize-app pmpio-client-id
					      pmpio-client-secret 
					      (pmpio-url-request)
					      (pmpio-url-access)
					      (pmpio-url-authorize)))
  )

(defun pmpio-http-delete-headers ()
  "Delete all the HTTP headers in the current buffer."

  (let ((ending (search-forward "\n\n" nil t))
	)
    (when ending
      (delete-region (point-min) ending)
      )
    )  
  )



;;; pumpio-http.el ends here
