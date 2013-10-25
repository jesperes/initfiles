;;
;; New Emacs file. Symlink from $HOME/.emacs.
;;
;; Intended for use with Emacs 24.x.
;;

(cond
 ((eq window-system 'w32)
  (setq custom-file 
	(expand-file-name "~/initfiles/elisp/emacs-custom-win32.el")))
 (t
  (setq custom-file 
	(expand-file-name "~/initfiles/elisp/emacs-custom.el"))))

(load custom-file)

(require 'package)
(package-initialize)
(add-to-list 'package-archives '("melpa" . "http://melpa.milkbox.net/packages/") t)

(setq x-select-enable-clipboard t)
(setq x-select-enable-primary t)
(column-number-mode t)
(line-number-mode t)
(global-auto-revert-mode t)

;; Use M-[ and M-] to navigate between errors
(global-set-key "\M-]" 'next-error)
(global-set-key "\M-[" 'previous-error)

;;
;; CMake
(load (expand-file-name "~/initfiles/elisp/cmake-init.el"))
(add-hook 'cmake-mode-hook 'common-source-file-hook)

;;
;; IAR C/C++ setup
(load (expand-file-name "~/initfiles/elisp/iar-init.el"))

;;
;; Use Flycheck wherever possible
(add-hook 'after-init-hook #'global-flycheck-mode)
