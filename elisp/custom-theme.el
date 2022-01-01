(defvar gl/is-dark t
  "Variable used to toggle gl-dark theme between standard and mono grey")

(defun cycle-themes ()
  (interactive)
  (load-theme 'gl-dark t)
  (if gl/is-dark
      (setq gl/is-dark nil)
    (setq gl/is-dark t)))

(cond
 ((getenv "SSH_CONNECTION")
  (load-theme 'warm-night t))
 ((string-equal system-type "windows-nt")
  (load-theme 'naysayer t))
 ((or (daemonp) (not (display-graphic-p)))
  (load-theme 'gl-dark t))
 ((display-graphic-p)
  (setq gl/is-dark nil)
  (global-font-lock-mode 0)
  (load-theme 'gl-dark t)))

(bind-keys
 ("<f2>"     . cycle-themes))
