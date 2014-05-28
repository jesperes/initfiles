;;
;; New Emacs file.
;;
;; Intended for use with Emacs 24.x.
;;
;; TODO is there a way to automatically install packages from this
;; file if the package is not already installed?
;;

;; Set up initfiles-dir to point to the location of this directory.
;; (setq initfiles-dir (file-name-directory load-file-name))

(cond ((file-exists-p (expand-file-name "~/initfiles/emacs.el"))
       (setq initfiles-dir (expand-file-name "~/initfiles/")))
      ((file-exists-p (expand-file-name "~/Documents/GitHub/initfiles/emacs.el"))
       (setq initfiles-dir (expand-file-name "~/Documents/GitHub/initfiles/")))
      (t
       (error "Cannot find initfiles directory.")))


;;
;; Use separate custom files for Windows and Linux.
(cond
 ((eq window-system 'w32)
  (setq custom-file (concat initfiles-dir "elisp/emacs-custom-win32.el")))
 (t
  (setq custom-file (concat initfiles-dir "elisp/emacs-custom.el"))))

(load custom-file)

(add-to-list 'load-path (concat initfiles-dir "elisp"))

(require 'package)
(setq package-list
      '(ack 
	cmake-mode
	erlang 
	flycheck 
	flymake-ruby
	flymake-yaml
	git-commit-mode 
	git-rebase-mode 
	google-this 
	magit 
	magit-filenotify 
	magit-find-file
	magit-log-edit
	magit-svn
	nlinum
	yaml-mode)) 
(setq package-archives '(("gnu" . "http://elpa.gnu.org/packages/")
                         ("marmalade" . "http://marmalade-repo.org/packages/")
                         ("melpa" . "http://melpa.milkbox.net/packages/")))
(package-initialize)
(when (not package-archive-contents)
  (package-refresh-contents))

(mapc (lambda (package)
	(or (package-installed-p package)
	    (package-install package)))
      package-list)

;;
;; Misc settings
(setq x-select-enable-clipboard t)
(setq x-select-enable-primary t)
(column-number-mode t)
(line-number-mode t)
(global-auto-revert-mode t)
(ansi-color-for-comint-mode-on)
;; (global-linum-mode t)

;; Use M-[ and M-] to navigate between errors
(global-set-key "\M-]" 'next-error)
(global-set-key "\M-[" 'previous-error)
(global-set-key "\M-r" 'recompile)

;;
;; Magit
(add-hook 'magit-mode-hook 'magit-load-config-extensions)
(add-hook 'magit-mode-hook 'turn-on-magit-svn)
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

;;
;; Clang completion-mode
(load "clang-completion-mode")
(defun enable-clang-completion-mode ()
  (clang-completion-mode))
;(add-hook 'c++-mode-hook 'enable-clang-completion-mode)
;(add-hook 'c-mode-hook 'enable-clang-completion-mode)

;;
;; Automatic modes
(add-to-list 'auto-mode-alist '("\\.h$" . c++-mode))
(add-to-list 'auto-mode-alist '("\\.CPP$" . c++-mode))
(add-to-list 'auto-mode-alist '("\\.H$" . c++-mode))
(add-to-list 'auto-mode-alist '("\\.rc$" . c++-mode))
(add-to-list 'auto-mode-alist '("\\.yaml$" . yaml-mode))
(add-to-list 'auto-mode-alist '("\\.irpspec$" . yaml-mode))

;;
;; Load IAR C/C++ formatting styles
(load "iar-init")

;;
;; Jump to source
(add-hook 'c-mode-common-hook
  (lambda() 
    (local-set-key  (kbd "C-x y") 'ff-find-other-file)))

;;
;; Flymake ruby/yaml
(add-hook 'yaml-mode-hook 'flymake-yaml-load)
(add-hook 'ruby-mode-hook 'flymake-ruby-load)

;;
;; nXML hook to make indentation work like Eclipse XML editors do by
;; default.
(add-hook 'nxml-mode-hook 
	  (lambda ()
	    (setq nxml-child-indent 4)
	    (setq tab-width 4)))

;;
;; Frame title
(setq frame-title-format (format "%%b - Emacs (%s)" system-type))

;;
;; Make buffer names unique
(setq uniquify-buffer-name-style 'post-forward-angle-brackets)

;;
;; Show parenthesis
(show-paren-mode 1)
(setq show-paren-delay 0)

;;
;; DOS mode
(load "dos")
(add-to-list 'auto-mode-alist '("\\.bat" . dos-mode))

;;
;; Uniquify
(require 'uniquify)

;;
;; AUCTeX
(load "auctex")
(setq TeX-auto-save t)
(setq TeX-parse-self t)
(setq-default TeX-master nil)
