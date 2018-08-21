(require 'netrc)

;; ブログorgファイルのセーブ先
(setq my-blog-directory "~/wordpress/")

(setq blog (netrc-machine (netrc-parse "~/.netrc") "secret_note" t))
(setq org2blog/wp-blog-alist
      `(("The Secret Note"
	 :url "http://175.132.13.145:8080/xmlrpc.php"
	 :username ,(netrc-get blog "login")
	 :password ,(netrc-get blog "password")
	 :track-posts (,(concat my-blog-directory ".org2blog.org") "Posts"))))
(setq org2blog/wp-use-wp-latex nil)
(setq org-export-show-temporary-export-buffer nil)
