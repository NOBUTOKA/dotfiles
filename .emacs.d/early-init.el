;;; early-init.el --- -*- coding: utf-8; lexical-binding: t -*-

;; early-init.elの読み込み検出
(defvar early-init-loaded t)

;; XDG_DATA_HOME dir 設定
(defvar data-home-dir (or (getenv "XDG_DATA_HOME") "~/.local/share/emacs"))

;; XDG_CACHE_HOME dir 設定
(defvar cache-home-dir (or (getenv "XDG_CACHE_HOME") "~/.cache/emacs"))

;; eln-cacheの置き場指定
(when (featurep 'native-compile)
  (setq native-comp-eln-load-path
        (list (expand-file-name
               "emacs/eln-cache/"
               (or (getenv "XDG_CACHE_HOME")
                   "~/.cache/")))))

(setq tramp-persistency-file-name (expand-file-name "tramp" cache-home-dir))
(setq transient-history-file (expand-file-name "transient/history" cache-home-dir))

;; パッケージはstraight.elに管理させる
(setq package-enable-at-startup nil)

;; 起動中は GC を抑制（後で元に戻す）
(setq gc-cons-threshold most-positive-fixnum)

;; 起動完了後に通常値に戻す
(add-hook 'emacs-startup-hook
          (lambda ()
            (setq gc-cons-threshold (* 16 1024 1024)))) ; 16MB

(add-to-list 'default-frame-alist '(fullscreen . maximized))

;; disable-bell
(setq ring-bell-function 'ignore)
