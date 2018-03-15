(add-to-list 'auto-mode-alist '("\.pu$" . plantuml-mode))
(setq plantuml-output-type "png")
(setq plantuml-options "-charset UTF-8")
(with-eval-after-load-feature 'bind-key
  (bind-key "C-c C-c" 'plantuml-preview-current-block) 'plantuml-mode-map)
