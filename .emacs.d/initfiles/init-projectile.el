(projectile-global-mode)
(setq projectile-completion-system 'helm)

;; windows indexing 高速化のおまじない.
(setq projectile-indexing-method 'alien)
 
;; 大きいプロジェクトだと劇的に速度が改善するらしい.
(setq projectile-enable-caching t)
(when (executable-find "gtags")
  (setq projectile-tags-file-name "GTAGS")
  (setq projectile-tags-command "gtags"))

