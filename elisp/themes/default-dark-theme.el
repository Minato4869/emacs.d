(deftheme default-dark
  "default-dark theme")

(custom-theme-set-faces
 'default-dark

 '(default ((t (:background "black" :foreground "grey"))))
 '(cursor ((t (:background "red"))))
 '(border ((t (:foreground "blue"))))
 '(fringe ((t (:background "grey10"))))
 '(mode-line ((t (:foreground "black" :background "grey75"
                              :box (:line-width -1 :style released-button)))))
 '(region ((t (:foreground "black" :background "blue3"))))

 '(font-lock-builtin-face ((t (:foreground "LightSteelBlue"))))
 '(font-lock-comment-face ((t (:foreground "chocolate1"))))
 '(font-lock-constant-face ((t (:foreground "Aquamarine"))))
 '(font-lock-function-name-face ((t (:foreground "LightSkyBlue"))))
 '(font-lock-keyword-face ((t (:foreground "Cyan1"))))
 '(font-lock-string-face ((t (:foreground "LightSalmon"))))
 '(font-lock-type-face ((t (:foreground "PaleGreen"))))
 '(font-lock-variable-name-face ((t (:foreground "LightGoldenrod"))))
 '(font-lock-warning-face ((t (:foreground "Red" :bold t)))))

(provide-theme 'default-dark)
