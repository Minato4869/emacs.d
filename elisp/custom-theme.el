(defvar gl/is-dark t
  "Variable used to toggle gl-dark theme between standard and mono grey")

(defun cycle-themes ()
  (interactive)
  (load-theme 'gl-dark t)
  (if gl/is-dark
      (progn
        (setq gl/is-dark nil)
        (global-font-lock-mode t))
    (progn
      (setq gl/is-dark t)
      (global-font-lock-mode 0))))


(cond
 ((getenv "SSH_CONNECTION")
  (load-theme 'warm-night t))
 ((string-equal system-type "windows-nt")
  (load-theme 'naysayer t))
 (t
  (load-theme 'gl-dark t)))

(bind-keys
 ("<f2>"     . cycle-themes))
