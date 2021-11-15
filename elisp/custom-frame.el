(defun set-tmux-keys ()
    (let ((map (copy-keymap xterm-function-map)))
      (set-keymap-parent map (keymap-parent input-decode-map))
      (set-keymap-parent input-decode-map map)))

(defun my/frame-configuration (frame)
  (with-selected-frame frame
      (when (getenv "TMUX")
        (set-tmux-keys))))

(when (and (getenv "TMUX") (not (display-graphic-p)))
  (set-tmux-keys))
(remove-hook 'after-make-frame-functions 'my/frame-configuration t)
(add-hook 'after-make-frame-functions 'my/frame-configuration)

(setq w/width 100
      w/height 65)
(add-hook 'before-make-frame-hook
          (lambda ()
            (setq default-frame-alist `((width  . ,w/width) (height . ,w/height))
                  initial-frame-alist `((width  . ,w/width) (height . ,w/height)))))
(unless (file-regular-p "~/git/dotfiles/x11/Xresources")
  (scroll-bar-mode -1)
  (tool-bar-mode -1))

(display-time-mode t)
;;(display-battery-mode t)
