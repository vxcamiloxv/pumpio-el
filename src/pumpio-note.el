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

(require 'cl)

(require 'pumpio-comment)

(defconst pmpio-note-objecttype "note"
  "This is the objectType field" )

(defstruct pmpio-note 
  uuid author content url updated published comments)

(defun pmpio-note-add-comment (note comment)
  "Add one COMMENT into the NOTE."
  (when (and 
	 (pmpio-comment-p comment)
	 (pmpio-note-p note))      
    (let ((lst-com (pmpio-note-comments note))
	  )
      (setf (pmpio-note-comments note) (add-to-list 'lst-com comment t))
      )  
    )
  )

(defun pmpio-note-write (note)
  "Write in the current buffer the given NOTE."
  (insert (format "\n%s at %s: \n%s" 
		  (pmpio-note-author note)
		  (pmpio-note-published note)
		  (pmpio-note-content note)
		  )
	  )
  )
;;; pumpio-message.el ends here
