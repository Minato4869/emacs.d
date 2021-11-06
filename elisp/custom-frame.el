(defun my/frame-configuration (frame)
  (with-selected-frame frame
    (when (and (getenv "TMUX") (not (display-graphic-p)))
      (let ((map (copy-keymap xterm-function-map)))
        (set-keymap-parent map (keymap-parent input-decode-map))
        (set-keymap-parent input-decode-map map)))))

(remove-hook 'after-make-frame-functions 'my/frame-configuration t)
(add-hook 'after-make-frame-functions 'my/frame-configuration)

(display-time-mode t)
(display-battery-mode t)
