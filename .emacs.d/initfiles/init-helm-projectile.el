;; プロジェクトに関連するファイルをhelm-for-filesに追加
(defadvice helm-for-files (around update-helm-list activate)
  (let ((helm-for-files-preferred-list
         (helm-for-files-update-list)))
    ad-do-it))

(defun helm-for-files-update-list ()
  `(helm-source-buffers-list
    helm-source-recentf
    helm-source-ghq
    helm-source-files-in-current-dir
    helm-source-file-cache
    ,(if (projectile-project-p)
     helm-source-projectile-files-list)))

(helm-projectile-on)
