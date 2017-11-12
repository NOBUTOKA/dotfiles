(autoload 'haskell-cabal "haskell-cabal" nil t)

(add-to-list 'auto-mode-alist '("\\.hs$" . haskell-mode))
(add-to-list 'auto-mode-alist '("\\.lhs$" . literate-haskell-mode))
(add-to-list 'auto-mode-alist '("\\.cabal\\'" . haskell-cabal-mode))

;; indent の有効.
(add-hook 'haskell-mode-hook 'turn-on-haskell-indentation)
(add-hook 'haskell-mode-hook 'turn-on-haskell-doc-mode)
(add-hook 'haskell-mode-hook 'font-lock-mode)
(add-hook 'haskell-mode-hook 'imenu-add-menubar-index)

(add-to-list 'interpreter-mode-alist '("runghc" . haskell-mode))
(add-to-list 'interpreter-mode-alist '("runhaskell" . haskell-mode))

(add-hook 'haskell-mode-hook
	  #'(lambda()
	      (interactive)
	      ;; インデント
	      (turn-on-haskell-indentation)
	      (turn-on-haskell-doc-mode)
	      (font-lock-mode)
	      (imenu-add-menubar-index)
	      ;; GHCi のコマンドを設定
	      (setq haskell-program-name-with-args '("/usr/bin/stack" . "-O"))
	      (interactive-haskell-mode)
	      )
	  )

(with-eval-after-load-feature 'flycheck
  (add-hook 'haskell-mode-hook
	    '(lambda ()
             (setq flycheck-checker 'haskell-hlint)
             (flycheck-mode 1))))


(defadvice inferior-haskell-load-file (after change-focus-after-load)
  "Change focus to GHCi window after C-c C-l command"
  (other-window 1))
(ad-activate 'inferior-haskell-load-file)
