(with-eval-after-load-feature 'bind-key
  (bind-key "C-c l" 'org-storelink)
  (bind-key "C-c a" 'org-agenda)
  (bind-key "C-c c" 'org-capture))

;; 拡張子がorgのファイルを開いた時，自動的にorg-modeにする
(add-to-list 'auto-mode-alist '("\\.org$" . org-mode))
;; org-modeでの強調表示を可能にする
(add-hook 'org-mode-hook 'turn-on-font-lock)
;; org-default-notes-fileのディレクトリ
(setq org-directory "~/org/")
;; org-default-notes-fileのファイル名
(setq org-default-notes-file "notes.org")

(setq org-src-fontify-natively t)

;; アジェンダ表示の対象ファイル
(setq org-agenda-files (list org-directory))

(setq org-capture-templates
      '(("t" "ToDo" entry (file+headline "~/org/DoItLater.org" "ToDo")
	 "* TODO %?\n%T\n%a")
	("g" "Google it Later" entry (file+headline "~/org/DoItLater.org" "GiL")
	 "* %? \n%T\n%i %a")
	("i" "Idea" entry (file+headline "~/org/notes.org" "Ideas")
	 "* %? \n%T\n%i %a")
	("l" "Lecture Note" entry (file "~/org/LectureNote.org")
	 "* \n:SUBJECT: %?\n%t"
	 :jump-to-captured 1)))

(add-hook 'org-mode-hook 'skk-activate)
(add-hook 'org-mode-hook 'yas-global-mode)

(with-eval-after-load-feature 'ox-latex
  (setq org-latex-default-class "ltjsarticle")
  (setq org-latex-compiler "lualatex")
;;; ドキュメントクラスの追加
  (add-to-list 'org-latex-classes
	       '("ltjsarticle"
		 "\\documentclass[12pt]{ltjsarticle}"
		 ("\\section{%s}" . "\\section*{%s}")
		 ("\\subsection{%s}" . "\\subsection*{%s}")
		 ("\\subsubsection{%s}" . "\\subsubsection*{%s}")
		 ("\\paragraph{%s}" . "\\paragraph*{%s}")
		 ("\\subparagraph{%s}" . "\\subparagraph*{%s}")
		 ))
  (add-to-list 'org-latex-packages-alist '("" "newtxtext") t)
  (add-to-list 'org-latex-packages-alist '("" "newtxmath") t)
  (add-to-list 'org-latex-packages-alist "\\RequirePackage[l2tabu, orthodox]{nag}")
  (add-to-list 'org-latex-packages-alist "\\numberwithin{equation}{section}" t)
  (add-to-list 'org-latex-packages-alist "\\hypersetup{unicode=true}" t)
  (delete '("" "textcomp" t) org-latex-default-packages-alist)
  )
