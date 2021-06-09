(deftheme gl-dark
  "gl-dark theme")

(let ((class '((class color) (min-colors 89)))
      (BG  (when (theme/display-colors) "#000000"))
      (FG  (when (theme/display-colors) "#BEBEBE"))
      (cursor                           "#FF0000")
      (border                           "#0000FF")
      (fringe                           "#121212")
      (modeline                         "#292929")
      (region-bg                        "#114488")
      (region-fg                        "#BEBEBE")

      (ido-subdir                       "#A1C659")
      (ido-only-match                   "#FFCC33")

      (gl/builtin                       "#75507B")
      (gl/comment                       "#CC0000")
      (gl/constant                      "#4E9A06")
      (gl/function                      "#75507B")
      (gl/keyword                       "#729FCF")
      (gl/string                        "#4E9A06")
      (gl/type                          "#4E9A06")
      (gl/variable                      "#C4A000")

      (org-level-2                      "#C4A000")
      (org-level-3                      "#729FCF")
      (org-level-4                      "#CC0000")
      (org-level-5                      "#4E9A06")
      (org-date                         "#2C78BF")) ;; was cyan
  (custom-theme-set-faces
   'gl-dark

   `(default                      ((,class (:background ,BG :foreground ,FG))))
   `(cursor                       ((,class (:background ,cursor))))
   `(border                       ((,class (:foreground ,border))))
   `(fringe                       ((,class (:background ,fringe))))
   `(minibuffer-prompt            ((,class (:inherit foreground :bold t))))
   `(mode-line                    ((,class (:background ,modeline :inherit foreground))))
   `(region                       ((,class (:background ,region-bg :foreground ,region-fg))))

   `(font-lock-builtin-face       ((,class (:foreground ,gl/builtin))))
   `(font-lock-comment-face       ((,class (:foreground ,gl/comment))))
   `(font-lock-constant-face      ((,class (:foreground ,gl/constant))))
   `(font-lock-function-name-face ((,class (:foreground ,gl/function))))
   `(font-lock-keyword-face       ((,class (:foreground ,gl/keyword))))
   `(font-lock-string-face        ((,class (:foreground ,gl/string))))
   `(font-lock-type-face          ((,class (:foreground ,gl/type))))
   `(font-lock-variable-name-face ((,class (:foreground ,gl/variable))))

   `(ido-subdir                   ((,class (:foreground ,ido-subdir))))
   `(ido-only-match               ((,class (:foreground ,ido-only-match))))

   `(org-level-2                  ((,class (:foreground ,org-level-2))))
   `(org-level-3                  ((,class (:foreground ,org-level-3))))
   `(org-level-4                  ((,class (:foreground ,org-level-4))))
   `(org-level-5                  ((,class (:foreground ,org-level-5))))
   `(org-date                     ((,class (:foreground ,org-date :underline nil))))
   ))
(provide-theme 'gl-dark)
