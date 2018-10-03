(with-eval-after-load-feature (bind-key term-mode)
  (bind-key "C-r" 'helm-shell-history term-raw-map))

(setq helm-shell-history-file "~/.zsh_history")
