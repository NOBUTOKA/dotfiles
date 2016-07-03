(add-hook 'c-mode-hook
          (lambda ()
            (set (make-local-variable 'eldoc-idle-delay) 0.20)
	    (setq c-eldoc-buffer-regenerate-time 60)
            (c-turn-on-eldoc-mode)
            ))
