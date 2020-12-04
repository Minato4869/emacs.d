(require 'compile)


(define-compilation-mode ag-mode "Ag"
  "Ag results compilation mode")

(bind-keys :map ag-mode-map
           ("p"  . compilation-previous-error)
           ("n"  . compilation-next-error)
           ("k"  . (lambda () (interactive)
                     (let (kill-buffer-query-functions) (kill-buffer)))))

(defun ag/string (string)
  (progn
    (set (make-local-variable 'command-string)
         (concat "ag " string))
    (compilation-start
     command-string
     #'ag-mode)))

(defun ag ()
  (interactive)
  (if (use-region-p)
      (let
          ((input (buffer-substring-no-properties (region-beginning) (region-end))))
        (ag/string input))
    (let
        ((input (read-string "ag: ")))
      (ag/string input))))

(bind-key "C-c C-s" 'ag)
