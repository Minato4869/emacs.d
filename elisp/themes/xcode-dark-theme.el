(deftheme xcode-dark
  "xcode-dark theme")

(let ((class '((class color) (min-colors 89)))
      (BG  (when (theme/display-colors) "#000000"))
      (FG  (when (theme/display-colors) "#FFFFFF"))
      (cursor                           "#DB0600")
      (border                           "#0000FF")
      (fringe                           "#121212")
      (modeline                         "#292929")
      (region                           "#00077a")

      (xcode/builtin                    "#4C99EB")
      (xcode/comment                    "#FF6805")
      (xcode/function                   "#EBD900")
      (xcode/keyword                    "#00FF15")
      (xcode/string                     "#00FFC0")
      (xcode/type                       "#FF47F3")
      (xcode/variable                   "#1492FF"))

  (custom-theme-set-faces
   'xcode-dark

   `(default                      ((,class (:background ,BG :foreground ,FG))))
   `(cursor                       ((,class (:background ,cursor))))
   `(border                       ((,class (:foreground ,border))))
   `(fringe                       ((,class (:background ,fringe))))
   `(minibuffer-prompt            ((,class (:inherit foreground :bold t))))
   `(mode-line                    ((,class (:background ,modeline :inherit foreground))))
   `(region                       ((,class (:background ,region))))

   `(font-lock-builtin-face       ((,class (:foreground ,xcode/builtin))))
   `(font-lock-comment-face       ((,class (:foreground ,xcode/comment))))
   `(font-lock-function-name-face ((,class (:foreground ,xcode/function))))
   `(font-lock-keyword-face       ((,class (:foreground ,xcode/keyword))))
   `(font-lock-string-face        ((,class (:foreground ,xcode/string))))
   `(font-lock-type-face          ((,class (:foreground ,xcode/type))))
   `(font-lock-variable-name-face ((,class (:foreground ,xcode/variable))))))

(provide-theme 'xcode-dark)
