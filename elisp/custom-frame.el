(defun is_tmux ()
	(if (= (length (getenv "TMUX")) 0)
			nil
		t))

(defun set-tmux-keys ()
	(let ((map (copy-keymap xterm-function-map)))
		(set-keymap-parent map (keymap-parent input-decode-map))
		(set-keymap-parent input-decode-map  xterm-function-map)))

(defun my/after-make-frame (frame)
	(with-selected-frame frame
		(when (is_tmux)
			(set-tmux-keys))))
(remove-hook 'after-make-frame-functions 'my/after-make-frame t)
(add-hook    'after-make-frame-functions 'my/after-make-frame)

(when (my_daemonp)
	(setq frame/w 80
				;; frame/h (if (< (x-display-pixel-height) 768)  57 48)
				frame/h 57
				default-frame-alist `((width  . ,frame/w) (height . ,frame/h))
				initial-frame-alist `((width  . ,frame/w) (height . ,frame/h)))
	(defun my/after-delete-frame (frame)
		(with-selected-frame frame
			(when (is_ssh)
				(setenv "SSH_CONNECTION" ""))))

	(remove-hook 'after-delete-frame-functions 'my/after-delete-frame t)
	(add-hook    'after-delete-frame-functions 'my/after-delete-frame))

(when (or (display-graphic-p) (daemonp))
	(unless (file-regular-p "~/git/dotfiles/x11/Xresources")
		(scroll-bar-mode -1)
		(tool-bar-mode -1)))

(display-time-mode t)
;;(display-battery-mode t)

(when (is_tmux)
	(defadvice terminal-init-screen
			;; The advice is named `tmux', and is run before `terminal-init-screen' runs.
			(before tmux activate)
		;; Docstring.  This describes the advice and is made available inside emacs;
		;; for example when doing C-h f terminal-init-screen RET
		"Apply xterm keymap, allowing use of keys passed through tmux."
		;; This is the elisp code that is run before `terminal-init-screen'.
		(set-tmux-keys)))
