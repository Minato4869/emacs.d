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
  (insert (format-time-string "%a %e %b (%Y-%m-%d)")))
(defun ldate ()
  (interactive)
  (insert (format-time-string "%a %b %e %H:%M  %Y (%Y-%m-%d)")))


(defun load-note (file)
  (find-file (concat "~/" file))
  (auto-revert-mode)
  (org-mode)
  (end-of-buffer))

(defun rem ()
  (interactive)
  (load-note "reminder.org"))
(defun rema ()
  (interactive)
  (load-note "reminder.archive.org"))
(defalias 'arem 'rema)

(defun n ()
  (interactive)
  (load-note "notes.org"))

(defun nlc ()
  (interactive)
  (load-note ".local/notes.local"))

(defun plan ()
  (interactive)
  (load-note ".plan"))

(defun uni ()
  (interactive)
  (load-note ".local/uni_notes.org"))
(defun til ()
  (interactive)
  (load-note ".local/til_notes.org"))
