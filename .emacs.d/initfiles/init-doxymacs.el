;; custom c-mode hook for doxymacs
(defun doxy-custom-c-mode-hook ()
  (doxymacs-mode 1)
  (setq doxymacs-doxygen-style "C++")
  (setq doxymacs-command-character "@"))

(add-hook 'c-mode-common-hook 'doxy-custom-c-mode-hook)
