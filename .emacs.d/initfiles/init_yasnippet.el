(yas-global-mode 1)
(with-eval-after-load-feature 'helm-c-yasnippet
  (setq helm-yas-space-match-any-greedy t)
  (with-eval-after-load-feature 'bind-key
    (bind-key "C-c y" 'helm-yas-complete)
    )
  )
