(defun term-send-forward-char ()
  (interactive)
  (term-send-raw-string "\C-f"))

(defun term-send-backward-char ()
  (interactive)
  (term-send-raw-string "\C-b"))

(defun term-send-previous-line ()
  (interactive)
  (term-send-raw-string "\C-p"))

(defun term-send-next-line ()
  (interactive)
  (term-send-raw-string "\C-n"))

(with-eval-after-load-feature 'use-package
  (bind-key "C-f" 'term-send-forward-char term-raw-map)
  (bind-key "C-b" 'term-send-backward-char term-raw-map)
  (bind-key "C-p" 'term-send-previous-line term-raw-map)
  (bind-key "C-n" 'term-send-next-line term-raw-map)
  )
