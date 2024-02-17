(if (< emacs-major-version 27)
    (defun project-root (project)
      (car (project-roots project))))

(add-hook 'c-mode-hook 'eglot-ensure)
(add-hook 'c++-mode-hook 'eglot-ensure)
(add-hook 'cmake-mode-hook 'eglot-ensure)
(add-hook 'rustic-mode-hook 'eglot-ensure)
(add-hook 'python-mode-hook 'eglot-ensure)

(add-hook 'eglot-managed-mode-hook 'company-mode)
(add-hook 'eglot-managed-mode-hook 'yas-minor-mode)

(with-eval-after-load-feature (bind-key eglot)
  (bind-keys :map eglot-mode-map
	     ("C-c f" . eglot-format)
	     ("C-c r n" . eglot-rename))
  (add-to-list 'eglot-server-programs '(rustic-mode . ("rust-analyzer")))
  (add-to-list 'eglot-server-programs '((ruby-mode ruby-ts-mode) "ruby-lsp"))
  )
