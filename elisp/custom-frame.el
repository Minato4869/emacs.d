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

;;(remove-hook 'before-make-frame-hook 'my/before-make-frame t)
(add-hook    'before-make-frame-hook
						 (lambda ()
							 (setq default-frame-alist '((width  . 97) (height . 56))
										 initial-frame-alist '((width  . 97) (height . 56)))))


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
