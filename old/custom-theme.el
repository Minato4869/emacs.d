(defun disable-all-themes ()
  "Disable all themes."
  (interactive)
  (dolist (i custom-enabled-themes)
    (disable-theme i)))
(cond
 ((and (display-graphic-p) (not (daemonp)))
  (progn
    (load-theme 'naysayer t)
    (setq custom-themes-index 1)))
 ((daemonp)
  (disable-all-themes)
  (load-theme 'gl-dark t))
 (t
  (load-theme 'xcode-dark t)
  (custom-set-faces
   '(dired-directory ((t (:foreground "brightblue"))))
   '(dired-symlink ((t (:foreground "magenta"))))
   ;; '(font-lock-builtin-face ((t (:foreground "magenta"))))
   ;; '(font-lock-comment-face ((t (:foreground "red"))))
   ;; '(font-lock-constant-face ((t (:foreground "green"))))
   ;; '(font-lock-function-name-face ((t (:foreground "magenta"))))
   ;; '(font-lock-keyword-face ((t (:foreground "cyan"))))
   ;; '(font-lock-string-face ((t (:foreground "green"))))
   ;; '(font-lock-type-face ((t (:foreground "green"))))
   ;; '(font-lock-variable-name-face ((t (:foreground "yellow"))))
   ;; '(font-lock-warning-face ((t (:foreground "Red" :bold t))))
   ;; '(mode-line-inactive ((t (:inverse-video nil))))
   '(minibuffer-prompt ((t (:inherit foreground :bold t))))
   ;; '(region ((t (:foreground "white" :background "blue" :extend t))))
   '(sh-quoted-exec ((t (:foreground "salmon"))))
   '(sh-heredoc ((t (:foreground "yellow" :bold t))))
   '(cua-rectangle ((t (:foreground "white" :background "maroon" :extend t))))
   '(Man-overstrike ((t (:foreground "brightred" :bold t))))
   '(Man-underline ((t (:foreground "brightgreen" :underline nil :bold t)))))))

;;(setq custom-themes '(gl-dark naysayer xcode-dark default-dark
;;                              custom-tango-dark bw monochrome acme))

;;(when (> (length custom-enabled-themes) 1)
;;      (disable-all-themes))
;;(cond
;; ((and (display-graphic-p) (not (daemonp)))
;;  (progn
;;    (load-theme 'naysayer t)
;;    (setq custom-themes-index 1)))
;; (t (load-theme 'gl-dark t)))
