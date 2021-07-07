(deftheme naysayer
  "naysayer theme")

(let ((class '((class color) (min-colors 89)))
      (BG                           "#072626")
      (FG                           "#D3B58D")
      (cursor                       "#8FEE90")
      (border                       "#0000FF")
      (fringe                       "#050404")
      (minibuffer-prompt            "#00FFFF")
      (region-bg                    "#0000FF")
      (region-fg                    "#BEBEBE")

      (font-lock-builtin-face       "#8FEE90")
      (font-lock-comment-face       "#3FDF1F")
      (font-lock-function-name-face "#98FB98")
      (font-lock-keyword-face       "#FFFFFF")
      (font-lock-string-face        "#FFFFFF")
      (font-lock-type-face          "#0FDFAF")
      (font-lock-variable-name-face "#C8D4EC")

      (org-todo                     "#ffc0cb")
      (org-done                     "#98fb98"))

  (custom-theme-set-faces
   'naysayer

   `(default                       ((,class (:background ,BG :foreground ,FG))))
   `(cursor                        ((,class (:background ,cursor))))
   `(border                        ((,class (:foreground ,border))))
   `(fringe                        ((,class (:background ,fringe))))
   `(minibuffer-prompt             ((,class (:foreground ,minibuffer-prompt))))
   `(mode-line                     ((,class (:inverse-video t))))
   `(region                        ((,class (:background ,region-bg :inherit foreground))))

   `(font-lock-builtin-face       ((,class (:foreground ,font-lock-builtin-face))))
   `(font-lock-comment-face       ((,class (:foreground ,font-lock-comment-face))))
   `(font-lock-function-name-face ((,class (:foreground ,font-lock-function-name-face))))
   `(font-lock-keyword-face       ((,class (:foreground ,font-lock-keyword-face))))
   `(font-lock-string-face        ((,class (:foreground ,font-lock-string-face))))
   `(font-lock-type-face          ((,class (:foreground ,font-lock-type-face))))
   `(font-lock-variable-name-face ((,class (:foreground ,font-lock-variable-name-face))))

   `(org-todo                     ((,class (:foreground ,org-todo :bold t))))
   `(org-done                     ((,class (:foreground ,org-done :bold t))))

))


(provide-theme 'naysayer)
