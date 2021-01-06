(defun cterm/parse-tramp-path (path)
  (with-temp-buffer
    (insert path)
    (goto-char (point-min))
    (if (condition-case nil
      (re-search-forward "^/\\(?:\\([^:@]+\\):\\)?\\(?:\\([^:@]+\\)@\\)?\\([^:@]+\\):\\([^:@]+\\)?")
    (error nil))
  (cl-loop for i from 1 to 4
      collect (match-string i)))))

(defun cterm/open-term (term &optional dir)
  (let ((default-directory (or dir default-directory))
        (path  (nth 3 (cterm/parse-tramp-path default-directory)))
        (host  (nth 2 (cterm/parse-tramp-path default-directory)))
        (user  (nth 1 (cterm/parse-tramp-path default-directory)))
        (proto (nth 0 (cterm/parse-tramp-path default-directory))))
    (if (and (equal proto "ssh") path)
        (if  (equal (length user) 0)
            (progn
              (message
               "Edit ~/.ssh/config or use tramp via <user>@<host>")
              (call-process term nil 0))
          (call-process term nil 0 term "-e" "ssh" "-t" "-l"
                        user host (format "cd %s; exec $SHELL" path)))
      (call-process term nil 0))))

(defun cterm/open-local-term (term)
 	(let ((default-directory default-directory))
 		(start-process term nil term)))

(defun run-term ()
  (interactive)  (cterm/open-term "~/bin/rxvt"))
(defun run-local-term ()
  (interactive)  (cterm/open-local-term "~/bin/rxvt"))
(defun run-beamer-term ()
  (interactive)  (cterm/open-term "~/bin/beamer"))

(bind-keys*
 ("<M-S-return>"   . run-term)
 ("<s-return>"     . run-term)
 ("C-c <return>"   . run-term)
 ("C-c C-<return>" . run-local-term)
 ("C-x <return>"   . run-term)
 ("C-c C-t"        . run-beamer-term))
