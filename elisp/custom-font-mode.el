(setq
  cfont/pixelsize 14
  cfont/large     "xft:-uw-ttyp0-medium-r-normal--18-*-75-75-c-*-iso10646-1"
  cfont/medium    "xft:-uw-ttyp0-medium-r-normal--16-*-75-75-c-*-iso10646-1"
  cfont/ttf       "DejaVu Sans Mono:regular:pixelsize="
  cfont/go        "Go Mono:regular:pixelsize=14"
  cfont/menlo     "Meslo LG S:regular:pixelsize=14")

(defun cfont/set-font (&optional fontname)
  (cond
   ((string-equal fontname "medium")
    (setq font cfont/medium))
   ((string-equal fontname "large")
    (setq font cfont/large))
   ((string-equal fontname "menlo")
    (setq font cfont/menlo))
   ((string-equal fontname "go")
    (setq font cfont/go))
   ((string-equal fontname "presentation")
    (setq font (concat cfont/ttf "30")))
   (t
    (setq font (concat cfont/ttf pixelsize))))
  (set-face-attribute 'default t :font font)
  (set-frame-font font nil t))

(defun medium-font ()
  (interactive)
  (cfont/set-font "medium"))

(defun large-font ()
  (interactive)
  (cfont/set-font "large"))

(defun menlo-font ()
  (interactive)
  (cfont/set-font "menlo"))

(defun go-font ()
  (interactive)
     (cfont/set-font "go"))

(defun presentation-font ()
  (interactive)
     (cfont/set-font "presentation"))

(bind-keys
 ("<f7>"     . medium-font)
 ("<f8>"     . large-font)
 ("M-<f8>"   . menlo-font)
 ("M-S-<f8>" . presentation-font))

(when (and (and (not (daemonp)) (display-graphic-p))
           (not (file-directory-p "/usr/local/share/fonts/X11/misc")))
  (menlo-font))

;; small  "-uw-ttyp0-medium-r-normal--14-130-75-75-c-70-iso10646-1"
;; "-don-fixed-medium-r-semicondensed--13-120-75-75-c-60-iso8859-1"
;; "-misc-fixed-medium-r-semicondensed--13-120-75-75-c-60-iso10646-1"
;; "Go Mono:regular:pixelsize=15"
