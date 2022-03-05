(add-to-list 'custom-theme-load-path "~/.emacs.d/elisp/themes")
(add-to-list 'custom-theme-load-path "~/.emacs.d/elisp/themes/old")

(defvar gl/colours nil
  "Variable used to toggle gl-dark theme between standard and mono grey")

(defvar gl/light nil
  "Variable used to toggle between dark (grey or black) and light theme")
(setq gl/colours nil
      gl/light   nil)
(add-hook 'diff-mode-hook    'turn-on-font-lock)
(add-hook 'dired-mode-hook   'turn-on-font-lock)
(add-hook 'magit-mode-hook   'turn-on-font-lock)
(add-hook 'org-mode-hook     'turn-on-font-lock)
(add-hook 'mail-mode-hook    'turn-on-font-lock)
(add-hook 'Man-mode-hook     'turn-on-font-lock)
(add-hook 'eshell-mode-hook  'turn-on-font-lock)
(add-hook 'ibuffer-mode-hook 'turn-on-font-lock)
(defun  is_ttf ()
  (if (string-match "PfEd" (prin1-to-string (face-attribute 'default :font)))
      t
    nil))
(when (my_daemonp)
(defun cycle-theme ()
  (interactive)
  (setq gl/light nil)
  (load-theme 'gl-dark t)
  (if gl/colours
      (setq gl/colours nil)
      (setq gl/colours t)))

(defun cycle-light-theme ()
  (interactive)
  (setq gl/colours nil)
  (if gl/light
      (setq gl/light nil)
    (setq gl/light t))
  (load-theme 'gl-dark t))

(defadvice load-theme (before theme-dont-propagate activate)
  "Disable theme before loading new one."
  (mapc #'disable-theme custom-enabled-themes))

(setq custom-theme-index 0)
(defun cycle-themes ()
  (interactive)
   (let ((custom-themes '(gl-dark naysayer-grey naysayer nord srcery warm-night xcode-dark)))
    (setq custom-theme-index (% (1+ custom-theme-index) (length custom-themes)))
    (load-theme (nth custom-theme-index custom-themes) :no-confirm)))

(bind-keys
 ("<f2>"   . cycle-theme)
 ("M-<f2>" . cycle-light-theme)
 ("C-<f2>" . cycle-themes)))

;;(let ((elscreen-tab-current-screen-face-bg  (if gl/light "#d4d4d4" "#666666"))
;;      (elscreen-tab-current-screen-face-fg  (if gl/light "#000000" "#E5E5E5"))
(custom-set-faces
 `(elscreen-tab-background-face     ((t (:inherit header-line))))
 `(elscreen-tab-control-face        ((t (:inherit elscreen-tab-background-face))))
 `(elscreen-tab-other-screen-face   ((t (:inherit elscreen-tab-background-face))))
 `(elscreen-tab-current-screen-face ((((type tty)) (:inherit mode-line-inactive))
                                     (t (:foreground "#e5e5e5" :background "#666666")))))

(unless (daemonp)
  (if (display-graphic-p)
      (setq gl/light t)
    (global-font-lock-mode 0)))

(load-theme 'gl-dark t)

;;(unless gl/colours (global-font-lock-mode 0))
