;;from https://monolog.linkode.co.jp/articles/kotoh/Emacs%E3%81%A7helm%E3%82%92%E4%BD%BF%E3%81%86

(helm-mode 1)

(with-eval-after-load-feature 'bind-key
  (bind-keys*
   ("C-;". helm-mini)
   ("C-x C-f". helm-find-files)
   ("M-x". helm-M-x)
   ("C-x C-r". helm-recentf)
   ("M-y". helm-show-kill-ring)
   ("C-c i". helm-semantic-or-imenu)
   ("C-x b". helm-buffers-list))
  (bind-keys :map helm-map
	     ("<tab>". helm-execute-persistent-action) ;rebind tab to do persistent action
	     ("C-i". helm-execute-persistent-action)	;make TAB works in terminal
	     ("C-z". helm-select-action))		;list actions using C-z
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
