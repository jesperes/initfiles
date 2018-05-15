(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(Man-fontify-manpage-flag t)
 '(Man-notify-method (quote aggressive))
 '(ansi-color-faces-vector
   [default bold shadow italic underline bold bold-italic bold])
 '(ansi-color-names-vector
   ["#212526" "#ff4b4b" "#b4fa70" "#fce94f" "#729fcf" "#e090d7" "#8cc4ff" "#eeeeec"])
 '(column-number-mode t)
 '(company-backends
   (quote
    (company-rtags company-c-headers company-bbdb company-nxml company-css company-eclim company-clang company-xcode company-cmake company-capf company-files
		   (company-dabbrev-code company-gtags company-etags company-keywords))))
 '(compilation-always-kill t)
 '(compilation-ask-about-save nil)
 '(compilation-auto-jump-to-first-error nil)
 '(compilation-scroll-output (quote first-error))
 '(compile-command "cmake --build .")
 '(custom-enabled-themes (quote (deeper-blue)))
 '(custom-safe-themes
   (quote
    ("f0ea6118d1414b24c2e4babdc8e252707727e7b4ff2e791129f240a2b3093e32" default)))
 '(display-time-24hr-format t)
 '(display-time-mode t)
 '(fci-rule-color "gray23")
 '(fci-rule-use-dashes t)
 '(fci-rule-width 1)
 '(inhibit-startup-screen t)
 '(neo-smart-open t)
 '(neo-theme (quote ascii))
 '(neo-window-fixed-size nil)
 '(neo-window-width 40)
 '(nxml-child-indent 4)
 '(nxml-slash-auto-complete-flag t)
 '(package-selected-packages
   (quote
    (nlinum yaml-mode ag groovy-mode dockerfile-mode markdown+ markdown-mode+ markdown markdown-mode xkcd rg neotree company-erlang erlang cmake-font-lock cmake-mode clang-format company-rtags company-c-headers company-cmake company rtags thrift magit-svn magit-filenotify magit use-package)))
 '(read-file-name-completion-ignore-case t)
 '(safe-local-variable-values (quote ((allout-layout . t))))
 '(scroll-bar-mode nil)
 '(show-paren-mode t)
 '(speedbar-indentation-width 3)
 '(speedbar-track-mouse-flag t)
 '(split-height-threshold nil)
 '(tool-bar-mode nil)
 '(vc-annotate-background nil)
 '(vc-annotate-color-map
   (quote
    ((20 . "#d54e53")
     (40 . "goldenrod")
     (60 . "#e7c547")
     (80 . "DarkOliveGreen3")
     (100 . "#70c0b1")
     (120 . "DeepSkyBlue1")
     (140 . "#c397d8")
     (160 . "#d54e53")
     (180 . "goldenrod")
     (200 . "#e7c547")
     (220 . "DarkOliveGreen3")
     (240 . "#70c0b1")
     (260 . "DeepSkyBlue1")
     (280 . "#c397d8")
     (300 . "#d54e53")
     (320 . "goldenrod")
     (340 . "#e7c547")
     (360 . "DarkOliveGreen3"))))
 '(vc-annotate-very-old-color nil))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:family "Ubuntu Mono" :foundry "DAMA" :slant normal :weight normal :height 120 :width normal))))
 '(font-latex-sectioning-5-face ((t (:inherit nil :foreground "blue4" :weight bold))))
 '(font-latex-slide-title-face ((t (:inherit font-lock-type-face :weight bold :height 1.2))))
 '(markdown-code-face ((t (:inherit nil))))
 '(rtags-skippedline ((t (:background "gray20")))))
