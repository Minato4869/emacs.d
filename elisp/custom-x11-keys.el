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
  (insert
   (gui-get-primary-selection)))

(defun copy-primary ()
  "Copy primary selection."
  (interactive)
  (deactivate-mark)
  (gui-set-selection
   'PRIMARY
   (buffer-substring (region-beginning) (region-end))))
;; windows
(bind-keys
 ("C-M-c"       . copy-primary)
 ("C-M-v"       . yank-primary)
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
 ;; buffers
 ;; ("s-d"     . ido-dired)
 ("s-d"     . dired-jump)
 ("s-r"     . revert-buffer)
 ("s-b"     . ibuffer)
 ;; text scale
 ("C-="     . text-scale-increase)
 ("C--"     . text-scale-decrease)
 ;; custom functions
 ("C-0"     . text-scale-reset)
 ("C-c o"    . other-frame))
