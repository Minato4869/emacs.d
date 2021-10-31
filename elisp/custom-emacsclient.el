(defun my/frame-configuration (frame)
  (with-selected-frame frame
    (when (getenv "TMUX")
      (set-tmux-keys))
    (if (not (display-graphic-p))
        (setq elscreen-display-tab nil
              elscreen-display-screen-number t)
      (progn
        (setq elscreen-display-tab nil
              elscreen-display-screen-number t)))))

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

(defun my-update-env (fn)
  "https://emacs.stackexchange.com/a/6107"
  (let ((str
         (with-temp-buffer
           (insert-file-contents fn)
           (buffer-string))) lst)
    (setq lst (split-string str "\000"))
    (while lst
      (setq cur (car lst))
      (when (string-match "^\\(.*?\\)=\\(.*\\)" cur)
        (setq var (match-string 1 cur))
        (setq value (match-string 2 cur))
        (setenv var value))
            (setq lst (cdr lst)))))
