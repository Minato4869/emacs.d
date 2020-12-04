(deftheme xcode-dark
  "xcode-dark")

(let ((class '((class color) (min-colors 89)))
      (BG                 "#000000")
      (FG                 "#BEBEBE") ;; was white then #E0E0E0
      (cursor             "#DB0600")
      (border             "#0000FF")
      (fringe             "#121212")
      (modeline           "#292929")
      (warning            "#FF0000")
      (region-bg          "#00077A")
      (region-fg          "#BEBEBE")

      (xcode/lightblue       "#4C99EB")
      (xcode/blue            "#1492FF")
      (xcode/orange          "#FF6805")
      (xcode/yellow          "#EBD900")
      (xcode/green           "#00FF15")
      (xcode/turqois         "#00FFC0")
      (xcode/magenta         "#FF47F3")
      )

  (custom-theme-set-faces
   'xcode-dark

   `(default                      ((,class (:background ,BG :foreground ,FG))))
   `(background-mode              ((,class (light))))
   `(cursor                       ((,class (:background ,cursor))))
   `(border                       ((,class (:foreground ,border))))
   `(fringe                       ((,class (:background ,fringe))))
   `(minibuffer-prompt            ((,class (:forground "cyan"))))
   `(mode-line                    ((,class (:inherit foreground :background ,modeline))))
;;   `(region                       ((,class (:background ,region))))
   `(region                        ((,class (:background ,region-bg
                                             :foreground ,region-fg))))


   `(font-lock-builtin-face       ((,class (:foreground ,xcode/lightblue))))
   `(font-lock-comment-face       ((,class (:foreground ,xcode/orange))))
   ;; `(font-lock-constant-face ((,class (:foreground "#d315c3"))))
   `(font-lock-function-name-face ((,class (:foreground ,xcode/yellow))))
   `(font-lock-keyword-face       ((,class (:foreground ,xcode/green))))
   `(font-lock-string-face        ((,class (:foreground ,xcode/turqois))))
   `(font-lock-type-face          ((,class (:foreground ,xcode/magenta))))
   `(font-lock-variable-name-face ((,class (:foreground ,xcode/blue))))
   `(font-lock-warning-face       ((,class (:foreground ,warning :bold t))))))

(provide-theme 'xcode-dark)
