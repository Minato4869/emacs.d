(defun es/shell-other-window()
	(let ((buf (eshell)))
		(switch-to-buffer (other-buffer buf))
		(switch-to-buffer-other-window buf)))

(defun es/shell()
	(interactive)
	(cond
   ((eq "*scratch*" (window-buffer (selected-window)))
		(es/shell-other-window))
	 ((get-buffer-window "*scratch*")
		(eshell))
	 (t
    (es/shell-other-window))))

(bind-key "C-c s" 'es/shell)

(defalias 'es 'es/shell)
