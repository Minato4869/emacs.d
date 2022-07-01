(deftheme naysayer-grey
  "naysayer-grey theme")

(let ((BG                           "#272727") ;; was #041818
      (FG                           "#D3B58D")
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

   `(default                      ((((type tty)) (:background "unspecified-bg" :foreground "unspecified-fg"))
                                   (t            (:background ,BG :foreground ,FG))))
   `(cursor                       ((t (:background ,cursor))))
   `(border                       ((t (:foreground ,border))))
   `(fringe                       ((t (:background ,fringe))))
   `(minibuffer-prompt            ((t (:foreground ,minibuffer-prompt))))
   `(mode-line                    ((t (:inverse-video t))))
   `(region                       ((t (:background ,region-bg :inherit default))))

   `(font-lock-builtin-face       ((t (:foreground ,font-lock-builtin-face))))
   `(font-lock-comment-face       ((t (:foreground ,font-lock-comment-face))))
   `(font-lock-function-name-face ((t (:foreground ,font-lock-function-name-face))))
   `(font-lock-keyword-face       ((t (:foreground ,font-lock-keyword-face))))
   `(font-lock-string-face        ((t (:foreground ,font-lock-string-face))))
   `(font-lock-type-face          ((t (:foreground ,font-lock-type-face))))
   `(font-lock-variable-name-face ((t (:foreground ,font-lock-variable-name-face))))

   `(org-level-2                  ((t (:foreground ,org-level-2))))
   `(org-level-3                  ((t (:foreground ,org-level-3))))
   `(org-level-4                  ((t (:foreground ,org-level-4))))
   `(org-level-5                  ((t (:foreground ,org-level-5))))
   `(org-todo                     ((t (:foreground ,org-todo :bold t))))
   `(org-done                     ((t (:foreground ,org-done :bold t))))

   ))


(provide-theme 'naysayer-grey)
