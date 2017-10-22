(add-hook 'term-mode-hook
	  (lambda () (define-key term-raw-map (kbd "C-r") 'helm-shell-history))
	  )

(setq helm-shell-history-file "~/.zsh_history")
