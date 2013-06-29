;;; pumpio-urls.el --- 

;; Copyright 2013 Christian
;;
;; Author: cnngimenez@lavabit.com
;; Version: $Id: pumpio-urls.el,v 0.0 2013/06/29 01:12:09 cng Exp $
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
;;   (require 'pumpio-urls)

;;; Code:

(provide 'pumpio-urls)

(defvar pumpio-pod "http://microca.st"
  "This is the pod where you have your account.")

(defun pmpio-url-get-note (uuid)
  "Return the URL string for getting a note with id UUID."
  (concat pumpio-pod "/api/note/" uuid)
  )
  
(defun pmpio-url-get-client-register ()
  "Return the URL string for getting the client registration URL."
  (concat pumpio-pod "/api/client/register")
  )

;;; pumpio-urls.el ends here
