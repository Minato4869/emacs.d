(defvar gl/colours nil
  "Variable used to toggle gl-dark theme between standard and mono grey")

(defun cycle-themes ()
  (interactive)
  (load-theme 'gl-dark t)
  (if gl/colours
      (setq gl/colours nil)
    (setq gl/colours t)))

(load-theme 'gl-dark t)

(bind-keys
 ("<f2>"   . cycle-themes)
 ("S-<f2>" . cycle-bg))
