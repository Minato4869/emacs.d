(defun my/frame-configuration (frame)
  "fix background/foreground colors for emacsclient within terminals
  emacs.stackexchange.com/questions/41/start-two-separate-emacs-daemons-for-console-and-gui"
  (with-selected-frame frame
    (unless (display-graphic-p)
      (set-tmux-keys))
    (when (getenv "TMUX")
      (setq-default elscreen-prefix-key "\C-t"))))

(add-hook 'after-make-frame-functions 'my/frame-configuration)

(display-time-mode t)
(display-battery-mode t)
(keychain-refresh-environment)
(load-library-wrap-error "custom-desktop-save")
(defun ask-before-closing ()
  (interactive)
  (if (y-or-n-p (format "Really exit Emacs?"))
      (progn
        (save-some-buffers)
        (delete-frame))
    (message "Quit")))
(global-set-key (kbd "C-x C-c") 'ask-before-closing)
