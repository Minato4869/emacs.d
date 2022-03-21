(add-to-list 'custom-theme-load-path "~/.emacs.d/elisp/themes")
(add-to-list 'custom-theme-load-path "~/.emacs.d/elisp/themes/old")

(setq frame-background-mode t
      custom-safe-themes    t)
(defun setColours ()
  (set-terminal-parameter  (selected-frame) 'background-mode frame-background-mode)
  (set-frame-parameter     (selected-frame) 'background-mode frame-background-mode)
  (frame-set-background-mode (selected-frame))
  (load-theme 'gl-dark t))
(setColours)


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
  (if (eq frame-background-mode t)
      (setq frame-background-mode 'dark)
    (setq frame-background-mode t))
  (setColours))

(defun cycle-light-theme ()
  (interactive)
  (if (eq frame-background-mode t)
      (setq frame-background-mode 'light)
    (setq frame-background-mode t))
  (setColours))



;;
;;(unless (daemonp)
;;  (if (display-graphic-p)
;;      (setq gl/light t)
;;    (global-font-lock-mode 0)))
;;
;;(load-library 'gl-dark)
;;
;;;;(unless gl/colours (global-font-lock-mode 0))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

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
 ("C-<f2>" . cycle-themes))
