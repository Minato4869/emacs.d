(use-package ace-window
  :ensure nil
  :config
  (setq aw-keys '(?a ?s ?d ?f ?g ?h ?j ?k ?l))
  :bind
  (("C-x C-o" . ace-window)
   ("C-c o"   . ace-window)))
