;;
;; New Emacs file
;;
;; Instructions:
;;
;; $ git clone git@github.com:jesperes/initfiles.git
;; $ ln -s initfiles/emacs.el .emacs

(cond
 ((eq window-system 'w32)
  (setq custom-file 
	(expand-file-name "~/initfiles/elisp/emacs-custom-win32.el")))
 (t
  (setq custom-file 
	(expand-file-name "~/initfiles/elisp/emacs-custom.el"))))

(load custom-file)
