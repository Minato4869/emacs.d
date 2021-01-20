;; disabled keybinds
(global-unset-key (kbd "C-x C-="))
(global-unset-key (kbd "C-x C--"))
(global-unset-key (kbd "C-x C-+"))
;; custom functions
(defun text-scale-reset ()
  (interactive)
  (text-scale-set 0))
;;; copy and paste
(defun yank-primary ()
  "Yank primary selection."
  (interactive)
  (insert (gui-get-primary-selection)))

(defun other-frame-or-window ()
  (interactive)
  (if (one-window-p)
      (other-frame 1)
    (other-window 1)))

(bind-keys
 ("C-M-y"   . yank-primary)
 ("C-M-v"   . yank-primary)
 ;; windows
 ("C-1"     . delete-other-windows)
 ("C-2"     . split-window-below)
 ("C-3"     . split-window-right)
 ("C-4"     . make-frame-command)
 ("s-1"     . delete-other-windows)
 ("s-2"     . split-window-below)
 ("s-3"     . split-window-right)
 ("s-4"     . make-frame-command)
 ("C-x 4"   . make-frame-command)
 ("s-0"     . delete-window)
 ("C-x M-o" . other-frame)
 ("s-j"          . other-window)
 ("s-k"          . backward-other-window)
 ;; buffers
 ("s-d"     . dired-jump)
 ("s-r"     . revert-buffer)
 ("s-b"     . ibuffer)
 ;; text scale
 ("C-="     . text-scale-increase)
 ("C--"     . text-scale-decrease)
 ;; custom functions
 ("C-0"     . text-scale-reset)
 ("C-c o"   . other-frame)
 ("<s-left>"  . previous-buffer)
 ("<s-right>" . next-buffer))
