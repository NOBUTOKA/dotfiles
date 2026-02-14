;;; init-languages.el --- -*- coding: utf-8; lexical-binding: t -*-

(leaf *clang
  :config
  (leaf cc-mode
    :preface
    (defun cc-mode-init ()
      (c-set-style "stroustrup")
      (c-set-offset 'access-label '/)
      (c-set-offset 'innamespace 0)
      (setq-local c-auto-newline nil)
      (setq-local c-hungry-delete-key nil)
      (setq-local c-basic-offset 4)
      (setq-local tab-width 4))
    :hook (((c-mode-hook c++-mode-hook) . cc-mode-init)
	   ((c-mode-hook c++-mode-hook) . eglot-ensure)))

  (leaf cmake-mode
    :ensure t
    :mode "CMakeLists\\.txt\\'" "\\.cmake\\'"
    :hook (cmake-mode-hook . eglot-ensure)))

(leaf c-sharp
  :hook (c-charp-mode-hook . eglot-ensure)
  :config
  (eval-when-compile (require 'eglot))
  (with-eval-after-load 'eglot
    (add-to-list 'eglot-server-programs '(csharp-mode . "csharp-ls"))))

(leaf gnuplot-mode
  :ensure t
  :mode "\\.gp$")

(leaf *julia
  :config
  (leaf julia-mode :ensure t)

  (leaf julia-repl :ensure t)

  (leaf eglot-jl
    :ensure t
    :hook ((julia-mode-hook . eglot-ensure)
	   (julia-mode-hook . eglot-jl-init))))

(leaf markdown-mode :ensure t)

(leaf plantuml-mode
  :ensure t
  :mode "\.pu$"
  :custom (plantuml-output-type . "png")
	   (plantuml-options . "-charset UTF-8")
  :bind ((plantuml-mode-map
	  ("C-c C-c" . plantuml-preview-current-block))))

(leaf *python
  (leaf python
    :hook (python-mode-hook . eglot-ensure))

  ;; TODO: auto-virtualenvへの移行を検討
  (leaf auto-virtualenvwrapper
    :ensure t
    :hook (python-mode-hook . auto-virtualenvwrapper-activate)))

(leaf ruby
  :hook ((ruby-mode-hook ruby-ts-mode-hook) . eglot-ensure))

(leaf rustic
  :ensure t
  :hook (rustic-mode-hook . eglot-ensure)
  :custom (rustic-lsp-client . 'eglot)
  :config
  (eval-when-compile (require 'eglot))
  (with-eval-after-load 'eglot
    (add-to-list 'eglot-server-programs '(rustic-mode . "rust-analyzer"))))

(leaf yatex
  :ensure t
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
	 (yatex-mode-hook . yas-minor-mode)))
