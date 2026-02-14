;;; init_general.el --- -*- coding: utf-8; lexical-binding: t -*-

;; color theme config
(load-theme 'tango-dark t)

;; assign C-h as Backspace
(define-key key-translation-map (kbd "C-h") (kbd "<DEL>"))

;; change custom-set-variables location
(setq custom-file (locate-user-emacs-file "custom.el"))
;; load custom-set-variables
(when (file-exists-p custom-file)
  (load custom-file))

;;language config
(set-language-environment "UTF-8")
(prefer-coding-system 'utf-8-unix)

;; Activate fido-vertical-mode (Fallback for vertico)
(when (version<= "28" emacs-version)
  (fido-vertical-mode 1)
  (define-key icomplete-fido-mode-map (kbd "<DEL>") #'delete-backward-char)
  (define-key icomplete-fido-mode-map (kbd "C-l") #'icomplete-fido-backward-updir))

;; Straight.el bootstrap
(setq straight-use-version-specific-build-dir t)
(defvar bootstrap-version)
(let ((bootstrap-file
       (expand-file-name
        "straight/repos/straight.el/bootstrap.el"
        (or (bound-and-true-p straight-base-dir)
            user-emacs-directory)))
      (bootstrap-version 7))
  (unless (file-exists-p bootstrap-file)
    (with-current-buffer
        (url-retrieve-synchronously
         "https://raw.githubusercontent.com/radian-software/straight.el/develop/install.el"
         'silent 'inhibit-cookies)
      (goto-char (point-max))
      (eval-print-last-sexp)))
  (load bootstrap-file nil 'nomessage))


;; Install leaf (using straight.el)
(straight-use-package 'leaf)
(straight-use-package 'leaf-keywords)
(leaf-keywords-init)

;; bind Xdefaults-mode with .xconf file(e. g. urxvt.xconf)
(add-to-list 'auto-mode-alist '("\\.xconf\\'" . conf-xdefaults-mode))
;; bind sh-mode with .zshlocal
(add-to-list 'auto-mode-alist '(".zshlocal" . sh-mode))

(load (concat user-emacs-directory "initfiles/install_common.el"))
(load (concat user-emacs-directory "initfiles/install_completions.el"))
(load (concat user-emacs-directory "initfiles/install_languages.el"))
