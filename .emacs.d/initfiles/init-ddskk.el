(setq default-input-method "japanese-skk")
(setq skk-japanese-message-and-error t)
(setq skk-version-codename-ja t)
(setq skk-show-icon t)
(setq skk-show-japanese-menu t)
(setq skk-use-color-cursor t)
(setq skk-indicator-use-cursor-color t)
(setq skk-server-host "localhost")
(setq skk-server-portnum 1178)
(setq skk-server-prog "/usr/local/sbin/yaskkserv")
(setq skk-server-jisyo "~/.yaskkserv/SKK-JISYO.L.yaskkserv ~/.yaskkserv/SKK-JISYO.propernoun.yaskkserv")
(setq skk-server-inhibit-startup-server nil)
(setq skk-tut-file (concat user-emacs-directory "el-get/ddskk/etc/SKK.tut"))
(with-eval-after-load-feature 'bind-key
  (bind-key* "<muhenkan>" 'skk-mode)
  (bind-key* "C-j" 'skk-kakutei)
  )
