(defun ac-cc-mode-setup ()
  (setq ac-clang-complete-executable "/usr/bin/clang-complete")
  (setq ac-sources (append ac-sources '(ac-source-clang-async)))
  (ac-clang-launch-completion-process))

(add-hook 'c-mode-common-hook 'ac-cc-mode-setup)
(add-hook 'auto-complete-mode-hook 'ac-common-setup)
