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

(leaf csharp
  :hook (csharp-mode-hook . eglot-ensure)
  :config
  (eval-when-compile (require 'eglot))
  (with-eval-after-load 'eglot
    (add-to-list 'eglot-server-programs '(csharp-mode . "csharp-ls"))))

(leaf *conf-modes
  :config
  (leaf ssh-config-mode
    :ensure t
    :custom (ssh-config-mode-indent . 4)))

(leaf dockerfile-mode :ensure t)

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

(leaf matlab-ts-mode
  :ensure matlab-mode
  :init
  (defvar my/matlab-ls-path (expand-file-name "~/.local/share/MATLAB-language-server/out/index.js")
    "Path to Matlab language server")
  (defvar my/matlab-path nil "Path to Matlab")
  (defvar my/matlab-lsp-use-docker nil)
  (defvar my/matlab-lsp-docker-image "matlab-for-lsp:R2023b-lic")
  (defun my/matlab-lsp-create-docker-command (_)
      (let ((mount-path (expand-file-name (if (project-current)
					      (project-root (project-current))
					    default-directory))))
	(list "docker" "run" "--interactive" "--init" "-v" (concat mount-path ":" mount-path) my/matlab-lsp-docker-image)))
  :hook ((matlab-mode-hook matlab-ts-mode-hook) . eglot-ensure)
  :mode ("\\.m\\'" . matlab-mode)
  :custom (matlab-shell-command-switches . '("-nodesktop" "-nosplash" "-licmode" "onlinelicensing"))
  :config
  (eval-when-compile (require 'eglot))
  (with-eval-after-load 'eglot
    (if my/matlab-lsp-use-docker
	(add-to-list 'eglot-server-programs '((matlab-mode matlab-ts-mode) . my/matlab-lsp-create-docker-command))
      (let* ((matlab-lsp-args
	      (if (bound-and-true-p my/matlab-path)
		  (list "node" my/matlab-ls-path "--stdio" "--matlabInstallPath" my/matlab-path "--" "-licmode onlinelicensing")
		(list "node" my/matlab-ls-path "--stdio" "--matlabLaunchCommandArgs" "--" "-licmode onlinelicensing"))))
	(add-to-list 'eglot-server-programs `((matlab-mode matlab-ts-mode) . ,matlab-lsp-args)))
      )))

(leaf plantuml-mode
  :ensure t
  :mode "\.pu$"
  :custom ((plantuml-output-type . "png")
	   (plantuml-options . "-charset UTF-8"))
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
