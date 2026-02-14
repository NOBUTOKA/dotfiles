;;; install_common.el --- -*- coding: utf-8; lexical-binding: t -*-

;; 即座にrequireされるもの
(leaf exec-path-from-shell
  :if (memq system-type '(gnu/linux darwin))
  :straight t
  :require t
  :config
  (setq exec-path-from-shell-arguments
	(remove "-i" exec-path-from-shell-arguments))
  (exec-path-from-shell-initialize))

(leaf smartparens
  :straight t
  :require t
  :global-minor-mode smartparens-global-mode
  :config
  (sp-pair "「" "」")
  (sp-pair "『" "』"))

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

(leaf *magit
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
