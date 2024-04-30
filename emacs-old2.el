;;; emacs.el --- My .emacs
;;; Commentary:
;;; Code:

;; Keep custom-set-* in separate files
(setq custom-file
      (concat
       (file-name-directory (file-truename load-file-name))
       "elisp/emacs-custom.el"))
(load custom-file)

;; Initialize package management. When starting Emacs on a new machine
;; (without a .emacs.d), this code does not work straight away, but
;; requires a few restarts.
;; (setq gnutls-algorithm-priority "NORMAL:-VERS-TLS1.3")
(require 'package)
;; (add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/"))
;; (add-to-list 'package-archives '("elpa" . "http://elpa.gnu.org/packages/"))
(setq package-check-signature nil)
(setq package-install-upgrade-built-in t)
(package-install
 'seq
 'magit
 'vscode-dark-plus-theme)
(load-theme 'vscode-dark-plus t)

;; ;; Misc settings
;; (setq select-enable-clipboard t)
;; (setq select-enable-primary t)
;; (column-number-mode t)
;; (line-number-mode t)
;; (global-auto-revert-mode t)
;; (ansi-color-for-comint-mode-on)
;; (setq vc-follow-symlinks t)

;; ;; Use M-[ and M-] to navigate between errors
;; (global-set-key "\M-]" 'next-error)
;; (global-set-key "\M-[" 'previous-error)
;; (global-set-key "\M-r" 'recompile)
;; (global-set-key [f2] 'lsp-rename)

;; ;; Magit
;; (use-package magit)
;; (add-hook 'magit-mode-hook 'magit-load-config-extensions)
;; (global-set-key (kbd "C-x g") 'magit-status)
;; (add-hook 'before-save-hook 'delete-trailing-whitespace)
;; (add-hook 'magit-mode-hook (lambda () (magit-delta-mode +1)))

;; ;; Erlang
;; (use-package erlang)
;; (setq erlang-indent-level 2)
;; (setq inferior-erlang-machine "erl")
;; (setq erlang-skel-mail-address "jesper.eskilson@klarna.com")
;; (add-to-list 'auto-mode-alist '("rebar\\.config.*" . erlang-mode))
;; (add-to-list 'auto-mode-alist '(".*\\.eterm$" . erlang-mode))
;; (add-to-list 'auto-mode-alist '(".*sys\\.config.*$" . erlang-mode))
;; (add-to-list 'auto-mode-alist '("Emakefile" . erlang-mode))
;; (add-to-list 'auto-mode-alist '(".*\\.pl$" . prolog-mode))
;; (add-hook 'erlang-mode-hook
;;           (lambda () (local-set-key(setq package-install-upgrade-built-in t)
;;                       (kbd "<f1>")
;;                       #'erlang-man-function-no-prompt)))

;; ;; Kred stuff
;; (setq compile-command "source ~/otp-install/OTP-26.2/activate && QUIET=t make -C ~/src/kc/kred myday ")

;; ;; -- LSP support --
;; ;; (use-package lsp-mode
;; ;;   :custom
;; ;;   (lsp-semantic-tokens-enable t)

;; ;;   :config
;; ;;   ;; Enable LSP automatically for Erlang files
;; ;;   (add-hook 'erlang-mode-hook #'lsp)

;; ;;   ;; ELP, added as priority 0 (> -1) so takes priority over the built-in one
;; ;;   (lsp-register-client
;; ;;    (make-lsp-client :new-connection (lsp-stdio-connection '("elp" "server"))
;; ;;                     :major-modes '(erlang-mode)
;; ;;                     :priority 0
;; ;;                     :server-id 'erlang-language-platform))
;; ;;   )

;; ;; LSP performance tweaks
;; ;; (setq gc-cons-threshold 100000000)
;; ;; (setq read-process-output-max (* 1024 1024)) ;; 1mb

;; (use-package spinner)
;; (use-package lsp-mode)
;; (use-package lsp-ui)
;; (use-package lsp-treemacs)
;; (use-package company)
;; (use-package helm)
;; (use-package helm-company)
;; (use-package helm-lsp)
;; ;(use-package yasnippet)
;; ;(use-package yasnippet-snippets)

;; ; (yas-global-mode 1)

;; ;; For git branchs which have a jira-like ticket, insert the ticket id
;; ;; first in the commit message (if it is not already there).
;; (add-hook
;;  'git-commit-setup-hook
;;  (lambda ()
;;    (let ((issue-key "[[:alpha:]]+-[[:digit:]]+")
;;          (branch (magit-get-current-branch)))

;;      ;; Do nothing if branch does not have an issue key
;;      (when (string-match-p issue-key branch)

;;        ;; Create commit-prefix by using the issue key in the branch
;;        ;; name + trailing space
;;        (let ((commit-prefix (replace-regexp-in-string
;;                              (concat ".*?\\(" issue-key "\\).*")
;;                              "\\1 "
;;                              branch)))

;;          ;; Insert commit prefix if it is not already there
;;          ;; (e.g. amending will prefill the buffer with the last
;;          ;; commit message)
;;          (when (not (string-prefix-p commit-prefix (buffer-string)))
;;            (insert commit-prefix))

;;          ;; Move point to the first char in the actual commit message
;;          (goto-char (+ (point-min)
;;                        (string-width commit-prefix))))))))

;; ;; (setq lsp-log-io t)
;; (setq lsp-ui-doc-enable t)
;; (setq lsp-ui-doc-position 'bottom)
;; (setq lsp-ui-sideline-enable nil)
;; (setq lsp-enable-snippet nil)
;; ;; (setq company-lsp-enable-snippet t)
;; (setq lsp-enable-file-watchers nil)
;; (setq lsp-keymap-prefix "C-c l")
;; (setq lsp-headerline-breadcrumb-enable t)

;; ;;(use-package dap-mode)
;; ;;(use-package dap-erlang)
;; ;;(dap-ui-mode 1)
;; ;;(dap-tooltip-mode 1)
;; ;;(dap-ui-controls-mode 1)
;; ;;(setq dap-auto-configure-features '(sessions locals controls tooltip))

;; (use-package company-quickhelp)
;; ; (company-quickhelp-mode)

;; (add-hook 'erlang-mode-hook #'lsp)
;; (add-hook 'c-mode-hook #'lsp)
;; ;(require 'lsp-groovy)
;; ;(add-hook 'groovy-mode-hook #'lsp)
;; ;(setq lsp-groovy-classpath ["/usr/share/groovy/lib"])

;; (add-hook 'after-init-hook 'global-company-mode)

;; (setq lsp-keymap-prefix "M-l")

;; (global-set-key (kbd "M-/") 'company-complete)
;; (global-set-key (kbd "<f3>") 'xref-find-definitions)
;; (global-set-key (kbd "<f7>") 'ag)
;; (global-set-key (kbd "S-<f7>") 'ag-regexp)
;; (global-set-key (kbd "M-<left>") 'xref-pop-marker-stack)
;; (global-set-key (kbd "C-S-g") 'xref-find-references)

;; ;; (global-set-key (kbd "C-S-g") 'lsp-treemacs-references)

;; ;; (use-package exec-path-from-shell)
;; ;; (exec-path-from-shell-initialize)

;; ;; No tab indents
;; (setq indent-tabs-mode nil)

;; ;; Show parenthesis
;; (show-paren-mode 1)

;; ;; ;; Uniquify
;; ;; (require 'uniquify)
;; ;; (setq uniquify-buffer-name-style 'post-forward-angle-brackets)

;; ;; ;; Windmove
;; ;; (windmove-default-keybindings)

;; ;; ;; Always use y or n
;; ;; (defalias 'yes-or-no-p 'y-or-n-p)

;; ;; (use-package markdown-mode)
;; ;; (use-package ag)
;; ;; (use-package yaml-mode)
;; ;; (use-package groovy-mode)
;; ;; (use-package dockerfile-mode)

;; ;; (setq groovy-indent-offset 4)

;; ;; ;(use-package which-key
;; ;; ;  :config
;; ;; ;  (which-key-mode))

;; ;; ;; Highlight text beyond 80 columns
;; ;; ;; (require 'whitespace)
;; ;; ;; (setq whitespace-style
;; ;; ;;       '(face
;; ;; ;;  	;;tabs
;; ;; ;;  	lines-tail
;; ;; ;;  	;;space-after-tab
;; ;; ;;  	;;space-before-tab
;; ;; ;;  	))
;; ;; ;; (setq whitespace-line-column 100)

;; ;; ;; (add-hook 'erlang-mode-hook 'whitespace-mode)
;; ;; ;; (add-hook 'emacs-mode-hook 'whitespace-mode)
;; ;; ;; (add-hook 'sh-mode-hook 'whitespace-mode)
;; ;; ;; (add-hook 'yaml-mode-hook 'whitespace-mode)

;; ;; ;; For font scaling C-{+,-}
;; ;; ;; https://www.emacswiki.org/emacs/GlobalTextScaleMode
;; ;; (define-globalized-minor-mode
;; ;;   global-text-scale-mode
;; ;;   text-scale-mode
;; ;;   (lambda () (text-scale-mode 1)))

;; ;; (defun global-text-scale-adjust (inc)
;; ;;   "Adjust font size by INC."
;; ;;   (interactive)
;; ;;   (text-scale-set 1)
;; ;;   (kill-local-variable 'text-scale-mode-amount)
;; ;;   (setq-default text-scale-mode-amount (+ text-scale-mode-amount inc))
;; ;;   (global-text-scale-mode 1))

;; ;; (global-set-key (kbd "C-0")
;; ;;                 '(lambda () (interactive)
;; ;;                    (global-text-scale-adjust (- text-scale-mode-amount))
;; ;;                    (global-text-scale-mode -1)))
;; ;; (global-set-key (kbd "C-+")
;; ;;                 '(lambda () (interactive) (global-text-scale-adjust 0.5)))
;; ;; (global-set-key (kbd "C--")
;; ;;                 '(lambda () (interactive) (global-text-scale-adjust -0.5)))

;; ;; ;; Ido
;; ;; (use-package ido)
;; ;; (use-package ido-vertical-mode)
;; ;; (require 'ido-completing-read+)
;; ;; (require 'ido-vertical-mode)
;; ;; (setq ido-enable-flex-matching t)
;; ;; (setq ido-everywhere t)
;; ;; (ido-mode 1)
;; ;; (ido-vertical-mode 1)
;; ;; (ido-ubiquitous-mode 1)
;; ;; (setq ido-vertical-show-count t)
;; ;; (setq ido-vertical-define-keys 'C-n-C-p-up-and-down)

;; ;; ;; This is the closest thing Emacs has to Eclipse "Find Resource...".
;; ;; (use-package find-file-in-project)
;; ;; (require 'find-file-in-project)
;; ;; (add-to-list 'ffip-prune-patterns "*/ct_run*")
;; ;; (add-to-list 'ffip-prune-patterns "*/logs")
;; ;; (add-to-list 'ffip-prune-patterns "*/build")
;; ;; (add-to-list 'ffip-prune-patterns "*/_build")
;; ;; (add-to-list 'ffip-prune-patterns "*/.jenkins")
;; ;; (add-to-list 'ffip-prune-patterns "*/system/db")
;; ;; (add-to-list 'ffip-prune-patterns "*/system/leveldb")
;; ;; (add-to-list 'ffip-prune-patterns "*/.eunit")
;; ;; (setq ffip-ignore-filenames '("*.beam" "*.o" "*~"))
;; ;; (global-set-key (kbd "C-S-r") 'find-file-in-project)

;; ;; (global-linum-mode t)

;; ;; (defun new-work-note ()
;; ;;   "Add a timestamped section to current buffer."
;; ;;   (interactive)
;; ;;   (insert (shell-command-to-string "printf \"## %s: \" \"$(date +'%F (%A %R)')\"")))
;; ;; (global-set-key (kbd "C-S-n") 'new-work-note)

;; ;; (setq split-height-threshold 1200)
;; ;; (setq split-width-threshold 2000)

;; ;; ;; Flycheck
;; ;; (use-package flycheck
;; ;;   :ensure t
;; ;;   :init (global-flycheck-mode))

;; ;; (require 'ansi-color)

;; ;; ;; .dot files
;; ;; (use-package graphviz-dot-mode :ensure t)

;; ;; ;; LSP mode for Python
;; ;; ;; (use-package lsp-python-ms
;; ;; ;;   :ensure t
;; ;; ;;   :init (setq lsp-python-ms-auto-install-server t)
;; ;; ;;   :hook (python-mode . (lambda ()
;; ;; ;;                           (require 'lsp-python-ms)
;; ;; ;;                           (lsp))))  ; or lsp-deferred

;; ;; ;; (setq lsp-python-ms-auto-install-server t)
;; ;; ;; (add-hook 'python-mode-hook #'lsp) ; or lsp-deferred

;; ;; (provide 'emacs)

;; ;; (setq sh-basic-offset 4)

;; ;; ;;; emacs.el ends here
