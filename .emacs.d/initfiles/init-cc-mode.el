(defun cc-mode-init ()
  (c-set-style "stroustrup")
  (c-set-offset 'access-label '/)
  (c-set-offset 'innamespace 0)
  (setq c-auto-newline nil)
  (setq c-hungry-delete-key nil)
  (setq c-basic-offset 4)
  (setq tab-width 4)
  )
(add-hook 'c-mode-hook 'cc-mode-init)
(add-hook 'c++-mode-hook 'cc-mode-init)

(defun c++-mode-hooks()
  (font-lock-add-keywords
   nil '(
	 ("\\<\\(alignof\\|alignas\\|constexpr\\|decltype\\|noexcept\\|nullptr\\|static_assert\\|thread_local\\|override\\|final\\)\\>"
	  . 'font-lock-keyword-face)
	 )
   ))
(add-hook 'c++-mode-hook 'c++-mode-hooks)
