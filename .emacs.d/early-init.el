;;; early-init.el --- -*- coding: utf-8; lexical-binding: t -*-

;; early-init.elの読み込み検出
(defvar early-init-loaded t)

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
