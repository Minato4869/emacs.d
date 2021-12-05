(defadvice load-theme (before theme-dont-propagate activate)
  "Disable theme before loading new one."
  (mapc #'disable-theme custom-enabled-themes))

(setq custom-main-theme-index 0
      custom-main-themes '(gl-dark warm-night)
      custom-theme-index 0
      custom-themes '(gl-dark warm-night naysayer naysayer-grey nord srcery xcode-dark ;;gl-light
                              ))

(defun custom-cycle-theme (theme-list index)
  (load-theme (nth index theme-list) :no-confirm))

(defun cycle-main-themes ()
  (interactive)
  (setq custom-main-theme-index (% (1+ custom-main-theme-index) (length custom-main-themes)))
  (custom-cycle-theme custom-main-themes custom-main-theme-index))

(defun cycle-themes ()
  (interactive)
  (setq custom-theme-index (% (1+ custom-theme-index) (length custom-themes)))
  (custom-cycle-theme custom-themes custom-theme-index))


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

(bind-keys
 ("<f2>"     . cycle-main-themes)
 ("M-<f2>"   . cycle-themes)
 ("ESC <f2>" . cycle-themes)
 ("C-<f2>"   . custom-default-theme))

(cond
 ((getenv "SSH_CONNECTION")
  (load-theme 'warm-night t))
 ((string-equal system-type "windows-nt")
  (load-theme 'naysayer t))
 (t
  (load-theme 'gl-dark t)))

;; themes
(defalias 'ct             'cycle-themes)
(defalias 'default-theme  'custom-default-theme)
(defalias 'reset-theme    'custom-default-theme)
(defalias 'dft            'custom-default-theme)
(defalias 'dat            'disable-all-themes)
(defalias 'disable-themes 'disable-all-themes)
(defalias 'lt             'load-theme)
(defalias 'light          'default-light-theme)
