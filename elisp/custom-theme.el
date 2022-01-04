(defvar gl/colours nil
  "Variable used to toggle gl-dark theme between standard and mono grey")

(defun cycle-themes ()
  (interactive)
  (load-theme 'gl-dark t)
  (if gl/colours
      (setq gl/colours nil)
    (setq gl/colours t)))

(defun cycle-bg ()
  (interactive)
  (load-theme 'gl-dark t)
  (if gl/colours
      (setq gl/colours nil)
    (setq gl/colours nil)))

(load-theme 'gl-dark t)

(cond
 ((getenv "SSH_CONNECTION")
  (custom-set-faces
   '(mode-line ((t (:bold t :foreground "#838383" :background "#373333"))))
   '(mode-line-inactive ((t (:foreground  "#847f54" :background "#292424" :weight normal))))
   '(mode-line-buffer-id ((t (:bold t :foreground "#b680b1" :background nil))))))
 ((string-equal system-type "windows-nt")
  (custom-set-faces
   '(default   ((t (:background "#072626" :foreground "#d3b58d"))))
   '(mode-line ((t (:inverse-video t))))))
 ((display-graphic-p)
  (load-theme 'gl-dark t)))

(bind-keys
 ("<f2>"   . cycle-themes)
 ("S-<f2>" . cycle-bg))
