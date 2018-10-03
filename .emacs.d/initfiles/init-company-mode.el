(delete '(company-dabbrev-code company-gtags company-etags company-keywords) company-backends)
(add-to-list 'company-backends '(company-dabbrev-code company-capf company-gtags company-etags company-keywords))
(with-eval-after-load-feature 'bind-key
  (bind-keys :map company-active-map
	     ("M-n". nil)
	     ("M-p". nil)
	     ("C-n". company-select-next)
	     ("C-p". company-select-previous)
	     ("C-h". nil)))
(global-company-mode)
(setq company-minimum-prefix-length 2)
(setq company-selection-wrap-around t)
