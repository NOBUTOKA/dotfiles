(el-get-bundle! exec-path-from-shell)
(el-get-bundle! use-package)
(el-get-bundle! with-eval-after-load-feature
  in tarao/with-eval-after-load-feature-el)
(el-get-bundle! keyfreq)
(el-get-bundle! ChillarAnand/real-auto-save)
(el-get-bundle ddskk)
(el-get-bundle yasnippet)
(el-get-bundle company in company-mode/company-mode)
(el-get-bundle elpa:eldoc)
(el-get-bundle elpa:flymake)
(el-get-bundle elpa:jsonrpc)
(el-get-bundle eglot
  :depends (eldoc flymake jsonrpc))
(el-get-bundle jojojames/smart-jump
  :depends dumb-jump
  (smart-jump-setup-default-registers))
(el-get-bundle helm)
(el-get-bundle helm-tramp)
(el-get-bundle projectile)
(el-get-bundle helm-projectile)
(el-get-bundle helm-company)
(el-get-bundle smartparens)
(el-get-bundle magit)
;; (el-get-bundle magit-gh-pulls
;;   :depends (gh magit pcache s magit-popup))
(el-get-bundle jtatarik/magit-gitflow
  :depends (magit-popup))
(el-get-bundle codic)
(el-get-bundle mew)
(el-get-bundle helm-c-yasnippet)
(el-get-bundle gnuplot-mode)
(el-get-bundle howm)
