;; emacs-server config
(require 'server)
(unless (server-running-p)
  (server-start))

;; color theme config
(load-theme 'tango-dark t)

;; assign C-h as Backspace
(define-key key-translation-map (kbd "C-h") (kbd "<DEL>"))

;;font config
(add-to-list 'default-frame-alist '(font . "源ノ角ゴシック Code JP M-10.5"))

;; change custom-set-variables location
(setq custom-file (locate-user-emacs-file "custom.el"))

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

(el-get-bundle! cc-mode)
(el-get-bundle! company in company-mode)

(el-get-bundle! use-package)
(el-get-bundle! with-eval-after-load-feature
  in tarao/with-eval-after-load-feature-el)
(el-get-bundle org-mode)
(el-get-bundle open-junk-file)
(el-get-bundle codic)
(el-get-bundle ddskk)
(el-get-bundle evil)
(el-get-bundle ggtags)
(el-get-bundle helm)
(el-get-bundle c-eldoc)
(el-get-bundle projectile)
(el-get-bundle helm-projectile)
(el-get-bundle semantic-refactor)
(el-get-bundle flycheck)
(el-get-bundle abo-abo/helm-make)
(el-get-bundle magit)
(el-get-bundle magit-gh-pulls
  :depends (gh magit pcache s))
(el-get-bundle mew)
(el-get-bundle yatex
  :type hg
  :url "http://www.yatex.org/hgrepos/yatex"
  :branch "dev")
(el-get-bundle helm-company)
(el-get-bundle irony-mode)
(el-get-bundle company-irony)
(el-get-bundle flycheck-irony)
(el-get-bundle rtags)
(el-get-bundle smartparens)
(el-get-bundle yasnippet)
(el-get-bundle request
  :type git
  :url "https://github.com/tkf/emacs-request")
(el-get-bundle NOBUTOKA/niconama.el
  :name niconama)
(el-get-bundle markdown-mode)
(el-get-bundle all)
(el-get-bundle all-ext)
(el-get-bundle company-jedi)
(el-get-bundle autopep8)
(el-get-bundle mopemope/meghanada-emacs
  :name mogehanada)
(el-get-bundle haskell-mode)
(el-get-bundle ghc-mod)
(el-get-bundle company-ghc)

