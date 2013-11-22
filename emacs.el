;;
;; New Emacs file.
;;
;; Intended for use with Emacs 24.x.
;;

;; Set up initfiles-dir to point to the location of this directory.
;; (setq initfiles-dir (file-name-directory load-file-name))

(setq initfiles-dir (expand-file-name "~/initfiles/"))

;;
;; Use separate custom files for Windows and Linux.
(cond
 ((eq window-system 'w32)
  (setq custom-file (concat initfiles-dir "elisp/emacs-custom-win32.el")))
 (t
  (setq custom-file (concat initfiles-dir "elisp/emacs-custom.el"))))

(load custom-file)

(add-to-list 'load-path (concat initfiles-dir "elisp"))

; (message load-path)

(require 'package)
(package-initialize)
(setq package-archives '(("gnu" . "http://elpa.gnu.org/packages/")
                         ("marmalade" . "http://marmalade-repo.org/packages/")
                         ("melpa" . "http://melpa.milkbox.net/packages/")))

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
;; Magit
(add-hook 'magit-mode-hook 'magit-load-config-extensions)
(add-hook 'magit-mode-hook 'turn-on-magit-svn)
(require 'magit-find-file)
(global-set-key (kbd "C-c p") 'magit-find-file-completing-read)

;;
;; CMake
(load "cmake-init")

;;
;; Erlang
(require 'erlang-start)

;;
;; Clang auto-format
(load "clang-format")
(global-set-key (kbd "C-c f") 'clang-format-buffer)

(defun clang-format-before-save ()
  (interactive)
  (when (or
	 (eq major-mode 'c++-mode) 
	 (eq major-mode 'c-mode)) 
    (clang-format-buffer)))

(defun enable-clang-completion-mode ()
  (clang-completion-mode))

;(add-hook 'c++-mode-hook 'enable-clang-completion-mode)
;(add-hook 'c-mode-hook 'enable-clang-completion-mode)

(add-to-list 'auto-mode-alist '("\\.h$" . c++-mode))
(add-to-list 'auto-mode-alist '("\\.CPP$" . c++-mode))
(add-to-list 'auto-mode-alist '("\\.H$" . c++-mode))
(add-to-list 'auto-mode-alist '("\\.rc$" . c++-mode))

;;
;; Clang completion-mode
(load "clang-completion-mode")

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
