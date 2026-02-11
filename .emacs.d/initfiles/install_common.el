;; 即座にrequireされるもの
(leaf exec-path-from-shell
  :if (memq system-type '(gnu/linux darwin))
  :straight t
  :require t
  :config
  (setq exec-path-from-shell-arguments
	(remove "-i" exec-path-from-shell-arguments))
  (exec-path-from-shell-initialize))

(leaf keyfreq
  :straight t
  :require t
  :config
  (keyfreq-mode 1)
  (keyfreq-autosave-mode 1))

(leaf smartparens
  :straight t
  :require t
  :config
  (sp-pair "「" "」")
  (sp-pair "『" "』")
  (smartparens-global-mode t))

;; lazy-loadされる(はずの)もの
(leaf real-auto-save
  :straight t
  :custom (real-auto-save-interval . 60)
  :hook (prog-mode-hook . real-auto-save-mode))

(leaf ddskk
  :straight t
  :custom ((default-input-method . "japanese-skk")
	   (skk-japanese-message-and-error . t)
	   (skk-version-codename-ja . t)
	   (skk-show-icon . t)
	   (skk-show-japanese-menu . t)
	   (skk-use-color-cursor . t)
	   (skk-indicator-use-cursor-color . t)
	   (skk-server-host . "localhost")
	   (skk-server-portnum . 1178)
	   (skk-server-prog . "/usr/local/sbin/yaskkserv")
	   (skk-server-jisyo . "~/.yaskkserv/SKK-JISYO.L.yaskkserv ~/.yaskkserv/SKK-JISYO.propernoun.yaskkserv")
	   (skk-server-inhibit-startup-server . nil))
  :bind* (("<muhenkan>" . skk-mode)
	 ("C-c C-j" . skk-mode)
	 ("C-j" . skk-kakutei)))

(leaf yasnippet :straight t)

(leaf eglot
  :straight t
  :after project
  :hook ((eglot-managed-mode-hook . company-mode)
	 (eglot-managed-mode-hook . yas-minor-mode)
	 (c-mode-hook . eglot-ensure)
	 (c++-mode-hook . eglot-ensure)
	 (cmake-mode-hook . eglot-ensure)
	 (julia-mode-hook . eglot-ensure)
	 (python-mode-hook . eglot-ensure)
	 (ruby-mode-hook . eglot-ensure)
	 (rustic-mode-hook . eglot-ensure))
  :bind (eglot-mode-map
	 (("C-c f" . eglot-format)
	  ("C-c r n" . eglot-rename)))
  :defer-config
  (add-to-list 'eglot-server-programs '(rustic-mode . ("rust-analyzer")))
  (add-to-list 'eglot-server-programs '((ruby-mode ruby-ts-mode) "ruby-lsp")))

(leaf company
  :straight t
  :after project
  :custom ((company-minimum-prefix-length . 2)
	   (company-selection-wrap-around . t))
  ;; init後にロードしないと、project.elのloadタイミングの問題でエラー↓を踏むことがある。
  ;; File mode specification error: (error Feature "project" is now provided by a different file /path/to/straight/build/project/project.elc)
  ;; 参考: https://github.com/joaotavora/eglot/discussions/1436
  :hook (after-init-hook . global-company-mode)
  :bind (company-active-map
	 ("M-n" . nil)
	 ("M-p" . nil)
	 ("C-n" . company-select-next)
	 ("C-p" . company-select-previous)
	 ("C-h" . nil))
  :config
  (delete '(company-dabbrev-code company-gtags company-etags company-keywords) company-backends)
  (add-to-list 'company-backends '(company-dabbrev-code company-capf company-gtags company-etags company-keywords)))

(leaf smart-jump*
  :config
  (leaf dumb-jump
    :straight t
    :custom (dumb-jump-selector . 'helm))

  (leaf smart-jump
    :straight t
    :commands (smart-jump-go smart-jump-back smart-jump-references)
    :bind (("M-." . smart-jump-go)
           ("M-," . smart-jump-back)
           ("M-?" . smart-jump-references))))

(leaf projectile :straight t)

(leaf magit*
  :config
  (leaf magit
    :straight t
    :custom (transient-default-level . 5)
    :bind ("C-x g" . magit-status))

  (leaf magit-gh-pulls :straight t)

  (leaf magit-gitflow
    :straight t
    :hook (magit-mode-hook . turn-on-magit-gitflow))
  )

(leaf gnuplot-mode
  :straight t
  :mode "\\.gp$")

(leaf multi-term
  :straight t
  :bind (term-raw-map
	 :package term-mode
	 ("C-f" . term-send-forward-char)
	 ("C-b" . term-send-backward-char)
	 ("C-p" . term-send-previous-line)
	 ("C-n" . term-send-next-line))
  :config
  (defun term-send-forward-char ()
    (interactive)
    (term-send-raw-string "\C-f"))
  (defun term-send-backward-char ()
    (interactive)
    (term-send-raw-string "\C-b"))
  (defun term-send-previous-line ()
    (interactive)
    (term-send-raw-string "\C-p"))
  (defun term-send-next-line ()
    (interactive)
    (term-send-raw-string "\C-n")))
