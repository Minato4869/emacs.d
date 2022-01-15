(defvar gl/colours nil
  "Variable used to toggle gl-dark theme between standard and mono grey")
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
  (load-theme 'gl-dark t)
  (if gl/colours
      (progn
        ;; (font-lock-mode t)
        (setq gl/colours nil))
    (progn
      ;;(my-disable-font-lock-mode)
      (setq gl/colours t))))

(load-theme 'gl-dark t)
(when (and (display-graphic-p) (not (daemonp)))
           (set-background-color "#000000")
           (set-foreground-color "#bebebe"))
;;(unless gl/colours
;;  (global-font-lock-mode 0))

(bind-key "<f2>" 'cycle-theme)
