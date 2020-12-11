(require 'compile)
(define-compilation-mode ag-mode "Ag"
  "Ag results compilation mode")

(setq ag/binary "ag -Q -S ")

(defun ag/find-file ()
  (interactive)
  (let (filename)
    (setq filename
          (buffer-substring (line-beginning-position) (line-end-position)))
    (if (not (string-match "^[^:numeric:]+\:" filename))
        (find-file-at-point (concat default-directory filename))
      (message "Current line does not contain a filename"))))
(defun ag/kill-buffer ()
  (interactive)
  (let
      (kill-buffer-query-functions)
    (kill-buffer)))
(bind-keys :map ag-mode-map
           ("f"  . ag/find-file)
           ("p"  . compilation-previous-error)
           ("n"  . compilation-next-error)
           ("k"  . ag/kill-buffer))


(defun ag/search-string (string)
  (progn
    (setq string (prin1-to-string string)) ;; escape special chars
      (set (make-local-variable 'command-string)
           (concat ag/binary string))
    (compilation-start command-string #'ag-mode)))

(defun ag ()
  (interactive)
  (let (input)
    (if (use-region-p)
        (setq input (buffer-substring-no-properties (region-beginning) (region-end)))
      (setq input (read-string "ag: ")))
    (ag/search-string input)))

(bind-key "C-c C-s" 'ag)
