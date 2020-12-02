(deftheme gl-dark
  "gl-dark theme")

(let ((class '((class color) (min-colors 89)))
      (BG                 "#000000")
      (FG                 "#BEBEBE")
      (cursor             "#DB0600") ;; was #FF0000
      (border             "#0000FF")
      (fringe             "#121212")
      (modeline           "#292929")
      (region             "#114488")
      (warning            "#FF0000")

      (ido-green          "#A1C659")
      (ido-yellow         "#FFCC33")

      (gl/lightblue       "#729FCF")
      (gl/darkgreen       "#4E9A06")
      (gl/darkred         "#CC0000")
      (gl/lilac           "#75507B")
      (gl/yellow          "#C4A000"))

  (custom-theme-set-faces
   'gl/dark

   `(default                      ((,class (:background ,BG :foreground ,FG))))
   `(cursor                       ((,class (:background ,cursor))))
   `(border                       ((,class (:foreground ,border))))
   `(fringe                       ((,class (:background ,fringe))))
   `(mode-line                    ((,class (:background ,modeline :inherit foreground))))
   `(region                       ((,class (:background ,region :foreground ,FG))))

   `(font-lock-builtin-face       ((,class (:foreground ,gl/lilac))))
   `(font-lock-comment-face       ((,class (:foreground ,gl/darkred))))
   `(font-lock-constant-face      ((,class (:foreground ,gl/darkgreen))))
   `(font-lock-function-name-face ((,class (:foreground ,gl/lilac))))
   `(font-lock-keyword-face       ((,class (:foreground ,gl/lightblue))))
   `(font-lock-string-face        ((,class (:foreground ,gl/darkgreen))))
   `(font-lock-type-face          ((,class (:foreground ,gl/darkgreen))))
   `(font-lock-variable-name-face ((,class (:foreground ,gl/yellow))))
   `(font-lock-warning-face       ((,class (:foreground ,warning :bold t))))

   `(ido-subdir                   ((,class (:foreground ,ido-green))))
   `(ido-only-match               ((,class (:foreground ,ido-yellow))))))

(provide-theme 'gl/dark)
