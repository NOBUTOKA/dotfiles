;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
;(package-initialize)

;; set user-emacs-directory
(when load-file-name
  (setq user-emacs-directory (file-name-directory load-file-name)))

;; initialize in specific host
(setq init_host (concat user-emacs-directory "init_" (system-name) "_bef.el"))
(when (file-exists-p init_host)
  (load-file init_host))

;; initialize general config
(when (file-exists-p (concat user-emacs-directory "initfiles/init_general.el"))
  (load (concat user-emacs-directory "initfiles/init_general.el")))

(setq init_host (concat user-emacs-directory "init_" (system-name) "_aft.el"))
(when (file-exists-p init_host)
  (load-file init_host))

