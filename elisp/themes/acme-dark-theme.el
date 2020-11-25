(deftheme acme-dark
  "acme-dark theme")

(let ((class '((class color) (min-colors 89)))
      (BG                 "#2E3440")
      (FG                 "#EAEAEA") ;; was white
      (warning            "#FF0000")
      (fringe             "#2E3440")
      (comment            "#BEBEBE") ;; was  bebebe
      (string             "#C8D4EC")
      (function-name      "#87CEFA")
      (blue2              "#5E81AC"))

  (custom-theme-set-faces
       'acme-dark

       `(default                     ((,class (:background ,BG :foreground ,FG))))
       `(cursor                      ((,class (:background ,blue2))))
       `(border                      ((,class (:foreground ,blue2))))
       `(fringe                      ((,class (:background ,fringe))))
       `(region                      ((,class (:background ,blue2
                                                           :foreground ,FG))))

       `(font-lock-builtin-face       ((,class (:inherit foreground))))
       `(font-lock-comment-face       ((,class (:foreground ,comment))))
       `(font-lock-constant-face      ((,class (:inherit foreground :underline t))))
       `(font-lock-function-name-face ((,class (:foreground ,function-name))))
       `(font-lock-keyword-face       ((,class (:inherit foreground))))
       `(font-lock-string-face        ((,class (:foreground ,string))))
       `(font-lock-type-face          ((,class (:inherit foreground :bold t))))
       `(font-lock-variable-name-face ((,class (:inherit foreground))))
       `(font-lock-warning-face       ((,class (:foreground ,warning
                                                            :inherit background
                                                            :bold t))))

       `(sh-quoted-exec               ((,class ((:inherit foreground)))))

       `(ido-subdir                   ((,class ((:inherit foreground :bold t)))))
       `(ido-only-match               ((,class ((:inherit foreground
                                                          :underline t
                                                          :bold t)))))))

(provide-theme 'acme-dark)
