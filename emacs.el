;;
;; When setting up a new machine, clone the initfiles git repo and
;; create a symlink $HOME/.emacs to this file.
;;
;; The first time, Emacs will spend quite a bit of time installing
;; packages.
;;

;; Set up initfiles-dir to point to the location of this directory.
(setq initfiles-dir (file-name-directory (file-truename load-file-name)))
(message (format "Init files dir: %s" initfiles-dir))

;; Use separate custom files for Windows and Linux.
(cond
 ((eq window-system 'w32)
  (setq custom-file-name "emacs-custom-win32.el"))
 (t
  (setq custom-file-name "emacs-custom.el")))

(setq custom-file (concat initfiles-dir "elisp/" custom-file-name))
(load custom-file)

;; Put elisp dir into load-path
(add-to-list
 'load-path
 (concat initfiles-dir "elisp"))

(require 'package)

(package-initialize)
(setq package-archives
      '(("gnu" . "http://elpa.gnu.org/packages/")
	("marmalade" . "https://marmalade-repo.org/packages/")
	("melpa" . "http://melpa.org/packages/")))

(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

(require 'use-package)
(setq use-package-always-ensure t)

;; Misc settings
(setq x-select-enable-clipboard t)
(setq x-select-enable-primary t)
(column-number-mode t)
(line-number-mode t)
(global-auto-revert-mode t)
(ansi-color-for-comint-mode-on)
(setq vc-follow-symlinks t)

;; Use M-[ and M-] to navigate between errors
(global-set-key "\M-]" 'next-error)
(global-set-key "\M-[" 'previous-error)
(global-set-key "\M-r" 'recompile)

;; Magit
(use-package magit)
;; (use-package magit-filenotify)
(add-hook 'magit-mode-hook 'magit-load-config-extensions)
(global-set-key (kbd "C-x g") 'magit-status)
;; (add-hook 'magit-status-mode-hook 'magit-filenotify-mode)

;; Company-mode
(use-package company)
(add-hook 'after-init-hook 'global-company-mode)
(setq company-idle-delay 0)
(setq company-backends (delete 'company-semantic company-backends))

;; Erlang
(use-package erlang)
(require 'erlang-start)
;; (setq erlang-root-dir "/home/jesperes/dev/otp/install")
(setq inferior-erlang-machine "/home/jesperes/dev/otp-install/otp-19/bin/erl")
;; (setq erlang-indent-level 2)

;(use-package ivy-erlang-complete)
;(require 'ivy-erlang-complete)
;(add-hook 'erlang-mode-hook #'ivy-erlang-complete-init)
;(add-hook 'after-save-hook #'ivy-erlang-complete-reparse)
;(setq ivy-erlang-complete-set-project-root "/home/jesperes/dev/kred")

;; Line-numbers
;; (add-hook 'erlang-mode-hook 'nlinum-mode)

;; No tab indents
(setq indent-tabs-mode nil)

;; Jump to source
(add-hook 'c-mode-common-hook
  (lambda()
    (local-set-key  (kbd "C-x y") 'ff-find-other-file)))

;; nXML hook to make indentation work like Eclipse XML editors do by
;; default.
(add-hook 'nxml-mode-hook
	  (lambda ()
	    (setq nxml-child-indent 4)
	    (setq tab-width 4)))

;; Frame title
(setq frame-title-format (format "%%b - Emacs (%s)" system-type))

;; Show parenthesis
(show-paren-mode 1)
(setq show-paren-delay 0)

;; Uniquify
(require 'uniquify)
(setq uniquify-buffer-name-style 'post-forward-angle-brackets)

;; Windmove
(windmove-default-keybindings)

;; Always use y or n
(defalias 'yes-or-no-p 'y-or-n-p)

;; Neotree
(use-package neotree)

;; markdown
(use-package markdown-mode)

;; Silver Searcher (ag)
(use-package ag)

;; Highlight text beyond 80 columns
;; (require 'whitespace)
;; (setq whitespace-style
;;       '(face
;; 	;;tabs
;; 	lines-tail
;; 	;;space-after-tab
;; 	;;space-before-tab
;; 	))
;; (setq whitespace-line-column 80)

;(add-hook 'erlang-mode-hook 'whitespace-mode)
;(add-hook 'emacs-mode-hook 'whitespace-mode)
;(add-hook 'sh-mode-hook 'whitespace-mode)
;(add-hook 'yaml-mode-hook 'whitespace-mode)

;; Flycheck
;; (use-package flycheck)
;; (global-flycheck-mode t)

;(add-hook 'after-init-hook 'my-after-init-hook)
;(defun my-after-init-hook ()
;  (require 'edts-start))
