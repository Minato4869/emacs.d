(deftheme xcode-dark
  "xcode-dark theme")

(let ((BG                               "#000000")
      (FG                               "#FFFFFF") ;; was #ffffff; then e5e5e5; then d8d8d8
      (cursor                           "#DB0600")
      (border                           "#0000FF")
      (fringe                           "#121212")
      (modeline                         "#292929")
      (region                           "#00077a")

      (font-lock-builtin-face           "#4C99EB")
      (font-lock-comment-face           "#FF6805")
      (font-lock-function-name-face     "#EBD900")
      (font-lock-keyword-face           "#00FF15")
      (font-lock-string-face            "#00FFC0")
      (font-lock-type-face              "#FF47F3")
      (font-lock-variable-name-face     "#1492FF"))

  (custom-theme-set-faces
   'xcode-dark

   `(default                      ((((type tty)) (:background "black" :foreground "boldwhite")) ;; bg was color 16
                                   (t            (:background ,BG :foreground ,FG))))
   `(cursor                       ((t (:background ,cursor))))
   `(border                       ((t (:foreground ,border))))
   `(fringe                       ((t (:background ,fringe))))
   `(minibuffer-prompt            ((t (:inherit default :bold t))))
   `(mode-line                    ((t (:background ,modeline :inherit default))))
   `(region                       ((t (:background ,region))))

   `(font-lock-builtin-face       ((t (:foreground ,font-lock-builtin-face))))
   `(font-lock-comment-face       ((t (:foreground ,font-lock-comment-face))))
   `(font-lock-function-name-face ((t (:foreground ,font-lock-function-name-face))))
   `(font-lock-keyword-face       ((t (:foreground ,font-lock-keyword-face))))
   `(font-lock-string-face        ((t (:foreground ,font-lock-string-face))))
   `(font-lock-type-face          ((t (:foreground ,font-lock-type-face))))
   `(font-lock-variable-name-face ((t (:foreground ,font-lock-variable-name-face))))))

(provide-theme 'xcode-dark)
