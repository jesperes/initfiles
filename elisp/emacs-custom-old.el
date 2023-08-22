(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(Man-width 80)
 '(ag-arguments (quote ("-S")))
 '(ag-highlight-search t)
 '(ansi-color-faces-vector
   [default default default italic underline success warning error])
 '(ansi-color-names-vector
   ["black" "#d55e00" "#009e73" "#f8ec59" "#0072b2" "#cc79a7" "#56b4e9" "white"])
 '(blink-cursor-mode nil)
 '(column-number-mode t)
 '(company-backends
   (quote
    (company-lsp company-rtags company-c-headers company-bbdb company-nxml company-css company-eclim company-clang company-xcode company-cmake company-capf company-files
                 (company-dabbrev-code company-gtags company-etags company-keywords))))
 '(compilation-always-kill t)
 '(compilation-ask-about-save nil)
 '(compilation-auto-jump-to-first-error nil)
 '(compilation-message-face (quote default))
 '(compilation-scroll-output t)
 '(compile-command "make -k -C ~/src/kc/kred ")
 '(custom-enabled-themes (quote (deeper-blue)))
 '(custom-safe-themes
   (quote
    ("a0feb1322de9e26a4d209d1cfa236deaf64662bb604fa513cca6a057ddf0ef64" "04dd0236a367865e591927a3810f178e8d33c372ad5bfef48b5ce90d4b476481" "7356632cebc6a11a87bc5fcffaa49bae528026a78637acd03cae57c091afd9b9" "4aa183d57d30044180d5be743c9bd5bf1dde686859b1ba607b2eea26fe63f491" "ed4b75a4f5cf9b1cd14133e82ce727166a629f5a038ac8d91b062890bc0e2d1b" default)))
 '(diary-entry-marker (quote font-lock-variable-name-face))
 '(display-time-24hr-format t)
 '(display-time-mode t)
 '(emms-mode-line-icon-image-cache
   (quote
    (image :type xpm :ascent center :data "/* XPM */
static char *note[] = {
/* width height num_colors chars_per_pixel */
\"    10   11        2            1\",
/* colors */
\". c #1fb3b3\",
\"# c None s None\",
/* pixels */
\"###...####\",
\"###.#...##\",
\"###.###...\",
\"###.#####.\",
\"###.#####.\",
\"#...#####.\",
\"....#####.\",
\"#..######.\",
\"#######...\",
\"######....\",
\"#######..#\" };")))
 '(fci-rule-color "#010F1D")
 '(gnus-logo-colors (quote ("#528d8d" "#c0c0c0")))
 '(gnus-mode-line-image-cache
   (quote
    (image :type xpm :ascent center :data "/* XPM */
static char *gnus-pointer[] = {
/* width height num_colors chars_per_pixel */
\"    18    13        2            1\",
/* colors */
\". c #1fb3b3\",
\"# c None s None\",
/* pixels */
\"##################\",
\"######..##..######\",
\"#####........#####\",
\"#.##.##..##...####\",
\"#...####.###...##.\",
\"#..###.######.....\",
\"#####.########...#\",
\"###########.######\",
\"####.###.#..######\",
\"######..###.######\",
\"###....####.######\",
\"###..######.######\",
\"###########.######\" };")))
 '(highlight-changes-colors (quote ("#EF5350" "#7E57C2")))
 '(highlight-tail-colors
   (quote
    (("#010F1D" . 0)
     ("#B44322" . 20)
     ("#34A18C" . 30)
     ("#3172FC" . 50)
     ("#B49C34" . 60)
     ("#B44322" . 70)
     ("#8C46BC" . 85)
     ("#010F1D" . 100))))
 '(ido-rotate-file-list-default nil)
 '(indent-tabs-mode nil)
 '(inhibit-startup-screen t)
 '(json-mode-indent-level 4)
 '(magit-diff-use-overlays nil)
 '(magit-process-popup-time 0)
 '(neo-autorefresh t)
 '(neo-confirm-change-root (quote off-p))
 '(neo-theme (quote ascii))
 '(neo-window-fixed-size nil)
 '(nxml-child-indent 4)
 '(nxml-slash-auto-complete-flag t)
 '(package-selected-packages
   (quote
    (helm-company helm ubuntu-theme night-owl-theme alect-themes ido-vertical-mode nlinum company-box yasnippet exec-path-from-shell lsp-treemacs helm-lsp company-lsp lsp-ui json-mode lsp-mode find-file-in-project magit-find-file company prolog markdown-preview-eww markdown-preview-mode groovy-mode yaml-mode ag dockerfile-mode markdown+ markdown-mode+ markdown markdown-mode neotree erlang magit use-package)))
 '(pos-tip-background-color "#FFF9DC")
 '(pos-tip-foreground-color "#011627")
 '(read-file-name-completion-ignore-case t)
 '(safe-local-variable-values (quote ((allout-layout . t))))
 '(scroll-bar-mode nil)
 '(show-paren-mode t)
 '(split-height-threshold nil)
 '(tool-bar-mode nil)
 '(user-mail-address "jesper.eskilson@klarna.com")
 '(vc-annotate-background nil)
 '(vc-annotate-color-map
   (quote
    ((20 . "#C792EA")
     (40 . "#CF4F1F")
     (60 . "#C26C0F")
     (80 . "#FFEB95")
     (100 . "#AB8C00")
     (120 . "#A18F00")
     (140 . "#989200")
     (160 . "#8E9500")
     (180 . "#F78C6C")
     (200 . "#729A1E")
     (220 . "#609C3C")
     (240 . "#4E9D5B")
     (260 . "#3C9F79")
     (280 . "#7FDBCA")
     (300 . "#299BA6")
     (320 . "#2896B5")
     (340 . "#2790C3")
     (360 . "#82AAFF"))))
 '(vc-annotate-very-old-color nil)
 '(weechat-color-list
   (quote
    (unspecified "#011627" "#010F1D" "#DC2E29" "#EF5350" "#D76443" "#F78C6C" "#D8C15E" "#FFEB95" "#5B8FFF" "#82AAFF" "#AB69D7" "#C792EA" "#AFEFE2" "#7FDBCA" "#D6DEEB" "#FFFFFF"))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:inherit nil :stipple nil :inverse-video nil :box nil :strike-through nil :overline nil :underline nil :slant normal :weight normal :height 128 :width normal :foundry "DAMA" :family "Ubuntu Mono"))))
 '(erlang-font-lock-exported-function-name-face ((t (:inherit font-lock-function-name-face :weight extra-bold))))
 '(font-latex-sectioning-5-face ((t (:inherit nil :foreground "blue4" :weight bold))))
 '(font-latex-slide-title-face ((t (:inherit font-lock-type-face :weight bold :height 1.2))))
 '(font-lock-builtin-face ((t (:foreground "LightCoral" :weight bold))))
 '(font-lock-comment-delimiter-face ((t (:foreground "forest green"))))
 '(font-lock-comment-face ((t (:foreground "lime green" :slant italic))))
 '(font-lock-keyword-face ((t (:foreground "DeepSkyBlue1" :weight bold))))
 '(linum ((t (:inherit (shadow default)))))
 '(markdown-code-face ((t (:inherit nil))))
 '(neo-dir-link-face ((t (:foreground "LightBlue"))))
 '(neo-header-face ((t (:foreground "DarkMagenta" :family "Ubuntu")))))
