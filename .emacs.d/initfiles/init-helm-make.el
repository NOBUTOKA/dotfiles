(with-eval-after-load-feature 'bind-key
  (with-eval-after-load-feature 'makefile-mode
    (bind-key "M-\"" 'helm-make-projectile makefile-mode-map))
  (with-eval-after-load-feature 'c-mode
    (bind-key "M-\"" 'helm-make-projectile c-mode-map))
  (with-eval-after-load-feature 'c++-mode
    (bind-key "M-\"" 'helm-make-projectile c++-mode-map))
  )
