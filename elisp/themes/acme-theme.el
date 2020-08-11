(deftheme acme
  "acme theme (inspired by jcs")

(let ((class '((class color) (min-colors 89)))
      (BG                 "#FFFFEA")
      (FG                 "#000000")
      (warning            "#FF0000")
      (mode-line          "#EAFFFF")
      (border             "#0000FF")
      (fringe             "#DAD4bc")
      (region-fg          "#000000")
      (region-bg          "#EEEE9E"))

  (custom-theme-set-faces
       'acme

       `(default                     ((,class (:background ,BG :foreground ,FG))))
       `(cursor                      ((,class (:background ,FG))))
       `(border                      ((,class (:foreground ,border))))
       `(fringe                      ((,class (:background ,fringe))))
       `(mode-line                   ((,class (:background ,mode-line :box t
                                                           :inherit foreground ))))
       `(mode-line-inactive          ((,class (:background ,mode-line
                                                           :inherit foreground ))))
       `(region                      ((,class (:background ,region-bg
                                                           :foreground ,region-fg))))

       `(font-lock-builtin-face       ((,class (:inherit foreground))))
       `(font-lock-comment-face       ((,class (:inherit foreground))))
       `(font-lock-constant-face      ((,class (:inherit foreground))))
       `(font-lock-function-name-face ((,class (:inherit foreground))))
       `(font-lock-keyword-face       ((,class (:inherit foreground))))
       `(font-lock-string-face        ((,class (:inherit foreground))))
       `(font-lock-type-face          ((,class (:inherit foreground))))
       `(font-lock-variable-name-face ((,class (:inherit foreground))))
       `(font-lock-warning-face       ((,class (:foreground ,warning
                                                            :inherit background
                                                            :bold t))))

       `(sh-quoted-exec               ((,class ((:inherit foreground)))))

       `(ido-subdir                   ((,class ((:inherit foreground :bold t)))))
       `(ido-only-match               ((,class ((:inherit foreground
                                                          :underline t
                                                          :bold t)))))))

(provide-theme 'acme)
