(defvar gl/colours nil
  "Variable used to toggle gl-dark theme between standard and mono grey")
(defun toggle-font-lock-mode ()
  (interactive)
  (if  (or (equal major-mode 'org-mode)
           (equal major-mode 'dired-mode)
           (equal major-mode 'diff-mode)
           (equal major-mode 'org-mode))
      (font-lock-mode t)
    (font-lock-mode -1)))

(add-hook 'diff-mode-hook 'turn-on-font-lock)
(add-hook 'dired-mode-hook 'turn-on-font-lock)
(add-hook 'magit-mode-hook 'turn-on-font-lock)
(add-hook 'org-mode-hook   'turn-on-font-lock)
(defun cycle-themes ()
  (interactive)
  (load-theme 'gl-dark t)
  (if gl/colours
      (progn
        (setq gl/colours nil)
        (font-lock-mode t))
    (progn
      (setq gl/colours t)
      (toggle-font-lock-mode))))

(load-theme 'gl-dark t)
(unless gl/colours
  (global-font-lock-mode 0))

(bind-keys
 ("<f2>"   . cycle-themes)
 ("S-<f2>" . cycle-bg))
