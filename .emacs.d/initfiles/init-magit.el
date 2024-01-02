(setq transient-default-level 5)
(with-eval-after-load-feature 'bind-key
  (bind-key "C-x g" 'magit-status))
