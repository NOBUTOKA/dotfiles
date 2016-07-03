(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(c-basic-offset (quote set-from-style))
 '(c-default-style
   (quote
    ((c-mode . "gnu")
     (java-mode . "java")
     (awk-mode . "awk")
     (other . "gnu"))))
 '(c-hanging-braces-alist
   (quote
    ((defun-open after)
     (defun-close after)
     (block-open after)
     (block-close . c-snug-do-while)
     (statement-cont)
     (substatement-open after)
     (brace-list-open after)
     (brace-list-close after)
     (brace-entry-open)
     (extern-lang-open after)
     (namespace-open after)
     (module-open after)
     (composition-open after)
     (inexpr-class-open after)
     (inexpr-class-close before)
     (arglist-cont-nonempty))))
 '(helm-mini-default-sources
   (quote
    (helm-source-buffers-list helm-source-recentf helm-source-files-in-current-dir helm-source-emacs-commands-history helm-source-emacs-commands)))
 '(magit-commit-arguments (quote ("--all"))))
