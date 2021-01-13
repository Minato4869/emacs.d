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

    (defadvice dired-readin
        (after dired-after-updating-hook first () activate)
      "Sort dired listings with directories first before adding marks."
      (cdired/sort))
    ))

(defun dired-view-file-other-window ()
  (if (one-window-p)
      (split-window-horizontally)
    (split-window-vertically))
  (other-window 1)
  (dired-view-file))

(defun dired-find-or-view ()
  "A `dired-find-file' which only works on directories."
  (interactive)
  (let ((find-file-run-dired t)
        (file (dired-get-file-for-visit)))
    (if (file-directory-p file)
        (find-file file)
      (dired-view-file-other-window))))

(defun dired-jump-previous-dir ()
  (interactive)
  (setq old-buffer (buffer-name))
  (dired-jump)
  (kill-buffer old-buffer))
;;  (message (concat "Killed Dired buffer: " old-buffer)))

(use-package dired
  :ensure nil
  :bind
  (:map dired-mode-map
        ("C-h"        . dired-omit-mode)
        ("q"          . quit-window)
        ("<return>"   . dired-find-file)
        ("C-<return>" . dired-find-file-other-window)
        ("<right>"    . dired-find-or-view)
        ("<left>"     . dired-jump-previous-dir)
        ("C-d"        . dired-hide-details-mode)
        ("R"          . dired-do-rename)
        ("r"          . revert-buffer)
        ("/"          . dired-isearch-filenames)
        (":"          . execute-extended-command)))
