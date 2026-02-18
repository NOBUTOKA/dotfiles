;;; init-completions.el --- -*- coding: utf-8; lexical-binding: t -*-

(leaf orderless
  :ensure t
  :custom ((completion-styles . '(orderless flex basic))
	   (completion-category-defaults . nil)
	   (completion-category-overrides . '((file (styles partial-completion))))))

(leaf *eglot
  :config
  (leaf eglot
    :ensure t
    :hook (eglot-managed-mode-hook . yas-minor-mode)
    :bind (eglot-mode-map
	   (("C-c f" . eglot-format)
	    ("C-c r n" . eglot-rename))))

  (leaf eglot-booster
    :after eglot
    :ensure t
    :when (executable-find "emacs-lsp-booster")
    :hook (eglot-managed-mode-hook . eglot-booster-mode)))

(leaf cape
  :ensure t
  :preface
  (defun my/prog-cape-setup ()
    (add-hook 'completion-at-point-functions #'cape-file 0 t)
    (add-hook 'completion-at-point-functions #'cape-tex 0 t)
    (let ((super-capf (cape-capf-super
                       #'cape-keyword
	         #'cape-dabbrev
	         #'cape-sgml)))
      (add-hook 'completion-at-point-functions super-capf 0 t)))
  :hook (prog-mode-hook . my/prog-cape-setup)
  :config
  (leaf *cape-eglot-tweak
    :after eglot
    :advice ((:around eglot-completion-at-point cape-wrap-buster)
             (:around eglot-completion-at-point cape-wrap-nonexclusive))))
