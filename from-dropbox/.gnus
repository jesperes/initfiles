
(setq user-mail-address "jesper.eskilson@iar.com")
(setq user-full-name "Jesper Eskilson")

(setq send-mail-function 'smtpmail-send-it)
(setq message-send-mail-function 'smtpmail-send-it)
(setq smtpmail-default-smtp-server "exchange.iar.se")

(setq gnus-select-method
      '(nnimap "exchange.iar.se"))

(define-key message-mode-map "\M-/" 'bbdb-complete-name)
(gnus-demon-add-handler 'gnus-demon-scan-news 5 1)

(setq gnus-summary-same-subject "-\"-")
(setq gnus-summary-line-format "%U%R %d %(%[%-15,15n%]%)%I %s\n")
(setq gnus-use-toolbar nil)
(setq message-signature-file "~/.sig")

(setq message-dont-reply-to-names
      "\\(jesperes\\|jesper\\.eskilson\\)@iar\\.\\(se\\|com\\)")

(setq gnus-message-archive-group
      "nnimap+exchange.iar.se:Sent")

(setq message-alternative-emails
      (regexp-opt '("jesper@eskilson.se"
		    "jesper.eskilson@gmail.com"
		    "jesperes@iar.se")))

(add-hook 'message-setup-hook 'my-message-setup-hook)
(defun my-message-setup-hook()
  (auto-fill-mode t))

