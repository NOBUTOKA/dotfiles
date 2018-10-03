(with-eval-after-load-feature 'bind-key
  (with-eval-after-load-feature 'c-mode
    (bind-key "M-RET" 'srefactor-refactor-at-point c-mode-map))
  (with-eval-after-load-feature 'c++-mode
    (bind-key "M-RET" 'srefactor-refactor-at-point c++-mode-map)))
