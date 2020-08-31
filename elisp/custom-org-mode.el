

(use-package org
  :ensure nil
  :config
  (progn
    (setq org-default-notes-file "~/.local/notes.org")
    (setq org-capture-templates
          '(("t" "Todo" entry (file+headline "~/org/gtd.org" "Tasks")
             "* TODO %?\n  %i\n  %a")
            ("j" "Journal" entry (file+datetree "~/org/journal.org")
             "* %?\nEntered on %U\n  %i\n  %a"))))
  :bind
  (:map org-mode-map
        ("C-c C-c" . org-latex-export-to-pdf)))
