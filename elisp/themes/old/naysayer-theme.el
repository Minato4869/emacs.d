(deftheme naysayer
  "naysayer theme")

(let ((BG                           "#072626")
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

   `(default                       ((((type tty)) (:background "unspecified-bg" :foreground "unspecified-fg"))
                                    (t            (:background ,BG :foreground ,FG))))
   `(cursor                        ((t (:background ,cursor))))
   `(border                        ((t (:foreground ,border))))
   `(fringe                        ((t (:background ,fringe))))
   `(minibuffer-prompt             ((t (:foreground ,minibuffer-prompt))))
   `(mode-line                     ((t (:inverse-video t))))
   `(region                        ((t (:background ,region-bg :inherit default))))

   `(font-lock-builtin-face        ((t (:foreground ,font-lock-builtin-face))))
   `(font-lock-comment-face        ((t (:foreground ,font-lock-comment-face))))
   `(font-lock-function-name-face  ((t (:foreground ,font-lock-function-name-face))))
   `(font-lock-keyword-face        ((t (:foreground ,font-lock-keyword-face))))
   `(font-lock-string-face         ((t (:foreground ,font-lock-string-face))))
   `(font-lock-type-face           ((t (:foreground ,font-lock-type-face))))
   `(font-lock-variable-name-face  ((t (:foreground ,font-lock-variable-name-face))))

   `(org-todo                      ((t (:foreground ,org-todo :bold t))))
   `(org-done                      ((t (:foreground ,org-done :bold t))))

   ))


(provide-theme 'naysayer)
