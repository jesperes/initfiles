
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

;; Use M-[ and M-] to navigate between errors
(global-set-key "\M-]" 'next-error)
(global-set-key "\M-[" 'previous-error)
(global-set-key "\M-r" 'recompile)

;; Magit
(add-hook 'magit-mode-hook 'magit-load-config-extensions)
(global-set-key (kbd "C-x g") 'magit-status)
(add-hook 'magit-status-mode-hook 'magit-filenotify-mode)
(add-hook 'magit-mode-hook 'magit-svn-mode)

;; CMake
(use-package cmake-mode)
(use-package cmake-font-lock)

;; Erlang
(use-package erlang)
(require 'erlang-start)

;; Automatic modes
(add-to-list 'auto-mode-alist '("\\.h$" . c++-mode))
(add-to-list 'auto-mode-alist '("\\.CPP$" . c++-mode))
(add-to-list 'auto-mode-alist '("\\.H$" . c++-mode))
(add-to-list 'auto-mode-alist '("\\.rc$" . c++-mode))
(add-to-list 'auto-mode-alist '("\\.yaml$" . yaml-mode))
(add-to-list 'auto-mode-alist '("\\.irpspec$" . yaml-mode))

;; Line-numbers
;(add-hook 'c++-mode-hook 'nlinum-mode)
;(add-hook 'c-mode-hook 'nlinum-mode)
;(add-hook 'ruby-mode-hook 'nlinum-mode)
;(add-hook 'erlang-mode-hook 'nlinum-mode)
;(add-hook 'nxml-mode-hook 'nlinum-mode)
;(add-hook 'js-mode-hook 'nlinum-mode)

;; No tabs in Javascript
(add-hook 'js-mode-hook
	  (lambda ()
	    (setq indent-tabs-mode nil)))

;; Load IAR C/C++ formatting styles
(load "iar-init")

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

;; Make buffer names unique
(setq uniquify-buffer-name-style 'post-forward-angle-brackets)

;; Show parenthesis
(show-paren-mode 1)
(setq show-paren-delay 0)

;; DOS mode
(load "dos")
(add-to-list 'auto-mode-alist '("\\.bat" . dos-mode))

;; Uniquify
(require 'uniquify)

;; AUCTeX
;; (use-package auctex)

;; dsvn
(autoload 'svn-status "dsvn" "Run `svn status'." t)
(autoload 'svn-update "dsvn" "Run `svn update'." t)
(require 'vc-svn)

;; full-ack
(autoload 'ack-same "full-ack" nil t)
(autoload 'ack "full-ack" nil t)
(autoload 'ack-find-same-file "full-ack" nil t)
(autoload 'ack-find-file "full-ack" nil t)

;; Windmove
(windmove-default-keybindings)

;; Fill column indicator
;;(use-package fill-column-indicator)
;;(add-hook 'c-mode-hook 'fci-mode)
;;(add-hook 'c++-mode-hook 'fci-mode)
;;(add-hook 'ruby-mode-hook 'fci-mode)
;;(add-hook 'emacs-lisp-mode-hook 'fci-mode)

;; Always use y or n
(defalias 'yes-or-no-p 'y-or-n-p)

;; Show trailing whitespace
(setq whitespace-style '(face trailing))

;; Neotree
;; (use-package neotree)
