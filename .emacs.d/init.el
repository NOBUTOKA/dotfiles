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


;; color theme config
(load-theme 'modus-vivendi t)

;;language config
(set-language-environment "UTF-8")
(prefer-coding-system 'utf-8-unix)

;; Activate fido-vertical-mode (Fallback for vertico)
(when (version<= "28" emacs-version)
  (fido-vertical-mode 1)
  (define-key icomplete-fido-mode-map (kbd "<DEL>") #'delete-backward-char)
  (define-key icomplete-fido-mode-map (kbd "C-l") #'icomplete-fido-backward-updir))

;; Straight.el bootstrap
(load (locate-user-emacs-file "bootstrap-straight.el"))

;; Install leaf (using straight.el)
(straight-use-package 'leaf)
(straight-use-package 'leaf-keywords)
(leaf-keywords-init)

(load (locate-user-emacs-file "initfiles/init-core.el"))
(load (locate-user-emacs-file "initfiles/init-ui.el"))
(load (locate-user-emacs-file "initfiles/init-completions.el"))
(load (locate-user-emacs-file "initfiles/init-languages.el"))

(let* ((init_host (concat user-emacs-directory "init_" (system-name) "_aft.el")))
  (when (file-exists-p init_host)
    (load-file init_host)))
