;;
;; Emacs dot init, assumed to be located under $HOME/Dropbox/init.
;;
;; When setting up a new machine, load this file from whatever the
;; default .emacs is.
;;

(defun expand-initdir (dir)
  (format "%s/Dropbox/init/%s" (getenv "HOME") dir))

;; (add-to-list 'load-path "~/.emacs.d")

(cond
 ((eq window-system 'w32)
  (setq custom-file (expand-initdir "elisp/emacs-custom-win32.el")))
 (t
  (setq custom-file (expand-initdir "elisp/emacs-custom.el"))))

(message (format "Custom file: %s" custom-file))
(load custom-file)

(setq is_win32 nil)
(if (eq window-system 'w32)
    (setq is_win32 t))

(add-to-list 'load-path (expand-initdir "elisp"))

(display-time)
;; (setq compilation-scroll-output t)

(global-set-key "\M-]" 'next-error)
(global-set-key "\M-[" 'previous-error)

;(require 'ido)
;(ido-mode t)
;(setq ido-enable-flex-matching t) ;; enable fuzzy matching
;(setq ido-decorations
;      (quote ("\n-> " "" "\n   " "\n   ..." "[" "]" " [No match]" " [Matched]" " [Not readable]" " [Too big]" " [Confirm]")))

(require 'column-marker)
(require 'color-theme)
;; (color-theme-subtle-hacker)
(color-theme-emacs-21)

;; Common hook for all source files
(defun common-source-file-hook ()
  ;; (setq show-trailing-whitespace t)
  ;; (indent-buffer-timer-start)
  ;; (add-hook 'before-save-hook 'delete-trailing-whitespace)
  (column-marker-1 79))
  
(require 'compile)
(require 'cl)
(require 'uniquify)

(global-set-key "\M-r" 'recompile)
(ansi-color-for-comint-mode-on)

(setq frame-title-format (format "%%b - Emacs (%s)" system-type))


;; Autoload modes for some languages
(autoload 'python-mode "python-mode" "Python editing mode." t)
(autoload 'ruby-mode "ruby-mode" "Load ruby-mode")
(autoload 'yaml-mode "yaml-mode" "Load yaml-mode")

(require 'protobuf-mode)

;; Modes for certain files
(add-to-list 'auto-mode-alist '("\\.proto$" . protobuf-mode))
(add-to-list 'auto-mode-alist '("\\.py$" . python-mode))
(add-to-list 'auto-mode-alist '("\\.rb$" . ruby-mode))
(add-to-list 'auto-mode-alist '("\\.h$" . c++-mode))
(add-to-list 'auto-mode-alist '("\\.CPP$" . c++-mode))
(add-to-list 'auto-mode-alist '("\\.H$" . c++-mode))
(add-to-list 'auto-mode-alist '("\\.rc$" . c++-mode))
(add-to-list 'auto-mode-alist '("\\.yml$" . yaml-mode))
(add-to-list 'auto-mode-alist '("\\.yaml$" . yaml-mode))
(add-to-list 'auto-mode-alist '("\\.irpspec$" . yaml-mode))
(add-to-list 'auto-mode-alist '("\\.cfp$" . shell-script-mode))
;; (add-to-list 'auto-mode-alist '("\\.wiki" . wikipedia-mode))
;; (add-to-list 'auto-mode-alist '("\\.xml" . nxml-mode))

(column-number-mode t)
(line-number-mode t)
(global-auto-revert-mode t)

(global-set-key "\M-g" 'goto-line
(global-set-key "\M-d" 'delete-horizontal-space)

;; Ruby-mode redefines M-BS, which is very annoying
(add-hook 'ruby-mode-hook
          (lambda ()
            (define-key ruby-mode-map [(meta backspace)]
              'backward-kill-word)))

;; sourcepair.el: support for switching between header files and
;; source files
(load "sourcepair.el")
(define-key global-map "\C-xy" 'sourcepair-load)
(setq sourcepair-source-path    '( "." "../*" ))
(setq sourcepair-header-path    '( "." "include"
                                   "../include"
                                   "../*"
                                   "../../include"))

(require 'cc-styles)

(c-add-style "iar"
             '((c-basic-offset . 2)
               (comment-column . 45)
               (c-offsets-alist . ((substatement-open . 0)
                                   (statement-case-open . +)
                                   (inline-open . 0)
                                   (label . 0)))
               (indent-tabs-mode . nil)))

(c-add-style "iar-java"
             '((c-basic-offset . 4)
               (indent-tabs-mode . nil)))

(setq c-default-style "iar")

(defun my-c-mode-common-hook ()
  (common-source-file-hook))

(defun my-java-mode-common-hook ()
  (common-source-file-hook)
  (c-set-style "iar-java"))

(defun my-yaml-mode-hook ()
  (setq indent-tabs-mode nil))

(add-hook 'c-mode-common-hook 'my-c-mode-common-hook)
(add-hook 'java-mode-hook 'my-java-mode-common-hook)
(add-hook 'yaml-mode-hook 'my-yaml-mode-hook)

(add-hook 'ruby-mode-hook
          (lambda ()
            (progn
              (common-source-file-hook)
              (setq indent-tabs-mode nil))))

(add-hook 'python-mode-hook 'common-source-file-hook)
(add-hook 'shell-script-mode-hook 'common-source-file-hook)
(add-hook 'emacs-lisp-mode-hook 'common-source-file-hook)

(autoload 'bat-mode "dosbat" t nil)
(add-to-list 'auto-mode-alist '("\\.\\(?:bat\\|com\\)$" . bat-mode))

(require 'magit)
(require 'magit-svn)
