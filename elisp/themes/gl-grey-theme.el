(deftheme gl-grey
  "gl-grey theme")

(let ((class '((class color) (min-colors 89)))
      (BG  (when (theme/display-colors) "#333333"))
      (FG  (when (theme/display-colors) "#E5E5E5"))
      (cursor                           "#00FF00")
      (fringe                           "#1A1A1A")
      (mode-line-fg                     "#000000")
      (mode-line-bg                     "#BFBFBF")

      (mode-line-inactive-fg            "#CCCCCC")
      (mode-line-inactive-bg            "#4D4D4D")
      (mode-line-inactive-box           "#666666")

      (region-bg                        "#114488")
      (region-fg                        "#E5E5E5")

      (font-lock-builtin-face           "#E5E5E5")
      (font-lock-comment-face           "#E5E5E5")
      (font-lock-constant-face          "#E5E5E5")
      (font-lock-function-name-face     "#E5E5E5")
      (font-lock-keyword-face           "#E5E5E5")
      (font-lock-string-face            "#E5E5E5")
      (font-lock-type-face              "#E5E5E5")
      (font-lock-variable-name-face     "#E5E5E5")

      (org-level-1                      "#E5E5E5")
      (org-level-2                      "#E5E5E5")
      (org-level-3                      "#E5E5E5")
      (org-level-4                      "#E5E5E5")
      (org-level-5                      "#E5E5E5")
      (org-date                         "#2C78BF") ;; was cyan

      (sh-quoted-exec                   "#E5E5E5"))
  (custom-theme-set-faces
   'gl-grey

   `(default                      ((,class (:background ,BG :foreground ,FG))))
   `(cursor                       ((,class (:background ,cursor))))
   `(fringe                       ((,class (:background ,fringe))))
   `(minibuffer-prompt            ((,class (:inherit foreground :bold t))))
   `(mode-line                    ((,class (:background ,mode-line-bg :foreground ,mode-line-fg
                                                        :box (:line-width -1 :style released-button)))))
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

   `(org-level-1                  ((,class (:foreground ,org-level-1 :weight extra-bold))))
   `(org-level-2                  ((,class (:foreground ,org-level-2 :weight bold))))
   `(org-level-3                  ((,class (:foreground ,org-level-3))))
   `(org-level-4                  ((,class (:foreground ,org-level-4))))
   `(org-level-5                  ((,class (:foreground ,org-level-5))))
   `(org-date                     ((,class (:foreground ,org-date :underline nil))))
   `(sh-quoted-exec               ((,class (:foreground ,sh-quoted-exec))))
   ))
(provide-theme 'gl-grey)
