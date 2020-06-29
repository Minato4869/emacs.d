(require 'cl)
(defun custom-parse-tramp-path (path)
  (with-temp-buffer
    (insert path)
    (goto-char (point-min))
    (if (condition-case nil
      (re-search-forward "^/\\(?:\\([^:@]+\\):\\)?\\(?:\\([^:@]+\\)@\\)?\\([^:@]+\\):\\([^:@]+\\)?")
    (error nil))
  (loop for i from 1 to 4
      collect (match-string i)))))

(defun custom-open-term (term &optional dir)
  (interactive)
  (let ((default-directory (or dir default-directory))
        (path  (nth 3 (custom-parse-tramp-path default-directory)))
        (host   (nth 2 (custom-parse-tramp-path default-directory)))
        (user   (nth 1 (custom-parse-tramp-path default-directory)))
        (proto (nth 0 (custom-parse-tramp-path default-directory))))
    (if (and (equal proto "ssh") path)
        (if  (equal (length user) 0)
            (progn
              (message
               "Edit ~/.ssh/config or use tramp via <user>@<host>")
              (call-process term nil 0))
          (call-process term nil 0 term "-e" "ssh" "-X" "-t" "-l"
                        user host (format "cd %s; exec $SHELL" path)))
      (call-process term nil 0))))

(defun run-term ()
  (interactive)  (custom-open-term "rxvt"))
(defun run-fterm ()
  (interactive)  (custom-open-term "fterm"))
(defun run-beamer-term ()
  (interactive)  (custom-open-term "beamer"))

(global-set-key (kbd "<s-return>") 'run-term)
(global-set-key (kbd "C-c <return>") 'run-term)
(global-set-key (kbd "C-x <return>") 'run-term)
(global-set-key (kbd "C-c C-t") 'run-beamer-term)
