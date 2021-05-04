(set-face-attribute 'variable-pitch nil :font "Sans-Serif-14")
(setq  cfont/size   "14"
       cfont/ttf    "Meslo LG S:antialias=true:regular:pixelsize="
       cfont/6x13   "-misc-fixed-medium-r-semicondensed--13-120-75-75-c-60-iso10646-1"
       ;; cfont/small  "-uw-ttyp0-medium-r-normal--13-120-75-75-c-70-iso10646-1"
       cfont/small  "-uw-ttyp0-medium-r-normal--14-130-75-75-c-70-iso10646-1"
       cfont/medium "-uw-ttyp0-medium-r-normal--16-150-75-75-c-80-iso10646-1"
       cfont/large  "-uw-ttyp0-medium-r-normal--18-170-75-75-c-90-iso10646-1")

(unless (file-directory-p "~/.fonts/Meslo-Font")
  (setq cfont/ttf    "DejaVu Sans Mono:regular:pixelsize="))

(cond
 ((< (display-pixel-height) 1440)
  (setq cfont/default-small cfont/6x13
        cfont/default       cfont/6x13
        cfont/size          "12"))
 (t
  (setq cfont/default-small cfont/small
        cfont/default       cfont/medium)))

(defun cfont/set-font (&optional myfont)
    (set-face-attribute 'default t :font myfont)
    (setq default-frame-alist `((font . ,myfont)))
    (set-frame-font myfont nil t))

(defun default-font ()
  (interactive)
  (cfont/set-font cfont/default))
(defun default-small-font ()
  (interactive)
  (cfont/set-font cfont/default-small))

(defun 6x13 ()        (interactive) (cfont/set-font cfont/6x13))
(defun ttf-font ()    (interactive) (cfont/set-font (concat cfont/ttf cfont/size)))
(defun small-font ()  (interactive) (cfont/set-font cfont/small))
(defun medium-font () (interactive) (cfont/set-font cfont/medium))
(defun large-font ()  (interactive) (cfont/set-font cfont/large))
(defun presentation-font ()
  (interactive)
  (cfont/set-font (concat cfont/ttf 25)))

(defun reset-fonts ()
  (interactive)
  (load-file "~/.emacs.d/elisp/custom-font-mode.el")
  (mesage "resetting fonts"))

(bind-keys
 ("<f7>"     . default-small-font)
 ("<f8>"     . default-font)
 ("M-<f8>"   . ttf-font)
 ("M-S-<f8>" . presentation-font))

(when (display-graphic-p)
  (if (file-directory-p "/usr/local/share/fonts/X11/misc")
      (default-font)
    (ttf-font)))
(defalias 'df          'default-font)
(defalias 'dfs         'default-small-font)
(defalias 'ttf         'ttf-font)
(defalias 'menlo       'ttf)
(defalias 'small       'small-font)
(defalias 'medium      'medium-font)
(defalias 'large       'large-font)
