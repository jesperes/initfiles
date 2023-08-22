(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(Man-width 120)
 '(ansi-color-faces-vector
   [default default default italic underline success warning error])
 '(ansi-color-names-vector
   ["#2d3743" "#ff4242" "#74af68" "#dbdb95" "#34cae2" "#008b8b" "#00ede1" "#e1e1e0"])
 '(blink-cursor-mode nil)
 '(column-number-mode t)
 '(company-quickhelp-color-background "grey20")
 '(company-quickhelp-color-foreground "grey70")
 '(company-quickhelp-delay 0)
 '(company-quickhelp-mode t)
 '(company-quickhelp-use-propertized-text t)
 '(company-show-numbers (quote (quote t)))
 '(company-show-quick-access (quote (quote t)))
 '(compilation-always-kill t)
 '(compilation-ask-about-save nil)
 '(compilation-auto-jump-to-first-error nil)
 '(compilation-message-face (quote default))
 '(compilation-scroll-output t)
 '(custom-enabled-themes (quote (vscode-dark-plus)))
 '(custom-safe-themes
   (quote
    ("b9a67b48d56c580cb300ce9c1ecc3b83aee953346a33e2a14b31e2e4a07ea8a6" default)))
 '(display-time-24hr-format t)
 '(display-time-mode t)
 '(erlang-electric-newline-inhibit nil)
 '(fci-rule-color "#14151E")
 '(flycheck-checkers
   (quote
    (lsp ada-gnat asciidoctor asciidoc awk-gawk bazel-buildifier c/c++-clang c/c++-gcc c/c++-cppcheck cfengine chef-foodcritic coffee coffee-coffeelint coq css-csslint css-stylelint cuda-nvcc cwl d-dmd dockerfile-hadolint elixir-credo emacs-lisp emacs-lisp-checkdoc ember-template erlang eruby-erubis eruby-ruumba fortran-gfortran go-gofmt go-golint go-vet go-build go-test go-errcheck go-unconvert go-staticcheck groovy haml handlebars haskell-stack-ghc haskell-ghc haskell-hlint html-tidy javascript-eslint javascript-jshint javascript-standard json-jsonlint json-python-json json-jq jsonnet less less-stylelint llvm-llc lua-luacheck lua markdown-markdownlint-cli markdown-mdl nix nix-linter opam perl perl-perlcritic php php-phpmd php-phpcs processing proselint protobuf-protoc protobuf-prototool pug puppet-parser puppet-lint python-flake8 python-pylint python-pycompile python-pyright python-mypy r-lintr racket rpm-rpmlint rst-sphinx rst ruby-rubocop ruby-standard ruby-reek ruby-rubylint ruby ruby-jruby rust-cargo rust rust-clippy scala scala-scalastyle scheme-chicken scss-lint scss-stylelint sass/scss-sass-lint sass scss sh-bash sh-zsh sh-shellcheck slim slim-lint sql-sqlint systemd-analyze tcl-nagelfar terraform terraform-tflint tex-chktex tex-lacheck texinfo textlint typescript-tslint verilog-verilator vhdl-ghdl xml-xmlstarlet xml-xmllint yaml-jsyaml yaml-ruby yaml-yamllint)))
 '(groovy-indent-offset 2)
 '(ido-enable-prefix nil)
 '(ido-rotate-file-list-default nil)
 '(indent-tabs-mode nil)
 '(inhibit-startup-screen t)
 '(lsp-lens-auto-enable t)
 '(lsp-lens-enable t)
 '(lsp-semantic-highlighting :immediate)
 '(lsp-ui-doc-alignment (quote window))
 '(lsp-ui-doc-border "gray12")
 '(lsp-ui-doc-header t)
 '(lsp-ui-doc-position (quote top))
 '(lsp-ui-flycheck-enable t)
 '(lsp-ui-sideline-show-code-actions t)
 '(lsp-ui-sideline-show-hover nil)
 '(lsp-ui-sideline-show-symbol t)
 '(lsp-ui-sideline-update-mode (quote line))
 '(magit-refresh-verbose t)
 '(package-selected-packages
   (quote
    (dap-mode lsp-mode vscode-icon ivy-erlang-complete lsp-ui vscode-dark-plus-theme company-quickhelp ido-completing-read+ find-file-in-repository jq-mode lsp-python-ms flycheck-rust atom-dark-theme arc-dark-theme anti-zenburn-theme ample-theme ample-zen-theme afternoon-theme graphviz-dot-mode helm-lsp lsp-treemacs groovy-mode yasnippet-snippets magit-delta magit-filenotify magit-tbdiff magit-todos which-key company-lsp spinner company-capf flycheck rust-mode ido-vertical-mode find-file-in-project dockerfile-mode yaml-mode ag neotree exec-path-from-shell yasnippet helm-company helm company erlang magit use-package)))
 '(read-file-name-completion-ignore-case t)
 '(ring-bell-function (quote ignore))
 '(safe-local-variable-values (quote ((allout-mode . t) (allout-layout . t))))
 '(scroll-bar-mode nil)
 '(show-paren-mode t)
 '(tool-bar-mode nil)
 '(user-mail-address "jesper.eskilson@klarna.com")
 '(woman-fill-column 100))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:family "Noto Mono" :foundry "GOOG" :slant normal :weight normal :height 83 :width normal))))
 '(erlang-font-lock-exported-function-name-face ((t (:inherit font-lock-function-name-face :weight bold))))
 '(fringe ((t nil)))
 '(lsp-ui-doc-url ((t (:inherit nil))))
 '(lsp-ui-sideline-code-action ((t (:foreground "dim gray" :slant oblique))))
 '(markdown-code-face ((t (:inherit markdown-inline-code-face))))
 '(markdown-inline-code-face ((t (:inherit font-lock-constant-face))))
 '(markdown-pre-face ((t (:inherit font-lock-constant-face))))
 '(region ((t nil))))
