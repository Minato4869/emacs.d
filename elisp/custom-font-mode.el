(defun custom-set-font (font)
  (set-face-attribute 'default t :font font)
  (set-frame-font font nil t))

(defun knuth-font ()
  (interactive)
  (custom-set-font
   "-don-fixed-medium-r-semicondensed--13-120-75-75-c-60-iso8859-1"))
;;   "-misc-fixed-medium-r-semicondensed--13-120-75-75-c-60-iso10646-1"))

(defun small-font ()
  (interactive)
  (custom-set-font
   "-uw-ttyp0-medium-r-normal--14-130-75-75-c-70-iso10646-1"))

(defun medium-font ()
  (interactive)
  (custom-set-font
   "xft:-uw-ttyp0-medium-r-normal--16-*-75-75-c-*-iso10646-1"))

(defun large-font ()
  (interactive)
  (custom-set-font
   "xft:-uw-ttyp0-medium-r-normal--18-*-75-75-c-*-iso10646-1"))

(defun dejavu-font ()
  (interactive)
  (custom-set-font "DejaVu Sans Mono:regular:pixelsize=14" ))

(defun go-font ()
  (interactive)
  (custom-set-font "Go Mono:regular:pixelsize=15"))

(defun menlo-font ()
  (interactive)
  (custom-set-font "Meslo LG S:regular:pixelsize=14" ))

(defun presentation-font ()
  (interactive)
  (custom-set-font "Meslo LG S:regular:pixelsize=24:antialias=true" ))
(bind-keys
 ("<f6>"  .small-font)
 ("<f7>" . medium-font)
 ("<f8>" . large-font))

(when (and (and (not (daemonp)) (display-graphic-p))
           (not (file-directory-p "/usr/local/share/fonts/X11/misc")))
  (cond
   ((file-directory-p "~/.fonts/'Meslo LG v1.2.1'")
    (menlo-font))
   ((or (file-directory-p "/usr/share/fonts/go-fonts")
        (file-directory-p "/usr/local/share/fonts/go-fonts"))
    (go-font))
   (t
    (dejavu-font))))
