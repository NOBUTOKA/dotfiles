;;; bootstrap-straight.el --- -*- coding: utf-8; lexical-binding: t -*-

(setq straight-base-dir
      (expand-file-name "emacs"
                        (or (getenv "XDG_DATA_HOME")
                            "~/.local/share/")))

(setq straight-build-dir
      (expand-file-name "emacs/straight/build"
                        (or (getenv "XDG_CACHE_HOME")
                            "~/.cache/")))

(setq straight-use-version-specific-build-dir t)

(defvar bootstrap-version)
(let ((bootstrap-file
       (expand-file-name
        "straight/repos/straight.el/bootstrap.el"
        (or (bound-and-true-p straight-base-dir)
            user-emacs-directory)))
      (bootstrap-version 7))
  (unless (file-exists-p bootstrap-file)
    (with-current-buffer
        (url-retrieve-synchronously
         "https://raw.githubusercontent.com/radian-software/straight.el/develop/install.el"
         'silent 'inhibit-cookies)
      (goto-char (point-max))
      (eval-print-last-sexp)))
  (load bootstrap-file nil 'nomessage))
