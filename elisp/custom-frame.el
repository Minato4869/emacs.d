(defun set-tmux-keys ()
	(let ((map (copy-keymap xterm-function-map)))
		(set-keymap-parent map (keymap-parent input-decode-map))
		(set-keymap-parent input-decode-map map)))

(defun my/after-make-frame (frame)
	(with-selected-frame frame
		(when (getenv "TMUX")
			(set-tmux-keys))))

(remove-hook 'after-make-frame-functions 'my/after-make-frame t)
(add-hook    'after-make-frame-functions 'my/after-make-frame)
;;(defun my/frame-geom ()
;;	(let ((frame/w 80)
;;				(frame/h 48))
;;		(add-to-list default-frame-alist `((width  . frame/w) (height . frame/h)))
;;		(add-to-list initial-frame-alist `((width  . frame/w) (height . frame/h)))))
;;(setq before-make-frame-hook nil)
;;(add-hook  'before-make-frame-hook 'my/frame-geom)


(defun my/after-delete-frame (frame)
	(with-selected-frame frame
		(when (getenv "SSH_CONNECTION")
			(setenv "SSH_CONNECTION" ""))))

(remove-hook 'after-delete-frame-functions 'my/after-delete-frame t)
(add-hook    'after-delete-frame-functions 'my/after-delete-frame)

(unless (file-regular-p "~/git/dotfiles/x11/Xresources")
	(scroll-bar-mode -1)
	(tool-bar-mode -1))

(display-time-mode t)
;;(display-battery-mode t)


(when (and (getenv "TMUX") (not (display-graphic-p)))
	(set-tmux-keys))
