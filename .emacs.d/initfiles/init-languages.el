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

(leaf *matlab
  :init
  (defvar my/matlab-lsp-use-docker nil)
  (defvar my/matlab-shell-use-docker t)
  :config
  (leaf matlab-mode
    :ensure t
    :hook ((matlab-mode-hook matlab-ts-mode-hook) . eglot-ensure)
    :mode ("\\.m\\'" . matlab-ts-mode))

  (leaf *matlab-eglot-docker
    :when my/matlab-lsp-use-docker
    :init
    (defvar my/matlab-lsp-docker-image "matlab:R2023b-lsp")
    (defun my/matlab-lsp-create-docker-cmd (_)
      (let ((project-path (expand-file-name (if (project-current)
						(project-root (project-current))
					      default-directory))))
	(list "docker" "run" "-i" "--rm" "--init" "-v" "matlab-home:/home/matlab"
	      "-v" (concat project-path ":" project-path) my/matlab-lsp-docker-image)))
    :config
    (eval-when-compile (require 'eglot))
    (with-eval-after-load 'eglot
      (add-to-list 'eglot-server-programs '((matlab-mode matlab-ts-mode) . my/matlab-lsp-create-docker-cmd))))

  (leaf *matlab-eglot
    :unless my/matlab-lsp-use-docker
    :init
    (defvar my/matlab-ls-path (expand-file-name "~/.local/share/MATLAB-language-server/out/index.js"))
    (defvar my/matlab-path nil)
    :config
    (eval-when-compile (require 'eglot))
    (with-eval-after-load 'eglot
      (let* ((matlab-lsp-args
	      (if (bound-and-true-p my/matlab-path)
		  (list "node" my/matlab-ls-path "--stdio" "--matlabInstallPath" my/matlab-path "--" "-licmode onlinelicensing")
		(list "node" my/matlab-ls-path "--stdio" "--" "-licmode onlinelicensing"))))
	(add-to-list 'eglot-server-programs `((matlab-mode matlab-ts-mode) . ,matlab-lsp-args)))))

  (leaf *matlab-shell-docker
    ;; dockerとmatlab-shellの相性が割とよろしくないので、諦めてvtermを使う
    :when my/matlab-shell-use-docker
    :init
    (defvar my/matlab-shell-docker-image "matlab:R2023b-shell")
    (defun my/matlab-vterm-shell-create-docker-cmd ()
      (let* ((project-path (expand-file-name (if (project-current)
						 (project-root (project-current))
					       default-directory))))
	(list "docker" "run" "-it" "--rm" "--init"
	      "-v" "/tmp/.X11-unix/:/tmp/.X11-unix" "-e" "DISPLAY" "-v" "matlab-home:/home/matlab"
	      "-v" (concat project-path ":" project-path) "-w" project-path my/matlab-shell-docker-image)))
    (defun my/matlab-vterm-shell ()
      "Open a vterm shell as a MATLAB docker"
      (interactive)
      (require 'vterm)
      (let ((vterm-shell (string-join (my/matlab-vterm-shell-create-docker-cmd) " ")))
	(vterm "*MATLAB*"))))

  (leaf *matlab-shell
    :unless my/matlab-shell-use-docker
    :custom (matlab-shell-command-switches . '("-nodesktop" "-nosplash" "-licmode" "onlinelicensing")))
  )

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
