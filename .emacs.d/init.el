;; set user-emacs-directory
(when load-file-name
  (setq user-emacs-directory (file-name-directory load-file-name)))

;; initialize in specific host
(setq init_host (concat user-emacs-directory "init_" (system-name) ".el"))
(when (file-exists-p init_host)
  (load-file init_host))

;; initialize general config
(when (file-exists-p (concat user-emacs-directory "initfiles/init_general.el"))
  (load (concat user-emacs-directory "initfiles/init_general.el")))


