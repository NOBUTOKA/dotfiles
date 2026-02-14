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

  (leaf consult
    :straight t
    :hook (completion-list-mode-hook . consult-preview-at-point-mode)
    :custom ((xref-show-xrefs-function . #'consult-xref)
             (xref-show-definitions-function . #'consult-xref)
             (consult-line-start-from-top . t))
    :bind (([remap switch-to-buffer] . consult-buffer)
	   ([remap project-switch-to-buffer] . consult-project-buffer)
	   ([remap isearch-forward] . consult-line)
	   ([remap goto-line] . consult-goto-line)
           ([remap imenu] . consult-isearch-forward)
	   ([remap yank-pop] . consult-yank-pop)
           ("M-g f" . consult-flymake)))

  (leaf embark-consult
    :after (consult embark)
    :straight t)
  )

(leaf embark
  :straight t
  :bind (("C-." . embark-act)
	 ("M-." . embark-dwim)))

(leaf *eglot
  :config
  (leaf eglot
    :straight t
    :hook ((eglot-managed-mode-hook . yas-minor-mode)
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

(leaf *region-completion
  :config
  (leaf corfu
    :straight t
    :preface
    (defun adv/corfu-insert-force-first-index ()
      "Corfuポップアップが表示された状態で何も選択せずcorfu-insertしたとき、最初の候補を選択する。"
      (when (< corfu--index 0)
	(setq corfu--index 0)))
    :advice (:before corfu-insert adv/corfu-insert-force-first-index)
    :custom ((corfu-cycle . t)
	     (corfu-quit-at-boundary . 'separator)
	     (corfu-auto . t)
	     (corfu-preselect . 'prompt))
    :bind (corfu-map
	   ("TAB" . completion-at-point)
	   ("RET" . corfu-insert))
    :global-minor-mode global-corfu-mode
    )

  (leaf cape
    :straight t
    :config
    (leaf *cape-eglot-tweak
      :after eglot
      :advice (:around eglot-completion-at-point cape-wrap-buster))))
