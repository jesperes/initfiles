;;
;; Restructured Emacs init file
;;

(cond
 ((eq window-system 'w32)
  (setq custom-file 
	(expand-file-name "~/initfiles/elisp/emacs-custom-win32.el")))
 (t
  (setq custom-file 
	(expand-file-name "~/initfiles/elisp/emacs-custom.el"))))

(load custom-file)
