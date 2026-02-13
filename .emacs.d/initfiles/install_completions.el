;;; install_completions.el --- -*- coding: utf-8; lexical-binding: t -*-

(leaf *minibuf-completion
  :config
  (leaf vertico
    :init
    (fido-vertical-mode -1)
    (fido-mode -1)
    :straight t
    :bind (vertico-map
	   ("C-l" . vertico-directory-delete-char))
    :custom (vertico-count . 15)
    :global-minor-mode t)

  (leaf marginalia
    :straight t
    :global-minor-mode t)

  (leaf orderless
    :straight t
    :custom ((completion-styles . '(orderless flex basic))
	     (completion-category-defaults . nil)
	     (completion-category-overrides . '((file (styles partial-completion))))))
  )

(leaf *eglot
  :config
  (leaf eglot
    :straight t
    :hook ((eglot-managed-mode-hook . company-mode)
	   (eglot-managed-mode-hook . yas-minor-mode)
	   (c-mode-hook . eglot-ensure)
	   (c++-mode-hook . eglot-ensure)
	   (cmake-mode-hook . eglot-ensure)
	   (csharp-mode-hook . eglot-ensure)
	   (julia-mode-hook . eglot-ensure)
	   (python-mode-hook . eglot-ensure)
	   (ruby-mode-hook . eglot-ensure)
	   (rustic-mode-hook . eglot-ensure))
    :bind (eglot-mode-map
	   (("C-c f" . eglot-format)
	    ("C-c r n" . eglot-rename)))
    :defer-config
    (add-to-list 'eglot-server-programs '(csharp-mode . "csharp-ls"))
    (add-to-list 'eglot-server-programs '(rustic-mode . "rust-analyzer"))
    (add-to-list 'eglot-server-programs '((ruby-mode ruby-ts-mode) "ruby-lsp")))

  (leaf eglot-booster
    :after eglot
    :when (executable-find "emacs-lsp-booster")
    :straight t
    :global-minor-mode t))

(leaf company
  :straight t
  ;; companyが使うprojectをstraight版に強制しておかないと、ビルトイン版projectを読みに行き、
  ;; 他のパッケージがprojectを読む際にstraight版を読もうとしてConflict死することがある。
  :init (leaf project :straight t)
  :custom ((company-minimum-prefix-length . 2)
	   (company-selection-wrap-around . t))
  :bind (company-active-map
	 ("M-n" . nil)
	 ("M-p" . nil)
	 ("C-n" . company-select-next)
	 ("C-p" . company-select-previous)
	 ("C-h" . nil))
  :global-minor-mode global-company-mode
  :config
  (delete '(company-dabbrev-code company-gtags company-etags company-keywords) company-backends)
  (add-to-list 'company-backends '(company-dabbrev-code company-capf company-gtags company-etags company-keywords)))

(leaf *smart-jump
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
