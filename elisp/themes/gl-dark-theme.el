(deftheme gl-dark
  "gl-dark theme")

(let ((class '((class color) (min-colors 89)))
      (BG  (when (theme/display-colors) "#000000"))
      (FG  (when (theme/display-colors) "#BEBEBE"))
      (cursor                           "#FF0000")
      (border                           "#0000FF")
      (fringe                           "#121212")
      (mode-line                        "#292929")

      (mode-line-fg                     "#CCCCCC")
      (mode-line-bg                     "#4D4D4D")
      (mode-line-box                    "#666666")

      (region-bg                        "#114488")
      (region-fg                        "#BEBEBE")

      (ido-subdir                       "#A1C659")
      (ido-only-match                   "#FFCC33")

      (font-lock-builtin-face           "#75507B")
      (font-lock-comment-face           "#CC0000")
      (font-lock-constant-face          "#4E9A06")
      (font-lock-function-face          "#75507B")
      (font-lock-keyword-face           "#729FCF")
      (font-lock-string-face            "#4E9A06")
      (font-lock-type-face              "#4E9A06")
      (font-lock-variable-face          "#C4A000")

      (org-level-2                      "#C4A000")
      (org-level-3                      "#729FCF")
      (org-level-4                      "#CC0000")
      (org-level-5                      "#4E9A06")
      (org-date                         "#2C78BF") ;; was cyan

      (sh-quoted-exec                   "#FA8072")
      )
  (custom-theme-set-faces
   'gl-dark

   `(default                      ((,class (:background ,BG :foreground ,FG))))
   `(cursor                       ((,class (:background ,cursor))))
   `(border                       ((,class (:foreground ,border))))
   `(fringe                       ((,class (:background ,fringe))))
   `(minibuffer-prompt            ((,class (:inherit foreground :bold t))))
   `(mode-line                    ((,class (:background ,mode-line :inherit foreground))))
   `(mode-line-inactive           ((,class (:background ,mode-line-bg :foreground ,mode-line-fg
                                                        :box (:line-width -1 :color ,mode-line-box :style nil)))))
   `(region                       ((,class (:background ,region-bg :foreground ,region-fg))))

   `(font-lock-builtin-face       ((,class (:foreground ,font-lock-builtin-face))))
   `(font-lock-comment-face       ((,class (:foreground ,font-lock-comment-face))))
   `(font-lock-constant-face      ((,class (:foreground ,font-lock-constant-face))))
   `(font-lock-function-name-face ((,class (:foreground ,font-lock-function-face))))
   `(font-lock-keyword-face       ((,class (:foreground ,font-lock-keyword-face))))
   `(font-lock-string-face        ((,class (:foreground ,font-lock-string-face))))
   `(font-lock-type-face          ((,class (:foreground ,font-lock-type-face))))
   `(font-lock-variable-name-face ((,class (:foreground ,font-lock-variable-face))))

   `(ido-subdir                   ((,class (:foreground ,ido-subdir))))
   `(ido-only-match               ((,class (:foreground ,ido-only-match))))

   `(org-level-2                  ((,class (:foreground ,org-level-2))))
   `(org-level-3                  ((,class (:foreground ,org-level-3))))
   `(org-level-4                  ((,class (:foreground ,org-level-4))))
   `(org-level-5                  ((,class (:foreground ,org-level-5))))
   `(org-date                     ((,class (:foreground ,org-date :underline nil))))
   `(sh-quoted-exec               ((,class (:foreground ,sh-quoted-exec))))


   ))
(provide-theme 'gl-dark)
