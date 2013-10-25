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
(ansi-color-for-comint-mode-on)
(global-linum-mode t)

;; Use M-[ and M-] to navigate between errors
(global-set-key "\M-]" 'next-error)
(global-set-key "\M-[" 'previous-error)
(global-set-key "\M-r" 'recompile)

;;
;; CMake
(load (expand-file-name "~/initfiles/elisp/cmake-init.el"))
(add-hook 'cmake-mode-hook 'common-source-file-hook)

;;
;; Clang auto-format
(load (expand-file-name "~/initfiles/elisp/clang-format.el"))
(global-set-key (kbd "C-c f") 'clang-format-buffer)

(defun clang-format-before-save ()
  (interactive)
  (when (or 
	 (eq major-mode 'c++-mode) 
	 (eq major-mode 'c-mode)) 
    (clang-format-buffer)))
;; (add-hook 'before-save-hook 'clang-format-before-save)

;;
;; Clang completion-mode
(load-library (expand-file-name "~/initfiles/elisp/clang-completion-mode"))

;;
;; Use Flycheck wherever possible
;;(require 'flycheck)
;;(add-hook 'after-init-hook #'global-flycheck-mode)

;;
;; Frame title
(setq frame-title-format (format "%%b - Emacs (%s)" system-type))

;;
;; Make buffer names unique
(require 'uniquify)
(setq uniquify-buffer-name-style 'post-forward-angle-brackets)

;;
;; Show parenthesis
(show-paren-mode 1)
(setq show-paren-delay 0)
