(leaf *clang
  :config
  (leaf cc-mode
    :hook ((c-mode-hook . cc-mode-init)
	   (c++-mode-hook . cc-mode-init)
	   (c++-mode-hook . c++-mode-hooks))
    :config
    (defun cc-mode-init ()
      (c-set-style "stroustrup")
      (c-set-offset 'access-label '/)
      (c-set-offset 'innamespace 0)
      (setq c-auto-newline nil)
      (setq c-hungry-delete-key nil)
      (setq c-basic-offset 4)
      (setq tab-width 4)
      )
    (defun c++-mode-hooks()
      (font-lock-add-keywords
       nil '(
	     ("\\<\\(alignof\\|alignas\\|constexpr\\|decltype\\|noexcept\\|nullptr\\|static_assert\\|thread_local\\|override\\|final\\)\\>"
	      . 'font-lock-keyword-face)
	     )
       ))
    )
  (leaf cmake-mode
    :straight t
    :mode "CMakeLists\\.txt\\'" "\\.cmake\\'"))

(leaf julia*
  :config
  (leaf julia-mode :straight t)
  (leaf julia-repl :straight t)
  (leaf eglot-jl :straight t))

(leaf doxymacs
  :straight (doxymacs :type git :host github :repo "pniedzielski/doxymacs" :files ("lisp/*.el"))
  :commands doxymax-mode
  :hook (c-mode-common-hook . doxy-custom-c-mode-hook)
  :config
  (defun doxy-custom-c-mode-hook ()
    (doxymacs-mode 1)
    (setq doxymacs-doxygen-style "C++")
    (setq doxymacs-command-character "@")))

(leaf markdown-mode :straight t)

(leaf plantuml-mode
  :straight (plantuml-mode :type git :host github :repo "skuro/plantuml-mode")
  :mode "\.pu$"
  :custom (plantuml-output-type . "png")
	   (plantuml-options . "-charset UTF-8")
  :bind ((plantuml-mode-map
	  ("C-c C-c" . plantuml-preview-current-block))))

(leaf python*
  (leaf python-mode :straight t)
  (leaf auto-virtualenvwrapper
    :straight t
    :hook (python-mode-hook . auto-virtualenvwrapper-activate)))

(leaf rustic
  :straight t
  :custom (rustic-lsp-client . 'eglot))

(leaf yatex
  :straight t
  :commands yatex-mode
  :mode (("\\.tex$" . yatex-mode)
         ("\\.ltx$" . yatex-mode)
         ("\\.cls$" . yatex-mode)
         ("\\.sty$" . yatex-mode)
         ("\\.clo$" . yatex-mode)
         ("\\.bbl$" . yatex-mode))
  :custom ((YaTeX-kanji-code . nil)
	   (tex-command . "uplatex")
	   (dvi2-command . "xdvi")
	   (bibtex-command . "upbibtex")
	   (dviprint-command-format . "dvipdfmx"))
  :hook ((yatex-mode-hook . (lambda () (auto-fill-mode -1)))
	 (yatex-mode-hook . yas-global-mode)))
