(desktop-save-mode -1)
(setq desktop-path '("~/.local/emacs/")
      desktop-dirname "~/.local/emacs/"
      desktop-base-file-name "emacs-desktop")

(add-hook 'desktop-after-read-hook
          '(lambda ()
             (setq desktop-dirname-tmp desktop-dirname)
             (desktop-remove)
             (setq desktop-dirname desktop-dirname-tmp)))
(defun saved-session ()
  (file-exists-p (concat desktop-dirname "/" desktop-base-file-name)))
(defun session-restore ()
  "Restore a saved emacs session."
  (interactive)
  (if (saved-session)
      (desktop-read)
    (message "No desktop found.")))

(defun session-save ()
  "Save an emacs session."
  (interactive)
  (if (saved-session)
      (if (y-or-n-p "Overwrite existing desktop? ")
          (desktop-save-in-desktop-dir)
        (message "Session not saved."))
    (desktop-save-in-desktop-dir)))

(add-hook 'after-init-hook
          '(lambda ()
             (if (saved-session)
                 (if (y-or-n-p "Restore desktop? ")
                     (session-restore)))))

(defalias 'save-session    'session-save)
(defalias 'restore-session 'session-restore)
