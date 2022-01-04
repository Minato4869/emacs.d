(defvar gl/colours nil
  "Variable used to toggle gl-dark theme between standard and mono grey")

(defvar gl/black nil
  "Variable used to differentiate mono themes between emacs server (grey) and regular (black)")

(defun gl/black-theme ()
  (or gl/colours gl/black))

(defun cycle-themes ()
  (interactive)
  (load-theme 'gl-dark t)
  (if gl/colours
      (setq gl/colours nil)
    (setq gl/colours t)))

(defun cycle-bg ()
  (interactive)
  (load-theme 'gl-dark t)
  (if gl/black
      (setq gl/black nil
            gl/colours nil)
    (setq gl/black t
          gl/colours nil)))

(cond
 ((getenv "SSH_CONNECTION")
  (custom-set-faces
   '(default   ((t (:background "#292424" :foreground "#b1b1b1"))))
   '(mode-line ((t (:bold t :foreground "#838383" :background "#373333"))))
   '(mode-line-inactive ((t (:foreground  "#847f54" :background "#292424" :weight normal))))
   '(mode-line-buffer-id ((t (:bold t :foreground "#b680b1" :background nil))))))
 ((string-equal system-type "windows-nt")
  (custom-set-faces
   '(default   ((t (:background "#072626" :foreground "#d3b58d"))))
   '(mode-line ((t (:inverse-video t))))))
  ((or (daemonp))
   (load-theme 'gl-dark t))
 ((display-graphic-p)
  (setq gl/black t)
  (load-theme 'gl-dark t)))

(bind-keys
 ("<f2>"   . cycle-themes)
 ("S-<f2>" . cycle-bg))
