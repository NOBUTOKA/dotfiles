(add-to-list 'package-archives '("org" . "https://orgmode.org/elpa/") t)
(el-get-bundle org-mode)
(el-get-bundle org-ref
  :depends (pdf-tools))
(el-get-bundle open-junk-file)
(el-get-bundle ox-reveal
  in yjwen/org-reveal)
;; (el-get-bundle org2blog
;;   :depends (htmlize xml-rpc metaweblog))

