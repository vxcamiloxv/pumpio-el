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

(defun pmpio-ctrl-get-note (uuid)
  (unless (pmpio-is-registered-p)
    (pmpio-register)
    )
  
  (pmpio-get-note uuid 'pmpio-ctrl-get-note-callback)
  )

(defun pmpio-ctrl-get-note-callback (note)
  (with-current-buffer (get-buffer-create "PumpIO Note")
    (pmpio-note-show note)
    )		     
  )

;;; pumpio-control.el ends here
