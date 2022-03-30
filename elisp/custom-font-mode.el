 (set-face-attribute 'variable-pitch nil :font "Sans-Serif-14")
(setq dpi (string-to-number (shell-command-to-string "~/bin/dpi")))
(defun ttf ()
  (interactive)
  (let* ((ttfh (cond ((= dpi 109) 79)
                     ((= dpi 125) 65) ;; was 6.9
                     ((= dpi 131) 75)
                     ((= dpi 157) 64)
                     (t           70)))
         (xfth       (/ ttfh 10.0))
         (family     "Deja Vu Sans Mono")
         (myfont     (concat family "-" (number-to-string xfth))))
   (custom-set-faces
    `(default ((t (:inherit default :height ,ttfh :width normal
                            :foundry "PfEd" :family ,family)))))
   (setq default-frame-alist `((font . ,myfont))
         initial-frame-alist default-frame-alist)
   (set-frame-font myfont nil t)))

(defun pcf (&optional arg)
  (interactive)
  (let ((myfont
         (cond
          ((or (string= arg "9x16"))
           "-uw-ttyp0-medium-r-normal--16-150-75-75-c-80-iso10646-1")
          ((or t (string= arg "6x13"))
           "-gl-fixed-medium-r-semicondensed--13-120-75-75-c-60-iso10646-1"))))
    (set-face-attribute 'default t :font myfont)
    (setq default-frame-alist `((font . ,myfont))
          initial-frame-alist default-frame-alist)
    (set-frame-font myfont nil t)))

(defun 6x13 () (interactive) (pcf "6x13"))
(defun 9x16 () (interactive) (pcf "9x16"))
(defun default-font ()
  (interactive)
  (cond
   ((file-regular-p "~/.ttf") (ttf))
   ((or (file-regular-p "~/.hf")
        (>= dpi 157))
        (9x16))
   (t                         (6x13))))

(defun reset-fonts ()
  (interactive)
  (load-file "~/.emacs.d/elisp/custom-font-mode.el")
  (message "resetting fonts"))

(defalias 'df     'default-font)
(defalias 'menlo  'ttf)
(defalias 'meslo  'ttf)

;;(default-font)
