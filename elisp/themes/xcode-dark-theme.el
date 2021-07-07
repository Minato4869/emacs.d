(deftheme xcode-dark
  "xcode-dark theme")

(let ((class '((class color) (min-colors 89)))
      (BG  (when (theme/display-colors) "#000000"))
      (FG  (when (theme/display-colors) "#E5E5E5")) ;; was #ffffff
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

   `(default                      ((,class (:background ,BG :foreground ,FG))))
   `(cursor                       ((,class (:background ,cursor))))
   `(border                       ((,class (:foreground ,border))))
   `(fringe                       ((,class (:background ,fringe))))
   `(minibuffer-prompt            ((,class (:inherit foreground :bold t))))
   `(mode-line                    ((,class (:background ,modeline :inherit foreground))))
   `(region                       ((,class (:background ,region))))

   `(font-lock-builtin-face       ((,class (:foreground ,font-lock-builtin-face))))
   `(font-lock-comment-face       ((,class (:foreground ,font-lock-comment-face))))
   `(font-lock-function-name-face ((,class (:foreground ,font-lock-function-name-face))))
   `(font-lock-keyword-face       ((,class (:foreground ,font-lock-keyword-face))))
   `(font-lock-string-face        ((,class (:foreground ,font-lock-string-face))))
   `(font-lock-type-face          ((,class (:foreground ,font-lock-type-face))))
   `(font-lock-variable-name-face ((,class (:foreground ,font-lock-variable-name-face))))))

(provide-theme 'xcode-dark)
