(deftheme monochrome
  "monochrome theme (inspired by jcs")

(let ((class '((class color) (min-colors 89)))
      ;; light variant
      ;;(BG                 "#D9D5BA")
      ;;(FG                 "#444444")
      ;;(warning            "#FF0000")
      ;;(border             "#0000FF")
      ;;(fringe             "#DAD4bc")
      ;;(region-fg          "#D7D75F")
      ;;(region-bg          "#6C6C6C")
      ;;(monoch-comment     "#6C6C6C")
      ;; dark variant
      (BG                 "#444444")
      (FG                 "#D9D5BA")
      (warning            "#FF0000")
      (border             "#0000FF")
      (fringe             "#121212")
      (region-fg          "#D7D75F")
      (region-bg          "#6C6C6C")
      (monoch-comment     "#bebebe"))

  (custom-theme-set-faces
       'monochrome

       `(default                     ((,class (:background ,BG :foreground ,FG))))
       `(cursor                      ((,class (:background ,FG))))
       `(border                      ((,class (:foreground ,border))))
       `(fringe                      ((,class (:background ,fringe))))
       `(mode-line                   ((,class (:background ,FG :foreground ,BG))))
       `(region                      ((,class (:background ,region-bg
                                                           :foreground ,region-fg))))

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
