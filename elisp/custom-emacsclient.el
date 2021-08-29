(defun my/frame-configuration (frame)
  "fix background/foreground colors for emacsclient within terminals
  emacs.stackexchange.com/questions/41/start-two-separate-emacs-daemons-for-console-and-gui"
  (with-selected-frame frame
    (unless (display-graphic-p)
      (set-tmux-keys)
      (set-background-color "unspecified-bg")
      (set-foreground-color "unspecified-fg"))))

(add-hook 'after-make-frame-functions 'my/frame-configuration)
