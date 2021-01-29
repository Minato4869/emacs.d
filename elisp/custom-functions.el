(defun arrayify (start end quote)
  "Turn strings on newlines into a QUOTEd, comma-separated one-liner."
  (interactive "r\nMQuote: ")
  (let ((insertion
         (mapconcat
          (lambda (x) (format "%s%s%s" quote x quote))
          (split-string (buffer-substring start end)) ", ")))
    (delete-region start end)
    (insert insertion)))

(defun yas-force-update ()
  (interactive)
  (yas-recompile-all)
  (yas-reload-all))
(defalias 'yas 'yas-force-update)

(defun ymd ()
  (interactive)
  (insert (format-time-string "%Y-%m-%d")))

(defun date ()
  (interactive)
  (insert (format-time-string "%a %b %e %H:%M  %Y (%Y-%m-%d)")))

(defun rem ()
  (interactive)
  (find-file "~/reminder.org")
  (auto-revert-mode)
  (end-of-buffer))

(defun n ()
  (interactive)
  (find-file "~/notes.org")
  (auto-revert-mode)
  (org-mode)
  (end-of-buffer))

(defun nl ()
  (interactive)
  (find-file "~/.local/notes.local")
  (auto-revert-mode)
  (org-mode)
  (end-of-buffer))
