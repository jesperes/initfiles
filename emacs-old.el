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

(setq gnutls-algorithm-priority "NORMAL:-VERS-TLS1.3")

(require 'package)
(setq package-check-signature nil)
(add-to-list 'package-archives
             '("melpa" . "https://melpa.org/packages/") t)
(package-initialize)

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
(add-hook 'magit-mode-hook 'magit-load-config-extensions)
(global-set-key (kbd "C-x g") 'magit-status)
(add-hook 'before-save-hook 'delete-trailing-whitespace)

;; Erlang
(use-package erlang)
(require 'erlang-start)
(setq erlang-indent-level 2)
(setq inferior-erlang-machine "/home/jesperes/dev/otp-install/otp-20/bin/erl")
(setq erlang-skel-mail-address "jesper.eskilson@klarna.com")

(add-to-list 'auto-mode-alist '("sys\\.config$" . erlang-mode))
(add-to-list 'auto-mode-alist '("\\.eterm$" . erlang-mode))
(add-to-list 'auto-mode-alist '("\\.terms$" . erlang-mode))
(add-to-list 'auto-mode-alist '("rebar\\.config$" . erlang-mode))
(add-to-list 'auto-mode-alist '("rebar\\.config\\.script$" . erlang-mode))

;; Pascal :)
(add-to-list 'auto-mode-alist '("\\.pp$" . pascal-mode))

;; No tab indents
(setq indent-tabs-mode nil)

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

(use-package neotree)
(global-set-key [f8] 'neotree-toggle)
(setq neotree-smart-open t)
(setq neotree-autorefresh t)

(use-package markdown-mode)
(use-package ag)
(use-package yaml-mode)
;; (use-package groovy-mode)
(use-package dockerfile-mode)

;; Highlight text beyond 80 columns
(require 'whitespace)
(setq whitespace-style
      '(face
	;;tabs
	lines-tail
	;;space-after-tab
	;;space-before-tab
	))
(setq whitespace-line-column 80)

(add-hook 'erlang-mode-hook 'whitespace-mode)
(add-hook 'emacs-mode-hook 'whitespace-mode)
(add-hook 'sh-mode-hook 'whitespace-mode)
(add-hook 'yaml-mode-hook 'whitespace-mode)

;; Flycheck
;; (use-package flycheck)
;; (global-flycheck-mode t)

;; Groovy
(add-to-list 'load-path "/home/jesperes/groovy-emacs-modes")
(autoload 'groovy-mode "groovy-mode" "Major mode for editing Groovy code." t)
(add-to-list 'auto-mode-alist '("\\.groovy\\'" . groovy-mode))

;; https://www.emacswiki.org/emacs/GlobalTextScaleMode
(define-globalized-minor-mode
  global-text-scale-mode
  text-scale-mode
  (lambda () (text-scale-mode 1)))

(defun global-text-scale-adjust (inc) (interactive)
       (text-scale-set 1)
       (kill-local-variable 'text-scale-mode-amount)
       (setq-default text-scale-mode-amount (+ text-scale-mode-amount inc))
       (global-text-scale-mode 1)
       )

(global-set-key (kbd "C-0")
                '(lambda () (interactive)
                   (global-text-scale-adjust (- text-scale-mode-amount))
                   (global-text-scale-mode -1)))
(global-set-key (kbd "C-+")
                '(lambda () (interactive) (global-text-scale-adjust 0.5)))
(global-set-key (kbd "C--")
                '(lambda () (interactive) (global-text-scale-adjust -0.5)))

;; This is the closest thing Emacs has to Eclipse "Find Resource...".
(require 'find-file-in-project)
(add-to-list 'ffip-prune-patterns "*/ct_run")
(add-to-list 'ffip-prune-patterns "*/logs")
(add-to-list 'ffip-prune-patterns "*/build")
(add-to-list 'ffip-prune-patterns "*/.jenkins")
(setq ffip-ignore-filenames '("*.beam" "*.o"))
(setq ffip-ignore-filenames '("*.beam" "*.o" "*~"))
(global-set-key (kbd "C-S-r") 'find-file-in-project)

(use-package ido)
(use-package ido-vertical-mode)
(require 'ido-vertical-mode)
(setq ido-enable-flex-matching t)
(setq ido-everywhere t)
(ido-mode 1)
(ido-vertical-mode 1)
(setq ido-vertical-show-count t)
(setq ido-vertical-define-keys 'C-n-C-p-up-and-down)

;; Require the official lsp-mode package
(use-package lsp-mode)
(use-package lsp-ui)
(use-package company)
(use-package company-lsp)
(use-package helm)
(use-package helm-company)
(use-package helm-lsp)
(use-package yasnippet)

(push 'company-lsp company-backends)

(setq lsp-log-io t)
(setq lsp-ui-doc-enable t)
(setq lsp-ui-sideline-enable nil)
(setq company-lsp-enable-snippet t)

(add-hook 'erlang-mode-hook #'lsp)
(add-hook 'after-init-hook 'global-company-mode)

(global-set-key (kbd "M-/") 'company-complete)
(global-set-key (quote [f3]) 'xref-find-definitions)

(use-package exec-path-from-shell)
(exec-path-from-shell-initialize)

(global-linum-mode t)

(defun new-work-note ()
  (interactive)
  (insert (shell-command-to-string "printf \"## %s: \" \"$(date +'%F (%A %R)')\"")))
(global-set-key (kbd "C-S-n") 'new-work-note)
