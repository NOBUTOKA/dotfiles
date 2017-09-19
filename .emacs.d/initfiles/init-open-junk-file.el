;; open-junk-file
(setq open-junk-file-format "~/org/junk/%Y-%m%d-%H%M%S.")
(with-eval-after-load-feature use-package
    (bind-key "C-x j" 'open-junk-file))

