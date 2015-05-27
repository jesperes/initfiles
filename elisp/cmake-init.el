;;
;; Use Anders Lindgren's CMake font lock mode:
;; https://github.com/Lindydancer/cmake-font-lock
;;

(load "andersl-cmake-font-lock")
;; (require 'cmake-mode)
(autoload 'andersl-cmake-font-lock-activate "andersl-cmake-font-lock" nil t)
(add-hook 'cmake-mode-hook 'andersl-cmake-font-lock-activate)
(add-to-list 'auto-mode-alist '("CMakeLists\\.txt" . cmake-mode))
(add-to-list 'auto-mode-alist '("\\.cmake" . cmake-mode))
