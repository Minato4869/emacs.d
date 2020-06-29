(deftheme monochrome
  "monochrome theme")

(let ((class '((class color) (min-colors 89)))
      (BG                 "#D9D5BA")
      (FG                 "#444444")
      (warning            "#FF0000")
      (border             "#0000FF")
      (fringe             "#DAD4bc")
      (region             "#D7D75F")
      (monoch-comment     "#6C6C6C"))

  (custom-theme-set-faces
       'monochrome

       `(default                     ((,class (:background ,BG :foreground ,FG))))
       `(cursor                      ((,class (:background ,FG))))
       `(border                      ((,class (:foreground ,border))))
       `(fringe                      ((,class (:background ,fringe))))
       `(mode-line                   ((,class (:background ,FG :foreground ,BG))))
       `(region                      ((,class (:background ,monoch-comment
                                                           :foreground ,region))))

       `(font-lock-builtin-face       ((,class (:inherit foreground))))
       `(font-lock-comment-face       ((,class (:foreground ,monoch-comment))))
       `(font-lock-constant-face      ((,class (:inherit foreground :underline t))))
       `(font-lock-function-name-face ((,class (:inherit foreground))))
       `(font-lock-keyword-face       ((,class (:inherit foreground :bold t))))
       `(font-lock-string-face        ((,class (:inherit foreground :underline t))))
       `(font-lock-type-face          ((,class (:inherit foreground :bold t))))
       `(font-lock-variable-name-face ((,class (:inherit foreground))))
       `(font-lock-warning-face       ((,class (:foreground ,warning
                                                            :inherit background
                                                            :bold t))))

       `(sh-quoted-exec               ((,class ((:inherit foreground :bold t)))))

       `(ido-subdir                   ((,class ((:inherit foreground :bold t)))))
       `(ido-only-match               ((,class ((:inherit foreground
                                                          :underline t
                                                          :bold t)))))))

(provide-theme 'monochrome)
