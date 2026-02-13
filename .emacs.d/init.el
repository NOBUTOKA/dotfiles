;;; init.el --- -*- coding: utf-8; lexical-binding: t -*-

;; load early-init.el(for backword compatibility)
(unless (bound-and-true-p early-init-loaded)
  (let* ((early-init-file (concat user-emacs-directory "early-init.el")))
    (when (file-exists-p early-init-file)
      (load-file early-init-file))))

;; set user-emacs-directory
(when load-file-name
  (setq user-emacs-directory (file-name-directory load-file-name)))

;; initialize in specific host
(let* ((init_host (concat user-emacs-directory "init_" (system-name) "_bef.el")))
  (when (file-exists-p init_host)
    (load-file init_host)))

;; initialize general config
(when (file-exists-p (concat user-emacs-directory "initfiles/init_general.el"))
  (load (concat user-emacs-directory "initfiles/init_general.el")))

(let* ((init_host (concat user-emacs-directory "init_" (system-name) "_aft.el")))
  (when (file-exists-p init_host)
    (load-file init_host)))
