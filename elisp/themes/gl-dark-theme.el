(deftheme gl-dark
  "gl-dark theme")

(let ((class '((class color) (min-colors 89)))
      (BG  (when (theme/display-colors) "#000000"))
      (FG  (when (theme/display-colors) "#BEBEBE"))
      (cursor                           "#FF0000")
      (border                           "#0000FF")
      (fringe                           "#121212")
      (mode-line-bg                     "#292929")

      (mode-line-inactive-fg            "#CCCCCC")
      (mode-line-inactive-bg            "#4D4D4D")
      (mode-line-inactive-box           "#666666")

      (region-bg                        "#114488")
      (region-fg                        "#BEBEBE")

      (ido-subdir                       "#A1C659")
      (ido-only-match                   "#FFCC33")

      (font-lock-builtin-face           "#75507B")
      (font-lock-comment-face           "#CC0000")
      (font-lock-constant-face          "#4E9A06")
      (font-lock-function-name-face     "#75507B")
      (font-lock-keyword-face           "#729FCF")
      (font-lock-string-face            "#4E9A06")
      (font-lock-type-face              "#4E9A06")
      (font-lock-variable-name-face     "#C4A000")

      (org-level-2                      "#C4A000")
      (org-level-3                      "#729FCF")
      (org-level-4                      "#CC0000")
      (org-level-5                      "#4E9A06")
      (org-date                         "#2C78BF") ;; was cyan
      (org-todo                         "#ffc0cb")
      (org-done                         "#98fb98")

      (sh-quoted-exec                   "#FA8072")
      )
  (custom-theme-set-faces
   'gl-dark

   `(default                      ((,class (:background ,BG :foreground ,FG))))
   `(cursor                       ((,class (:background ,cursor))))
   `(border                       ((,class (:foreground ,border))))
   `(fringe                       ((,class (:background ,fringe))))
   `(minibuffer-prompt            ((,class (:inherit foreground :bold t))))
   `(mode-line                    ((,class (:background ,mode-line-bg :inherit foreground))))
   `(mode-line-inactive           ((,class (:background ,mode-line-inactive-bg :foreground ,mode-line-inactive-fg
                                                        :box (:line-width -1 :color ,mode-line-inactive-box :style nil)))))
   `(region                       ((,class (:background ,region-bg :foreground ,region-fg))))

   `(font-lock-builtin-face       ((,class (:foreground ,font-lock-builtin-face))))
   `(font-lock-comment-face       ((,class (:foreground ,font-lock-comment-face))))
   `(font-lock-constant-face      ((,class (:foreground ,font-lock-constant-face))))
   `(font-lock-function-name-face ((,class (:foreground ,font-lock-function-name-face))))
   `(font-lock-keyword-face       ((,class (:foreground ,font-lock-keyword-face))))
   `(font-lock-string-face        ((,class (:foreground ,font-lock-string-face))))
   `(font-lock-type-face          ((,class (:foreground ,font-lock-type-face))))
   `(font-lock-variable-name-face ((,class (:foreground ,font-lock-variable-name-face))))

   `(ido-subdir                   ((,class (:foreground ,ido-subdir))))
   `(ido-only-match               ((,class (:foreground ,ido-only-match))))

   `(org-level-2                  ((,class (:foreground ,org-level-2))))
   `(org-level-3                  ((,class (:foreground ,org-level-3))))
   `(org-level-4                  ((,class (:foreground ,org-level-4))))
   `(org-level-5                  ((,class (:foreground ,org-level-5))))
   `(org-date                     ((,class (:foreground ,org-date))))
   `(org-todo                     ((,class (:foreground ,org-todo :bold t))))
   `(org-done                     ((,class (:foreground ,org-done :bold t))))

   `(sh-quoted-exec               ((,class (:foreground ,sh-quoted-exec))))
   ))
(provide-theme 'gl-dark)
