(set-face-attribute 'variable-pitch nil :font "Sans-Serif-14")

(defun ttf ()
  (interactive)
  (custom-set-faces
   `(default ((t (:inherit default :height 75 :width normal
                           :foundry "PfEd" :family "Meslo LG S"))))))

(defun pcf (&optional arg)
  (interactive)
  (let ((myfont (cond
                 ((or (string= arg "9x16"))
                  "-uw-ttyp0-medium-r-normal--16-150-75-75-c-80-iso10646-1")
                 ((or t (string= arg "6x13"))
                  "-gl-fixed-medium-r-semicondensed--13-120-75-75-c-60-iso10646-1"))))
    (set-face-attribute 'default t :font myfont)
    (setq default-frame-alist `((font . ,myfont)))
    (set-frame-font myfont nil t)))

(defun default-font ()
  (interactive)
  (if ((or (file-regular-p "~/.hf")) (> dpi 160))
      (pcf "9x16")
    (pcf "6x13")))

(defun 6x13 () (interactive) (pcf "6x13"))
(defun 9x16 () (interactive) (pcf "9x16"))

(defun reset-fonts ()
  (interactive)
  (load-file "~/.emacs.d/elisp/custom-font-mode.el")
  (mesage "resetting fonts"))

(defalias 'df     'default-font)
(defalias 'menlo  'ttf)
(defalias 'meslo  'ttf)

(default-font)
