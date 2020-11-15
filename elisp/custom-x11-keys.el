;; disabled keybinds
(global-unset-key (kbd "C-x C-0"))
(global-unset-key (kbd "C-x C-="))
(global-unset-key (kbd "C-x C--"))
(global-unset-key (kbd "C-x C-+"))
;; custom functions
(defun text-scale-reset ()
  (interactive)
  (text-scale-set 0))
(defun reverse-other-frame ()
  (interactive)
  (other-frame -1))
;; windows
(bind-keys
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
 ("<s-tab>" . other-window)
 ;; buffers
 ("s-d"     . ido-dired)
 ("s-r"     . revert-buffer)
 ("s-b"     . ibuffer)
 ;; text scale
 ("C-="     . text-scale-increase)
 ("C--"     . text-scale-decrease)
 ;; custom functions
 ("C-0"     . text-scale-reset)
 ("C-x C-o" . other-frame)
 ("C-c C-o" . reverse-other-frame))
