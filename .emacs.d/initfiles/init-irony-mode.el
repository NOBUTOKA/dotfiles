(custom-set-variables '(irony-additional-clang-options '("-std=c++11")))
(add-hook 'c-mode-hook 'irony-mode)
(add-hook 'c++-mode-hook 'irony-mode)
(custom-set-variables '(irony-additional-clang-options '("-std=c++11")))
(add-to-list 'company-backends 'company-irony)
(add-hook 'irony-mode-hook 'irony-cdb-autosetup-compile-options)

