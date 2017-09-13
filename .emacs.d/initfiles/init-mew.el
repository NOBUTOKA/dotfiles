(setq mew-use-suffix t)
(setq mew-fcc "+outbox") ;送信メールを保存
(setq exec-path (cons "/usr/bin" exec-path))

;; Optional setup (Read Mail menu):
(setq read-mail-command 'mew)

(autoload 'mew-user-agent-compose "mew" nil t)
(if (boundp 'mail-user-agent)
    (setq mail-user-agent 'mew-user-agent))
(if (fboundp 'define-mail-user-agent)
    (define-mail-user-agent
      'mew-user-agent
      'mew-user-agent-compose
      'mew-draft-send-message
      'mew-draft-kill
      'mew-send-hook))
