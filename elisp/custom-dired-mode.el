(use-package dired-x
  :ensure nil
  :config
  (progn
    (defun cdired/x-mode-setup ()
      (font-lock-mode t)
      (setq dired-omit-verbose nil)
      (setq-default dired-omit-mode t) ;; Turn on Omit mode.
      (dired-hide-details-mode 1))
    (setq-default dired-omit-files "^\\...+$")

    (add-hook 'dired-mode-hook 'cdired/x-mode-setup)
    (defun cdired/sort ()
      "Sort dired listings with directories first."
      (save-excursion
        (let (buffer-read-only)
          (forward-line 2) ;; beyond dir. header
          (sort-regexp-fields t "^.*$" "[ ]*." (point) (point-max)))
        (set-buffer-modified-p nil)))

    (defadvice cdired/readin
        (after dired-after-updating-hook first () activate)
      "Sort dired listings with directories first before adding marks."
      (cdired/sort))))

(use-package dired
  :ensure nil
  :bind
  (:map dired-mode-map
        ("C-h" . dired-omit-mode)
        ("<left>" . dired-jump)
        ("q" . dired-jump)
        ("<return>" . dired-find-file)
        ("<right>" . dired-find-file)
        ("C-<right>" . dired-find-file-other-window)
        ("S-<return>" . dired-find-file-other-window)
        ("C-<return>" . dired-find-file-other-window)
        ("C-d" . dired-hide-details-mode)
        ("R" . dired-do-rename)
        ("r" . revert-buffer)
        (":" . execute-extended-command)))
