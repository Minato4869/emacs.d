(setq backup-by-copying t   ; don't clobber symlinks
      version-control t     ; use versioned backups
      delete-old-versions t
      kept-new-versions 12
      kept-old-versions 6)

(let ((backupdir "~/.emacs.d/backup/"))
  (mkdir backupdir t)
  (setq backup-directory-alist `(("." . ,backupdir))))
(let ((autosavedir "~/.emacs.d/autosave/"))
  (mkdir autosavedir t)
  (setq auto-save-file-name-transforms '((".*" "~/.emacs.d/autosave/" t))))

;;(setq backup-directory-alist '(("" . "~/.emacs.d/backup")))
;;(setq auto-save-file-name-transforms '((".*" "~/.emacs.d/autosave/" t)))

;; auto save buffers on focus loss
;;(defun save-all ()
;;  (interactive)
;;  (save-some-buffers t))
;;  (add-hook 'focus-out-hook 'save-all)
