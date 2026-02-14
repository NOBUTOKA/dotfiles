;;; init-core.el --- -*- coding: utf-8; lexical-binding: t -*-

;; 
;; 外部パッケージに依存しない設定
;;

(leaf savehist
  :doc "Save minibuffer history"
  :global-minor-mode t)

(leaf flymake
  :doc "A universal on-the-fly syntax checker"
  :bind ((prog-mode-map
          ("M-n" . flymake-goto-next-error)
          ("M-p" . flymake-goto-prev-error))))

(leaf custom-file
  :custom `((custom-file . ,(locate-user-emacs-file "custom.el")))
  :hook (after-init-hook . (lambda () (load custom-file nil))))

;; bind Xdefaults-mode with .xconf file(e. g. urxvt.xconf)
(leaf conf-xdefaults-mode
  :mode "\\.xconf\\'")

;; bind sh-mode with .zshlocal
(leaf sh-mode
  :mode ".zshlocal")

;;
;; 外部パッケージのインストールと設定
;;
(leaf compile-angel
  :ensure t
  :custom (compile-angel-verbose . t)
  :hook (emacs-lisp-mode-hook . compile-angel-on-save-local-mode)
  :global-minor-mode compile-angel-on-load-mode)

(leaf ef-themes
  :ensure (ef-themes :host github :repo "protesilaos/ef-themes")
  :config (load-theme 'ef-elea-dark t))

(leaf exec-path-from-shell
  :if (memq system-type '(gnu/linux darwin))
  :ensure t
  :require t
  :config
  (setq exec-path-from-shell-arguments
	(remove "-i" exec-path-from-shell-arguments))
  (exec-path-from-shell-initialize))

(leaf smartparens
  :ensure t
  :require t
  :global-minor-mode smartparens-global-mode
  :config
  (sp-pair "「" "」")
  (sp-pair "『" "』"))

(leaf real-auto-save
  :ensure t
  :custom (real-auto-save-interval . 60)
  :hook (prog-mode-hook . real-auto-save-mode))

(leaf ddskk
  :ensure t
  :custom ((default-input-method . "japanese-skk")
	   (skk-japanese-message-and-error . t)
	   (skk-version-codename-ja . t)
	   (skk-show-icon . t)
	   (skk-show-japanese-menu . t)
	   (skk-use-color-cursor . t)
	   (skk-indicator-use-cursor-color . t)
	   (skk-server-host . "localhost")
	   (skk-server-portnum . 1178))
  :bind* (("<muhenkan>" . skk-mode)
	 ("C-c C-j" . skk-mode)
	 ("C-j" . skk-kakutei)))

(leaf yasnippet :ensure t)

(leaf magit
  :ensure t
  :custom (transient-default-level . 5)
  :bind ("C-x g" . magit-status))
