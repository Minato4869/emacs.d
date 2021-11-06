(set-face-attribute 'variable-pitch nil :font "Sans-Serif-14")
(setq dpi (string-to-number (shell-command-to-string "~/bin/dpi")))


(unless (file-directory-p "~/.fonts/Meslo-Font")
  (setq cfont/ttf    "DejaVu Sans Mono:regular:pixelsize="))

(if (< (display-pixel-height) 1080)
    (setq cfont/default cfont/6x13
          cfont/default  cfont/6x13
          cfont/size          "12"))

(defun ttf ()
  (interactive)
  (let ((ttfh (cond ((= dpi 125)  69)
                    ((= dpi 131)  75)
                    ((= dpi 157) 73)
                    ((= dpi 109) 93)))
        (family     "Meslo LG S")
        )
    (custom-set-faces
     `(default ((t (:inherit default :height ,ttfh :width normal
                             :foundry "PfEd" :family ,family)))))))

(defun pcf (&optional myfont)
  (interactive)
  (unless myfont
    (cond
     ((> dpi 130)
      (setq myfont "-uw-ttyp0-medium-r-normal--18-170-75-75-c-90-iso10646-1"))
     ((file-regular-p "~/.lf")
      (setq myfont "-uw-ttyp0-medium-r-normal--16-150-75-75-c-80-iso10646-1"))
     ((file-regular-p "~/.fixed")
      (setq myfont "-misc-fixed-medium-r-semicondensed--13-120-75-75-c-60-iso10646-1"))
     (t
      (setq myfont "-uw-ttyp0-medium-r-normal--14-130-75-75-c-70-iso10646-1"))))
  (set-face-attribute 'default t :font myfont)
  (setq default-frame-alist `((font . ,myfont)))
  (set-frame-font myfont nil t))

(defun default-font ()
  (interactive)
  (if (file-regular-p "~/.ttf")
      (ttf)
    (pcf)))

(defun small-font ()
  (interactive)
  (cfont/set-font cfont/small))

(defun 6x13 ()        (interactive) (pcf cfont/6x13))
(defun 9x16 ()        (interactive) (pcf cfont/9x16))

(defun medium-font () (interactive) (cfont/set-font cfont/9x16))

(defun reset-fonts ()
  (interactive)
  (load-file "~/.emacs.d/elisp/custom-font-mode.el")
  (mesage "resetting fonts"))

(bind-keys
 ("<f7>"     . default-small-font)
 ("<f8>"     . default-font)
 ("M-<f8>"   . ttf-font))

(defalias 'df     'default-font)
(defalias 'dfs    'default-small-font)
;;(defalias 'ttf    'ttf-font)
(defalias 'menlo  'ttf)
(defalias 'small  'small-font)
(defalias 'medium 'medium-font)

(when (daemonp)
  (default-font))
