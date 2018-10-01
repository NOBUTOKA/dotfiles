(setq howm-menu-lang 'ja)
(with-eval-after-load-feature 'bind-key
  (bind-key* "C-c , ," 'howm-menu))
(mapc
 (lambda (f)
   (autoload f
     "howm" "Hitori Otegaru Wiki Modoki" t))
 '(howm-menu howm-list-all howm-list-recent
             howm-list-grep howm-create
             howm-keyword-to-kill-ring))
