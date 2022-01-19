(defvar gl/colours nil
  "Variable used to toggle gl-dark theme between standard and mono grey")

(defvar gl/light nil
  "Variable used to toggle between dark (grey or black) and light theme")
;;(defun my-disable-font-lock-mode ()
;;  (if  (or (equal major-mode 'org-mode)
;;           (equal major-mode 'dired-mode)
;;           (equal major-mode 'diff-mode)
;;           (equal major-mode 'org-mode))
;;      (font-lock-mode t)
;;    (font-lock-mode -1)))

(add-hook 'diff-mode-hook    'turn-on-font-lock)
(add-hook 'dired-mode-hook   'turn-on-font-lock)
(add-hook 'magit-mode-hook   'turn-on-font-lock)
(add-hook 'org-mode-hook     'turn-on-font-lock)
(add-hook 'mail-mode-hook    'turn-on-font-lock)
(add-hook 'Man-mode-hook     'turn-on-font-lock)
(add-hook 'eshell-mode-hook  'turn-on-font-lock)
(add-hook 'ibuffer-mode-hook 'turn-on-font-lock)

(defun cycle-theme ()
  (interactive)
  (setq gl/light nil)
  (load-theme 'gl-dark t)
  (if gl/colours
      (progn
        (setq gl/colours nil))
    (progn
      (setq gl/colours t))))

(defun cycle-light-theme ()
  (interactive)
  (setq gl/colours nil)
  (if gl/light
      (setq gl/light nil)
    (setq gl/light t))
  (load-theme 'gl-dark t))

(load-theme 'gl-dark t)
(when (and (display-graphic-p) (not (daemonp)))
           (set-background-color "#000000")
           (set-foreground-color "#bebebe"))
;;(unless gl/colours
;;  (global-font-lock-mode 0))

(bind-keys
 ("<f2>"   . cycle-theme)
 ("M-<f2>" . cycle-light-theme))
