;;; split-nways.el --- Split windows horizontally an arbitrary number of times.

;; Copyright (C) 2000 Anders Lindgren.

;; This file is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation; either version 2, or (at your option)
;; any later version.

;; This file is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with GNU Emacs; see the file COPYING.  If not, write to the
;; Free Software Foundation, Inc., 59 Temple Place - Suite 330,
;; Boston, MA 02111-1307, USA.

;;; Commentary:

;; TODO: There is a "balance-windows", maybe we should just split the
;; display and call it instead?

;;; Code:

(eval-when-compile
  (require 'cl))


(defvar split-window-horizontally-nways-min-width 72)

;; Yeah, I know this is wrong...
(defun split-window-horizontally-nways-scroll-bar-width (&optional frame)
  (if (>= emacs-major-version 21)
      6
    2))

(defun split-window-horizontally-nways (&optional arg)
  "Split windows horzontally into ARG equally sized columns.
Should ARG be nil as many windows as possible are created as long as they are
will not become narrower than `split-window-horizontally-nways-min-width'."
  (interactive "P")
  (let ((bar-width (split-window-horizontally-nways-scroll-bar-width)))
    (unless arg
      (setq arg (/ (+ (window-width) bar-width)
		   (+ split-window-horizontally-nways-min-width bar-width))))
    (let ((width (- (window-width) (* (- arg 1) bar-width))))
      (while (> arg 1)
	(split-window-horizontally
	 (+ (/ width arg) bar-width))
	(setq width (- width (window-width)))
	(other-window 1)
	(setq arg (- arg 1))))))


(defun delete-other-windows-and-split-window-horizontally-nways (&optional arg)
  ""
  (interactive "P")
  (delete-other-windows)
  (split-window-horizontally-nways arg))

(defun follow-delete-other-windows-and-split-window-horizontally-nways
  (&optional arg)
  ""
  (interactive "P")
  (delete-other-windows-and-split-window-horizontally-nways arg)
  (follow-mode 1))

(provide 'split-nways)

;;; split-nways.el ends here
