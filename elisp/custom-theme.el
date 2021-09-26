(defadvice load-theme (before theme-dont-propagate activate)
  "Disable theme before loading new one."
  (mapc #'disable-theme custom-enabled-themes))

(setq custom-themes-index 0
      custom-themes '(gl-dark warm-night))

(defun custom-cycle-theme ()
  (interactive)
  (setq custom-themes-index (% (1+ custom-themes-index) (length custom-themes)))
  (load-theme (nth custom-themes-index custom-themes) :no-confirm))

(defun disable-all-themes ()
  "Disable all themes."
  (interactive)
  (dolist (i custom-enabled-themes)
    (disable-theme i)))

(defun custom-default-theme ()
  "Load default theme"
  (interactive)
  (disable-all-themes)
  (load-theme 'gl-dark t))

(defun beamer ()
  (interactive)
  (disable-all-themes)
  (cfont/set-font (concat cfont/ttf "30"))
  (load-theme 'default-light t)
  (message "Enabled presentation mode"))

(bind-keys
 ("<f2>"   . custom-cycle-theme)
 ("S-<f2>" . disable-all-themes)
 ("C-<f2>" . custom-default-theme))

(cond
 ((getenv "SSH_CONNECTION")
  (load-theme 'warm-night t))
 ((string-equal system-type "windows-nt")
  (load-theme 'naysayer t)
  (setq custom-themes-index 1))
 ((or (daemonp) (not (display-graphic-p)))
  (load-theme 'gl-dark t)))

;; themes
(defalias 'ct            'custom-cycle-theme)
(defalias 'cycle-theme   'custom-cycle-theme)
(defalias 'default-theme 'custom-default-theme)
(defalias 'dft           'custom-default-theme)
(defalias 'da            'disable-all-themes)
(defalias 'lt            'load-theme)
(defalias 'light         'default-light-theme)
