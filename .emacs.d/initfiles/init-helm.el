;;from https://monolog.linkode.co.jp/articles/kotoh/Emacs%E3%81%A7helm%E3%82%92%E4%BD%BF%E3%81%86

(helm-mode 1)

(with-eval-after-load-feature 'use-package
  (bind-key "C-;" 'helm-mini)
  (bind-key "C-x C-f" 'helm-find-files)
  (bind-key "M-x" 'helm-M-x)
  (bind-key "C-x C-r" 'helm-recentf)
  (bind-key "M-y" 'helm-show-kill-ring)
  (bind-key "C-c i" 'helm-semantic-or-imenu)
  (bind-key "C-x b" 'helm-buffers-list)
  (bind-key "C-h" 'delete-backward-char)
  (bind-key "<tab>" 'helm-execute-persistent-action helm-map) ; rebind tab to do persistent action
  (bind-key "C-i" 'helm-execute-persistent-action helm-map) ; make TAB works in terminal
  (bind-key "C-z"  'helm-select-action helm-map) ; list actions using C-z
  )


(defvar helm-source-emacs-commands
  (helm-build-sync-source "Emacs commands"
    :candidates (lambda ()
                  (let ((cmds))
                    (mapatoms
                     (lambda (elt) (when (commandp elt) (push elt cmds))))
                    cmds))
    :coerce #'intern-soft
    :action #'command-execute)
  "A simple helm source for Emacs commands.")

(defvar helm-source-emacs-commands-history
  (helm-build-sync-source "Emacs commands history"
    :candidates (lambda ()
                  (let ((cmds))
                    (dolist (elem extended-command-history)
                      (push (intern elem) cmds))
                    cmds))
    :coerce #'intern-soft
    :action #'command-execute)
  "Emacs commands history")
