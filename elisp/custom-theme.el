(if (or (display-graphic-p) (daemonp))
    (setq ls-directory         "#4286F4"
          ls-executable        "#cc0000"
          ls-symlink           "#75507B"
          trailing-ws          "#FFB6B0"
          man-red              "#EF2929"
          man-green            "#8AE234")
  (setq ls-directory         "brightblue"
        ls-executable        "red"
        ls-symlink           "magenta"
        trailing-ws          "maroon"
        man-red              "brightred"
        man-green            "brightgreen"))

(defun disable-all-themes ()
  "Disable all themes."
  (interactive)
  (dolist (i custom-enabled-themes)
    (disable-theme i)))

(when (> (length custom-enabled-themes) 1)
      (disable-all-themes))

(cond
 ((and (display-graphic-p) (not (daemonp)))
  (progn
    (load-theme 'naysayer t)
    (setq custom-themes-index 1)))
 ((daemonp)
  (disable-all-themes)
  (load-theme 'gl-dark t))
 (t
  (load-theme 'xcode-dark t)))

(custom-set-faces
 `(diff-added ((t (:foreground "green"))))
 `(diff-header ((t (nil))))
 `(diff-removed ((t (:foreground "red"))))
 `(dired-directory ((t (:foreground ,ls-directory ))))
 `(dired-symlink ((t (:foreground ,ls-symlink))))
 `(font-latex-sectioning-0-face ((t (:inherit font-lock-variable-name-face))))
 `(font-latex-sectioning-1-face ((t (:inherit font-latex-sectioning-0-face))))
 `(font-latex-sectioning-2-face ((t (:inherit font-latex-sectioning-1-face))))
 `(font-latex-sectioning-3-face ((t (:inherit font-latex-sectioning-2-face))))
 `(font-latex-sectioning-4-face ((t (:inherit font-latex-sectioning-3-face))))
 `(font-latex-sectioning-5-face ((t (:inherit font-latex-sectioning-4-face))))
 `(hl-line ((t (:extend t))))
 `(ido-first-match ((t (:inherit foreground :bold t :underline t))))
 `(ido-incomplete-regexp ((t (:inherit foreground))))
 `(ido-indicator ((t (:inherit foreground))))
 `(line-number ((t (:inherit foreground :bold t))))
 `(minibuffer-prompt ((t (:inherit foreground :bold t))))
 `(mouse ((t (:background "black" :foreground "white" ))))
 `(region ((t (:extend t))))
 `(trailing-whitespace ((t (:background ,trailing-ws))))
 `(variable-pitch ((t (:font "Sans-Serif-14"))))
 `(eshell-ls-directory ((t (:foreground ,ls-directory))))
 `(eshell-ls-archive ((t (:inherit foreground))))
 `(eshell-ls-backup ((t (:inherit foreground))))
 `(eshell-ls-clutter ((t (:inherit foreground))))
 `(eshell-ls-executable ((t (:foreground ,ls-executable))))
 `(eshell-ls-symlink ((t (:foreground ,ls-symlink))))
;; `(show-paren-match ((t (:inherit :foreground  :background ,sp-match-bg))))

 `(Man-overstrike ((t (:foreground ,man-red :bold t))))
 `(Man-underline ((t (:foreground ,man-green :underline nil :bold t)))))
