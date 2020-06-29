;; scrolling
(defun cua-scroll-up (&optional arg)
  "Scroll text of current window upward ARG lines; or near full screen if no ARG.
If window cannot be scrolled further, move cursor to bottom line instead.
A near full screen is `next-screen-context-lines' less than a full screen.
Negative ARG means scroll downward.
If ARG is the atom `-', scroll downward by nearly full screen."
  (interactive "^P")
  (cond
   ((eq arg '-) (cua-scroll-down nil))
   ((< (prefix-numeric-value arg) 0)
    (cua-scroll-down (- (prefix-numeric-value arg))))
   ((eobp)
    (scroll-up arg))  ; signal error
   (t
    (condition-case nil
	(scroll-up arg)
      (end-of-buffer (goto-char (point-max)))))))

(defun cua-scroll-down (&optional arg)
  "Scroll text of current window downward ARG lines; or near full screen if no ARG.
If window cannot be scrolled further, move cursor to top line instead.
A near full screen is `next-screen-context-lines' less than a full screen.
Negative ARG means scroll upward.
If ARG is the atom `-', scroll upward by nearly full screen."
  (interactive "^P")
  (cond
   ((eq arg '-) (cua-scroll-up nil))
   ((< (prefix-numeric-value arg) 0)
    (cua-scroll-up (- (prefix-numeric-value arg))))
   ((bobp)
    (scroll-down arg))  ; signal error
   (t
    (condition-case nil
	(scroll-down arg)
      (beginning-of-buffer (goto-char (point-min)))))))

(global-set-key (kbd "M-v") 'cua-scroll-down)
(global-set-key (kbd "C-v") 'cua-scroll-up)
(global-set-key (kbd "<prior>") 'cua-scroll-down)
(global-set-key (kbd "<next>") 'cua-scroll-up)
(global-set-key (kbd "s-k") 'kill-buffer-and-window)
(global-set-key (kbd "C-x C-SPC") 'cua-rectangle-mark-mode)
(global-set-key (kbd "M-<up>") 'backward-paragraph)
(global-set-key (kbd "M-<down>") 'forward-paragraph)
(global-set-key (kbd "C-c V") 'beginning-of-buffer)
(global-set-key (kbd "C-c v") 'end-of-buffer)
;; nav misc
(global-set-key (kbd "M-<right>") 'forward-word)
(global-set-key (kbd "M-<left>") 'backward-word)
