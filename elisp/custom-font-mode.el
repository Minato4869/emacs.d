(set-face-attribute 'variable-pitch nil :font "Sans-Serif-14")
(setq cfont/6x13   "-misc-fixed-medium-r-semicondensed--13-120-75-75-c-60-iso10646-1"
      cfont/small  "-uw-ttyp0-medium-r-normal--14-130-75-75-c-70-iso10646-1"
      cfont/medium "-uw-ttyp0-medium-r-normal--16-150-75-75-c-80-iso10646-1"
      cfont/large  "-uw-ttyp0-medium-r-normal--18-170-75-75-c-90-iso10646-1"
      cfont/ttf    "DejaVu Sans Mono:regular:pixelsize=14"
      cfont/menlo  "Meslo LG S:regular:pixelsize=14"
      cfont/pres   "Meslo LG S:regular:pixelsize=20")

(unless (file-directory-p "~/.fonts/Meslo-Font")
    (setq cfont/menlo cfont/ttf))

(defun cfont/set-font (&optional font)
  (set-face-attribute 'default t :font font)
  (set-frame-font font nil t))

(defun 6x13 ()
  (interactive)
  (cfont/set-font cfont/6x13))

(defun small-font ()(interactive)
  (cfont/set-font cfont/small))

(defun medium-font ()
  (interactive)
  (cfont/set-font cfont/medium))

(defun large-font ()
  (interactive)
  (cfont/set-font cfont/large))

(defun menlo-font ()
  (interactive)
  (cfont/set-font cfont/menlo))

(defun presentation-font ()
  (interactive)
  (setq cfont/pixelsize 30)
  (cfont/set-font (concat cfont/pres)))

(bind-keys
 ("<f7>"     . medium-font)
 ("<f8>"     . large-font)
 ("M-<f8>"   . menlo-font)
 ("M-S-<f8>" . presentation-font))

(unless (file-directory-p "/usr/local/share/fonts/X11/misc")
  (menlo-font))
(defalias 'small       'small-font)
(defalias 'medium      'medium-font)
(defalias 'large       'large-font)
(defalias 'menlo       'menlo-font)
(defalias 'meslo       'menlo-font)
;; small  "-uw-ttyp0-medium-r-normal--14-130-75-75-c-70-iso10646-1"
;; "-don-fixed-medium-r-semicondensed--13-120-75-75-c-60-iso8859-1"
;; "-misc-fixed-medium-r-semicondensed--13-120-75-75-c-60-iso10646-1"
;; "Go Mono:regular:pixelsize=15"
