(leaf helm
  :straight t
  :require t
  :global-minor-mode t
  :bind* (("C-;". helm-mini)
	  ("C-x C-f". helm-find-files)
	  ("M-x". helm-M-x)
	  ("C-x C-r". helm-recentf)
	  ("M-y". helm-show-kill-ring)
	  ("C-c i". helm-semantic-or-imenu)
	  ("C-x b". helm-buffers-list))
  :bind (helm-map
	 ("<tab>". helm-execute-persistent-action) ;rebind tab to do persistent action
	 ("C-i". helm-execute-persistent-action)   ;make TAB works in terminal
	 ("C-z". helm-select-action))		   ;list actions using C-z)
  :config
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

  (leaf helm-projectile
    :straight t
    :advice (:around helm-for-files
		     helm-for-files-with-projectile)
    :preface (defun helm-for-files-with-projectile (orig-fun &rest args)
	       (let ((helm-for-files-preferred-list (helm-for-files-update-list)))
		 (apply orig-fun args)))
    :hook (projectile-mode-hook . helm-projectile-on)
    :config
    (defun helm-for-files-update-list ()
      `(helm-source-buffers-list
	helm-source-recentf
	helm-source-ghq
	helm-source-files-in-current-dir
	helm-source-file-cache
	,(if (projectile-project-p)
             helm-source-projectile-files-list))))
  
  (leaf helm-company :straight t)
  
  (leaf helm-c-yasnippet :straight t)

  (leaf helm-tramp :straight t)

  (leaf helm-shell-history
    :straight t
    :custom (helm-shell-history-file . "~/.zsh_history")
    :bind (term-raw-map
	   :package term-mode
	   ("C-r" . 'helm-shell-history))))
