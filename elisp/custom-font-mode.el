(set-face-attribute 'variable-pitch nil :font "Sans-Serif-14")
(setq cfont/6x13   "-misc-fixed-medium-r-semicondensed--13-120-75-75-c-60-iso10646-1"
      cfont/knuth  "-don-fixed-medium-r-semicondensed--13-120-75-75-c-60-iso8859-1"
      cfont/small  "-uw-ttyp0-medium-r-normal--14-130-75-75-c-70-iso10646-1"
      cfont/medium "-uw-ttyp0-medium-r-normal--16-150-75-75-c-80-iso10646-1"
      cfont/large  "-uw-ttyp0-medium-r-normal--18-170-75-75-c-90-iso10646-1"
      cfont/size   "14"
      cfont/ttf    "Meslo LG S:regular:pixelsize=")

(setq cfont/default cfont/medium)

(unless (file-directory-p "~/.fonts/Meslo-Font")
      (setq cfont/ttf    "DejaVu Sans Mono:regular:pixelsize="))

(defun cfont/set-font (&optional myfont)
    (set-face-attribute 'default t :font myfont)
    (setq default-frame-alist `((font . ,myfont)))
    (set-frame-font myfont nil t))


(defun default-font ()
  (interactive)
  (cfont/set-font cfont/default))

(defun 6x13 ()
  (interactive)
  (cfont/set-font cfont/6x13))
(defun knuth ()
  (interactive)
  (cfont/set-font cfont/knuth))

(defun small-font ()
  (interactive)
  (cfont/set-font cfont/small))
(defun medium-font ()
  (interactive)
  (cfont/set-font cfont/medium))
(defun large-font ()
  (interactive)
  (cfont/set-font cfont/large))

(defun presentation-font ()
  (interactive)
  (cfont/set-font (concat cfont/ttf "30")))
(defun ttf-font ()
  (interactive)
  (cfont/set-font (concat cfont/ttf cfont/size)))

(bind-keys
 ("<f7>"     . 6x13)
 ("<f8>"     . default-font)
 ("M-<f8>"   . ttf-font)
 ("M-S-<f8>" . presentation-font))

(unless (file-directory-p "/usr/local/share/fonts/X11/misc")
  (menlo-font))
(defalias 'small       'small-font)
(defalias 'medium      'medium-font)
(defalias 'large       'large-font)
(defalias 'ttf         'ttf-font)
(defalias 'menlo-font  'ttf-font)
(defalias 'menlo       'ttf-font)
(defalias 'meslo       'ttf-font)
