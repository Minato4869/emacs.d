(require 'dired-x)
(setq-default dired-omit-files "^\\...+$")
(defun dired-mode-setup ()
  (font-lock-mode t)
  (setq-default dired-omit-mode t) ;; Turn on Omit mode.
  (dired-hide-details-mode 1))
(add-hook 'dired-mode-hook 'dired-mode-setup)

(define-key dired-mode-map (kbd "C-h") 'dired-omit-mode)
(define-key dired-mode-map (kbd "<left>") 'dired-jump)
(define-key dired-mode-map (kbd "q") 'dired-jump)
(define-key dired-mode-map (kbd "<right>") 'dired-find-file)
(define-key dired-mode-map (kbd "<return>") 'dired-find-file)
(define-key dired-mode-map (kbd "S-<return>") 'dired-find-file-other-window)
(define-key dired-mode-map (kbd "C-<return>") 'dired-find-file-other-window)
(define-key dired-mode-map (kbd "C-d") 'dired-hide-details-mode)

(define-key dired-mode-map (kbd "R") 'dired-do-rename)
(define-key dired-mode-map (kbd "r") 'revert-buffer)
(define-key dired-mode-map (kbd ":") 'execute-extended-command)

(defun mydired-sort ()
  "Sort dired listings with directories first."
  (save-excursion
    (let (buffer-read-only)
      (forward-line 2) ;; beyond dir. header
      (sort-regexp-fields t "^.*$" "[ ]*." (point) (point-max)))
    (set-buffer-modified-p nil)))

(defadvice dired-readin
    (after dired-after-updating-hook first () activate)
  "Sort dired listings with directories first before adding marks."
  (mydired-sort))
