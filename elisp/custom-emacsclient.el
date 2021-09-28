(defun my/frame-configuration (frame)
  (with-selected-frame frame
    (unless (display-graphic-p)
        (set-tmux-keys))))

(remove-hook 'after-make-frame-functions 'my/frame-configuration t)
(add-hook 'after-make-frame-functions 'my/frame-configuration)

(display-time-mode t)
(display-battery-mode t)
(keychain-refresh-environment)
(load-library-wrap-error "custom-desktop-save")
(defun ask-before-closing ()
  (interactive)
  (if (display-graphic-p)
       (if (y-or-n-p (format "Really exit Emacs?"))
           (progn
             (save-some-buffers)
             (delete-frame))
         (message "Quit"))
    (delete-frame)))
(global-set-key (kbd "C-x C-c") 'ask-before-closing)

;;  "fix background/foreground colors for emacsclient within terminals
;;  emacs.stackexchange.com/questions/41/start-two-separate-emacs-daemons-for-console-and-gui"
