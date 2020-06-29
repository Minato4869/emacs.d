(deftheme gl-light
  "gl-light theme")

(let ((class '((class color) (min-colors 89)))
      (BG                 "#D9D5BA")
      (FG                 "#444444")
      (cursor             "#FF0000")
      (border             "#0000FF")
      (fringe             "#DAD4BC")
      (modeline           "#292929")
      (region             "#D7D75F")
      (warning            "#FF0000")

      (gl-purple          "#A020F0")
      (gl-red             "#ff0000")
      (gl-darkcyan        "#008B8B")
      (gl-blue1           "#0000FF")
      (gl-forestgreen     "#228B22")
      (gl-sienna          "#A0522D")
      (gl-grey            "#6C6C6C"))

  (custom-theme-set-faces
   'gl-light

   `(default                      ((,class (:background ,BG :foreground ,FG))))
   `(cursor                       ((,class (:inherit foreground))))
   `(border                       ((,class (:foreground ,border))))
   `(fringe                       ((,class (:background ,fringe))))
   `(mode-line                    ((,class (:background ,FG :foreground ,BG))))
   `(region                       ((,class (:background ,gl-grey :foreground ,region))))

   `(font-lock-builtin-face       ((,class (:foreground ,gl-purple))))
   `(font-lock-comment-face       ((,class (:foreground ,gl-red))))
   `(font-lock-constant-face      ((,class (:foreground ,gl-darkcyan))))
   `(font-lock-function-name-face ((,class (:foreground ,gl-purple))))
   `(font-lock-keyword-face       ((,class (:foreground ,gl-blue1))))
   `(font-lock-string-face        ((,class (:foreground ,gl-forestgreen))))
   `(font-lock-type-face          ((,class (:foreground ,gl-forestgreen))))
   `(font-lock-variable-name-face ((,class (:foreground ,gl-sienna))))
   `(font-lock-warning-face       ((,class (:foreground ,warning :bold t))))))

(provide-theme 'gl-light)
