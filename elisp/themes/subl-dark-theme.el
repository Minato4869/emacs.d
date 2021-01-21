(deftheme subl-dark
  "subl-dark theme")

(let ((class '((class color) (min-colors 89)))
      (BG                 "#050505")
      (FG                 "#BEBEBE")
      (cursor             "#DB0600") ;; was #FF0000
      (border             "#0000FF")
      (fringe             "#121212")
      (modeline           "#292929")
      (region             "#114488")

      (subl/builtin       "#f92627")
      (subl/comment       "#17f018")
      (subl/constant      "#ae81ff")
      (subl/function      "#a6e22e")
      (subl/keyword       "#f92627")
      (subl/string        "#e6db74")
      (subl/type          "#66d9ef")
      (subl/variable      "#fd971f"))


  (custom-theme-set-faces
   'subl-dark

   `(default                      ((,class (:background ,BG :foreground ,FG))))
   `(cursor                       ((,class (:background ,cursor))))
   `(border                       ((,class (:foreground ,border))))
   `(fringe                       ((,class (:background ,fringe))))
   `(minibuffer-prompt            ((,class (:inherit forground :bold t))))
   `(mode-line                    ((,class (:background ,modeline :inherit foreground))))
   `(region                       ((,class (:background ,region :foreground ,FG))))

   `(font-lock-builtin-face       ((,class (:foreground ,subl/builtin))))
   `(font-lock-comment-face       ((,class (:foreground ,subl/comment))))
   `(font-lock-constant-face      ((,class (:foreground ,subl/constant))))
   `(font-lock-function-name-face ((,class (:foreground ,subl/function))))
   `(font-lock-keyword-face       ((,class (:foreground ,subl/keyword))))
   `(font-lock-string-face        ((,class (:foreground ,subl/string))))
   `(font-lock-type-face          ((,class (:foreground ,subl/type))))
   `(font-lock-variable-name-face ((,class (:foreground ,subl/variable))))))

(provide-theme 'subl-dark)
