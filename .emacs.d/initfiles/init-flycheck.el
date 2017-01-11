(add-hook 'after-init-hook #'global-flycheck-mode)

(defun setup-flycheck-clang-project-path ()
  (let ((root (ignore-errors (projectile-project-root))))
    (when root
      (add-to-list 
       (make-variable-buffer-local 'flycheck-clang-include-path)
       root))))
(add-hook 'c-mode-hook 'setup-flycheck-clang-project-path)
(add-hook 'c++-mode-hook 'setup-flycheck-clang-project-path)

(setq-default flycheck-emacs-lisp-load-path 'inherit)
