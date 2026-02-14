;;; init-ui.el --- -*- coding: utf-8; lexical-binding: t -*-

(leaf vertico
  :init
  (fido-vertical-mode -1)
  (fido-mode -1)
  :ensure t
  :bind (vertico-map
	 ("C-l" . vertico-directory-delete-char))
  :custom (vertico-count . 15)
  :global-minor-mode t)

(leaf marginalia
  :ensure t
  :global-minor-mode t)

(leaf consult
  :ensure t
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

(leaf embark
  :ensure t
  :bind* (("C-." . embark-act)
	 ("M-." . embark-dwim)))

(leaf embark-consult
  :after (consult embark)
  :ensure t)

(leaf corfu
  :ensure t
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
  :global-minor-mode global-corfu-mode)
