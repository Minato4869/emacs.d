(defun custom-set-font (&optional fontname)
  (cond
   ((string-equal fontname "small")
    (setq font "-uw-ttyp0-medium-r-normal--14-130-75-75-c-70-iso10646-1"))
   ((string-equal fontname "medium")
    (setq font "xft:-uw-ttyp0-medium-r-normal--16-*-75-75-c-*-iso10646-1"))
   ((string-equal fontname "large")
    (setq font "xft:-uw-ttyp0-medium-r-normal--18-*-75-75-c-*-iso10646-1"))
   ((string-equal fontname "menlo")
    (cond ((file-directory-p "~/.fonts/Meslo-Font")
           (setq font "Meslo LG S:regular:pixelsize=14"))
          (t (custom-set-font))))
   ((string-equal fontname "go")
    (cond ((file-directory-p "/usr/share/fonts/fonts-go")
           (setq font "Go Mono:regular:pixelsize=14"))
          (t (custom-set-font))))
   ((string-equal fontname "presentation")
    (cond (file-directory-p "~/.fonts/Meslo-Font")
          (setq font "Meslo LG S:regular:pixelsize=24")
          (t (setq font "DejaVu Sans Mono:regular:pixelsize=30" ))))
   (t
    (setq font "DejaVu Sans Mono:regular:pixelsize=14")))
  (set-face-attribute 'default t :font font)
  (set-frame-font font nil t))

(defun small-font ()
  (interactive)
  (custom-set-font "small"))

(defun medium-font ()
  (interactive)
  (custom-set-font "medium"))

(defun large-font ()
  (interactive)
  (custom-set-font "large"))

(defun menlo-font ()
  (interactive)
  (custom-set-font "menlo"))

(defun go-font ()
  (interactive)
     (custom-set-font "go"))

(defun presentation-font ()
  (interactive)
     (custom-set-font "presentation"))

(bind-keys
 ("<f6>"     . small-font)
 ("<f7>"     . medium-font)
 ("<f8>"     . large-font)
 ("M-<f8>"   . menlo-font)
 ("M-S-<f8>" . presentation-font))

(when (and (and (not (daemonp)) (display-graphic-p))
           (not (file-directory-p "/usr/local/share/fonts/X11/misc")))
  (menlo-font))

;; "-don-fixed-medium-r-semicondensed--13-120-75-75-c-60-iso8859-1"
;; "-misc-fixed-medium-r-semicondensed--13-120-75-75-c-60-iso10646-1"
;; "Go Mono:regular:pixelsize=15"
