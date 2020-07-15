;; disabled keybinds
(global-unset-key (kbd "C-x C-0"))
(global-unset-key (kbd "C-x C-="))
(global-unset-key (kbd "C-x C--"))
(global-unset-key (kbd "C-x C-+"))
;; custom functions
(defun text-scale-reset ()
  (interactive)
  (text-scale-set 0))
(defun other-window-or-frame ()
  (interactive)
  (if (one-window-p)
      (other-frame 1)
    (other-window 1)))

(defun reverse-other-window-or-frame ()
  (interactive)
  (if (one-window-p)
      (other-frame -1)
    (other-window -1)))
;; windows
(bind-keys
 ;; windows
 ("s-1"     . delete-other-windows)
 ("s-2"     . split-window-below)
 ("s-3"     . split-window-right)
 ("C-x 4"   . make-frame-command)
 ;; buffers
 ("s-d"     . ido-dired)
 ("s-r"     . revert-buffer)
 ("s-b"     . ibuffer)
 ;; text scale
 ("C-="     . text-scale-increase)
 ("C--"     . text-scale-decrease)
 ;; custom functions
 ("C-0"     . text-scale-reset)
 ("M-o"     . other-window-or-frame)
 ("C-x C-o" . other-frame)
 ("C-c o"   . reverse-other-window-or-frame)
 ("C-c C-o" . reverse-other-window-or-frame))

 (if (one-window-p)
    (bind-key "C-x o" 'other-frame)
  (bind-key  "C-x o"  'other-window))
