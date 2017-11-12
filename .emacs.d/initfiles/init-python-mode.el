(with-eval-after-load-feature 'auto-virtualenvwrapper
  (add-hook 'python-mode-hook #'auto-virtualenvwrapper-activate)
  )
