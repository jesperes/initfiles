(require 'cc-styles)

(c-add-style "iar"
             '((c-basic-offset . 2)
               (comment-column . 45)
               (c-offsets-alist . ((substatement-open . 0)
                                   (statement-case-open . +)
                                   (inline-open . 0)
                                   (label . 0)))
               (indent-tabs-mode . nil)))

(setq c-default-style "iar")
