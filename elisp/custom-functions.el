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

(defun custom-insert-date ()
  (interactive)
  (insert (format-time-string "%a %b %e %H:%M  %Y (%Y-%m-%d)")))

(defun ag/string (string)
  (progn
    (set (make-local-variable 'compile-command)
         (concat "ag " string))
    (recompile)))

(defun ag ()
  (interactive)
  (if (use-region-p)
      (let
          ((input (buffer-substring-no-properties (region-beginning) (region-end))))
        (ag/string input))
    (let
        ((input (read-string "ag: ")))
      (ag/string input))))
