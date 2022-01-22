(set-face-attribute 'variable-pitch nil :font "Sans-Serif-14")

(defun ttf ()
  (interactive)
  (let* ((dpi (string-to-number (shell-command-to-string "~/bin/dpi")))
         (ttfh (cond ((= dpi 125) 69)
                   ((= dpi 131) 75)
                   ((= dpi 157) 73) ;; was 73
                   ((= dpi 109) 93)
                   (t 70)))
       (family     "Meslo LG S"))
   (custom-set-faces
    `(default ((t (:inherit default :height ,ttfh :width normal
                            :foundry "PfEd" :family ,family)))))))

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
  (cond
   ((file-regular-p "~/.hf" ) (pcf "9x16"))
   ((file-regular-p "~/.ttf") (ttf))
   (t                         (pcf "6x13"))))

(defun 6x13 () (interactive) (pcf "6x13"))
(defun 9x16 () (interactive) (pcf "9x16"))

(defun reset-fonts ()
  (interactive)
  (load-file "~/.emacs.d/elisp/custom-font-mode.el")
  (message "resetting fonts"))

(defalias 'df     'default-font)
(defalias 'menlo  'ttf)
(defalias 'meslo  'ttf)

(default-font)
