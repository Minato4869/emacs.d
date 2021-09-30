(deftheme <themename>
  "<themename> theme")

(let ((BG                               "")
      (FG                               "")
      (cursor                           "")
      (border                           "")
      (fringe                           "")
      (mode-line-bg                     "")

      (mode-line-inactive-fg            "")
      (mode-line-inactive-bg            "")
      (mode-line-inactive-box           "")

      (region-bg                        "")
      (region-fg                        "")

      (font-lock-builtin-face           "")
      (font-lock-comment-face           "")
      (font-lock-constant-face          "")
      (font-lock-function-name-face     "")
      (font-lock-keyword-face           "")
      (font-lock-string-face            "")
      (font-lock-type-face              "")
      (font-lock-variable-name-face     "")
      )
  (custom-theme-set-faces
   '<themename>

   `(default                      ((((type tty)) (:background "unspecified-bg" :foreground "unspecified-fg"))
                                   (t            (:background ,BG :foreground ,FG))))

   `(cursor                       ((t (:background ,cursor))))
   `(border                       ((t (:foreground ,border))))
   `(fringe                       ((t (:background ,fringe))))
   `(minibuffer-prompt            ((t (:inherit default :bold t))))
   `(mode-line                    ((t (:background ,mode-line-bg :inherit default))))
   `(mode-line-inactive           ((t (:background ,mode-line-inactive-bg :foreground ,mode-line-inactive-fg
                                                        :box (:line-width -1 :color ,mode-line-inactive-box :style nil)))))
   `(region                       ((t (:background ,region-bg :foreground ,region-fg))))

   `(font-lock-builtin-face       ((t (:foreground ,font-lock-builtin-face))))
   `(font-lock-comment-face       ((t (:foreground ,font-lock-comment-face))))
   `(font-lock-constant-face      ((t (:foreground ,font-lock-constant-face))))
   `(font-lock-function-name-face ((t (:foreground ,font-lock-function-name-face))))
   `(font-lock-keyword-face       ((t (:foreground ,font-lock-keyword-face))))
   `(font-lock-string-face        ((t (:foreground ,font-lock-string-face))))
   `(font-lock-type-face          ((t (:foreground ,font-lock-type-face))))
   `(font-lock-variable-name-face ((t (:foreground ,font-lock-variable-name-face))))
   ))
(provide-theme '<themename>)
