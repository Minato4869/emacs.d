(set-face-attribute 'variable-pitch nil :font "Sans-Serif-14")

(unless (file-directory-p "~/.fonts/Meslo-Font")
  (setq cfont/ttf    "DejaVu Sans Mono:regular:pixelsize="))

(defun ttf ()
  (interactive)
  (let ((ttfh (cond ((= dpi 125) 69)
                    ((= dpi 131) 75)
                    ((= dpi 157) 63) ;; was 73
                    ((= dpi 109) 93)
                    (t 70)))
        (family     "Meslo LG S")
        )
    (custom-set-faces
     `(default ((t (:inherit default :height ,ttfh :width normal
                             :foundry "PfEd" :family ,family)))))))

(defun pcf (&optional arg)
  (interactive)
  (let ((myfont (cond
                 ((string= arg "large")
                  "-uw-ttyp0-medium-r-normal--18-170-75-75-c-90-iso10646-1")
                 ((or (string= arg "9x16") (string= arg "medium"))
                  "-uw-ttyp0-medium-r-normal--16-150-75-75-c-80-iso10646-1")
                 ((string= arg "6x13")
                  "-gl-fixed-medium-r-semicondensed--13-120-75-75-c-60-iso10646-1")
                 ((or (string= arg "small") t)
                  "-uw-ttyp0-medium-r-normal--13-120-75-75-c-70-iso10646-1"))))
    (set-face-attribute 'default t :font myfont)
    (setq default-frame-alist `((font . ,myfont)))
    (set-frame-font myfont nil t)))


(defun default-font ()
  (interactive)
  (cond
   ((or (file-regular-p "~/.hf") (> dpi 130))
    (pcf "9x16"))
   ((file-regular-p "~/.ttf")
    (ttf))
   ((file-regular-p "~/.lf")
    (pcf "small"))
   (t
    (pcf "6x13"))))

(defun small-font ()  (interactive) (pcf "small"))
(defun medium-font () (interactive) (pcf "medium"))
(defun large-font ()  (interactive) (pcf "large"))
(defun 6x13 ()        (interactive) (pcf "6x13"))
(defun 9x16 ()        (interactive) (pcf "9x16"))

(defun reset-fonts ()
  (interactive)
  (load-file "~/.emacs.d/elisp/custom-font-mode.el")
  (mesage "resetting fonts"))

(bind-keys
 ("<f7>"     . default-small-font)
 ("<f8>"     . default-font)
 ("M-<f8>"   . ttf-font))

(defalias 'df     'default-font)
(defalias 'reset-fonts 'default-font)
(defalias 'dfs    'default-small-font)
(defalias 'menlo  'ttf)
(defalias 'meslo  'ttf)
(defalias 'small  'small-font)
(defalias 'medium 'medium-font)
(defalias 'large  'large-font)

(when (or (daemonp) (display-graphic-p))
  (default-font))
