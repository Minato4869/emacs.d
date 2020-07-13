(setq org-default-notes-file (concat org-directory "~/.local/notes.org"))

(setq org-capture-templates
      '(("t" "Todo" entry (file+headline "~/org/gtd.org" "Tasks")
         "* TODO %?\n  %i\n  %a")
        ("j" "Journal" entry (file+datetree "~/org/journal.org")
         "* %?\nEntered on %U\n  %i\n  %a")))
(bind-key :maporg-mode-map
          ("C-c e" . org-latex-export-to-pdf))
