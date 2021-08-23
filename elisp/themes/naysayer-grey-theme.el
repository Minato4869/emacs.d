(deftheme naysayer-grey
  "naysayer-grey theme")

(let ((class '((class color) (min-colors 89)))
      (BG (when (theme/display-colors) "#272727")) ;; was #041818
      (FG (when (theme/display-colors) "#D3B58D"))
      (cursor                       "#8FEE90")
      (border                       "#0000FF")
      (fringe                       "#050404")
      (minibuffer-prompt            "#00FFFF")
      (region-bg                    "#0000FF")
      (region-fg                    "#BEBEBE")

      (font-lock-builtin-face       "#8FEE90")
      (font-lock-comment-face       "#FFFF00")
      (font-lock-function-name-face "#FFFFFF")
      (font-lock-keyword-face       "#FFFFFF")
      (font-lock-string-face        "#C8D4EC")
      (font-lock-type-face          "#98FB98")
      (font-lock-variable-name-face "#FFFFFF")

      (org-level-2                  "#C8D4EC")
      (org-level-3                  "#FFFFFF")
      (org-level-4                  "#FFFF00")
      (org-level-5                  "#8FEE90")
      (org-todo                     "#ffc0cb")
      (org-done                     "#98fb98")
      )

  (custom-theme-set-faces
   'naysayer-grey

   `(default                      ((,class (:background ,BG :foreground ,FG))))
   `(cursor                       ((,class (:background ,cursor))))
   `(border                       ((,class (:foreground ,border))))
   `(fringe                       ((,class (:background ,fringe))))
   `(minibuffer-prompt            ((,class (:foreground ,minibuffer-prompt))))
   `(mode-line                    ((,class (:inverse-video t))))
   `(region                       ((,class (:background ,region-bg :inherit foreground))))

   `(font-lock-builtin-face       ((,class (:foreground ,font-lock-builtin-face))))
   `(font-lock-comment-face       ((,class (:foreground ,font-lock-comment-face))))
   `(font-lock-function-name-face ((,class (:foreground ,font-lock-function-name-face))))
   `(font-lock-keyword-face       ((,class (:foreground ,font-lock-keyword-face))))
   `(font-lock-string-face        ((,class (:foreground ,font-lock-string-face))))
   `(font-lock-type-face          ((,class (:foreground ,font-lock-type-face))))
   `(font-lock-variable-name-face ((,class (:foreground ,font-lock-variable-name-face))))

   `(org-level-2                  ((,class (:foreground ,org-level-2))))
   `(org-level-3                  ((,class (:foreground ,org-level-3))))
   `(org-level-4                  ((,class (:foreground ,org-level-4))))
   `(org-level-5                  ((,class (:foreground ,org-level-5))))
   `(org-todo                     ((,class (:foreground ,org-todo :bold t))))
   `(org-done                     ((,class (:foreground ,org-done :bold t))))

   ))


(provide-theme 'naysayer-grey)
