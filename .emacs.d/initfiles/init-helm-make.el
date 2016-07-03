(eval-after-load 'makefile-mode
  '(define-key makefile-mode-map (kbd "M-\"") 'helm-make-projectile))
(define-key c-mode-map (kbd "M-\"") 'helm-make-projectile)
(define-key c++-mode-map (kbd "M-\"") 'helm-make-projectile)
