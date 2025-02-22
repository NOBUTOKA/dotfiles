(el-get-bundle cc-mode)
(el-get-bundle cmake-mode)
(el-get-bundle julia-mode in JuliaEditorSupport/julia-emacs)
(el-get-bundle tpapp/julia-repl)
(el-get-bundle non-Jedi/eglot-jl)
(el-get-bundle pniedzielski/doxymacs
  :load-path ("./lisp")
  :build (("./bootstrap") ("./configure") ("make"))
  :prepare (progn
             (autoload 'doxymacs-mode "doxymacs" nil t)))
(el-get-bundle markdown-mode)
(el-get-bundle skuro/plantuml-mode)
(el-get-bundle python-mode)
(el-get-bundle brotzeit/rustic)
(el-get-bundle yatex
  :type hg
  :url "http://www.yatex.org/hgrepos/yatex"
  :branch "dev")
