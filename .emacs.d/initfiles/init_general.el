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
(setq default-buffer-file-coding-system 'utf-8-unix)
(set-buffer-file-coding-system 'utf-8-unix)
(set-terminal-coding-system 'utf-8-unix)
(set-keyboard-coding-system 'utf-8-unix)
(set-clipboard-coding-system 'utf-8-unix)
(prefer-coding-system 'utf-8-unix)
(set-language-environment 'utf-8)
(set-default-coding-systems 'utf-8-unix)
(setq locale-coding-system 'utf-8)
;;dired文字コードの設定
(setq dired-default-file-coding-system 'utf-8-unix)

;; El-Get config
(add-to-list 'load-path (locate-user-emacs-file "el-get/el-get"))
(unless (require 'el-get nil 'noerror)
  (with-current-buffer
      (url-retrieve-synchronously
       "https://raw.githubusercontent.com/dimitri/el-get/master/el-get-install.el")
    (goto-char (point-max))
    (eval-print-last-sexp)))
(setq el-get-user-package-directory (concat user-emacs-directory "initfiles"))

;; bind Xdefaults-mode with .xconf file(e. g. urxvt.xconf)
(add-to-list 'auto-mode-alist '("\\.xconf\\'" . conf-xdefaults-mode))
;; bind sh-mode with .zshlocal
(add-to-list 'auto-mode-alist '(".zshlocal" . sh-mode))

;; disable-bell
(setq ring-bell-function 'ignore)

(load (concat user-emacs-directory "initfiles/install_common.el"))
(load (concat user-emacs-directory "initfiles/install_languages.el"))
;; (load (concat user-emacs-directory "initfiles/install_niconama.el"))
(load (concat user-emacs-directory "initfiles/install_org.el"))
(load (concat user-emacs-directory "initfiles/install_shell.el"))
