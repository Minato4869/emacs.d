(deftheme bw
  "bw theme")

(let ((class '((class color) (min-colors 89)))
      (BG                 "#000000")
      (FG                 "#BEBEBE")
      (warning            "#FF0000")
      (border             "#0000FF")
      (fringe             "#121212")
      (region-fg          "#BEBEBE")
      (region-bg          "#114488")
      (cursor             "#00FF00")
      (mode-line          "#292929")
      (bw-comment         "#666666"))

  (custom-theme-set-faces
       'bw

       `(default                     ((,class (:background ,BG :foreground ,FG))))
       `(cursor                      ((,class (:background ,cursor))))
       `(border                      ((,class (:foreground ,border))))
       `(fringe                      ((,class (:background ,fringe))))
       ;; `(mode-line                   ((,class (:background ,FG :foreground ,BG))))
       `(mode-line                   ((,class (:background ,mode-line :foreground ,FG))))
       `(region                      ((,class (:background ,region-bg
                                                           :foreground ,region-fg))))

       `(font-lock-builtin-face       ((,class (:inherit foreground))))
       `(font-lock-comment-face       ((,class (:foreground ,bw-comment))))
       `(font-lock-constant-face      ((,class (:inherit foreground :underline t))))
       `(font-lock-function-name-face ((,class (:inherit foreground))))
       `(font-lock-keyword-face       ((,class (:inherit foreground :bold t))))
       ;;       `(font-lock-string-face        ((,class (:inherit foreground :underline t))))
       `(font-lock-string-face        ((,class (:foreground "white"))))
       `(font-lock-type-face          ((,class (:inherit foreground :bold t))))
       `(font-lock-variable-name-face ((,class (:inherit foreground))))
       `(font-lock-warning-face       ((,class (:foreground ,warning
                                                            :inherit background
                                                            :bold t))))

       `(sh-quoted-exec               ((,class ((:inherit foreground :bold t)))))
       `(org-latex-and-related        ((,class (:inherit foreground))))

       `(ido-subdir                   ((,class ((:inherit foreground :bold t)))))
       `(ido-only-match               ((,class ((:inherit foreground
                                                          :underline t
                                                          :bold t)))))))

(provide-theme 'bw)
