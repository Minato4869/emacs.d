(deftheme acme
  "acme theme")

(let ((class '((class color) (min-colors 89)))
      (BG                 "#FFFFEA")
      (FG                 "#000000")
      (warning            "#FF0000")
      (mode-line          "#EAFFFF")
      (border             "#0000FF")
      (fringe             "#DAD4bc")
      (region-fg          "#000000")
      (green              "#005500")
      (string             "#5E81AC")
      (function-name      "#1054AF")
      (region-bg          "#EEEE9E"))

  (custom-theme-set-faces
       'acme

       `(default                     ((,class (:background ,BG :foreground ,FG))))
       `(cursor                      ((,class (:background ,FG))))
       `(border                      ((,class (:foreground ,border))))
       `(fringe                      ((,class (:background ,fringe))))
       `(mode-line                   ((,class (:background ,mode-line :inherit foreground
                                                           :box t ))))
       `(mode-line-inactive          ((,class (:background ,mode-line
                                                           :inherit foreground ))))
       `(region                      ((,class (:background ,region-bg
                                                           :foreground ,region-fg))))

       `(font-lock-builtin-face       ((,class (:inherit foreground))))
       `(font-lock-comment-face       ((,class (:foreground ,green))))
       `(font-lock-constant-face      ((,class (:inherit foreground))))
       `(font-lock-function-name-face ((,class (:foreground ,function-name :bold t))))
       `(font-lock-keyword-face       ((,class (:inherit foreground :bold t))))
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

(provide-theme 'acme)
