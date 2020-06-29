(deftheme default-light
  "default-light theme")

(custom-theme-set-faces
 'default-light

 '(default ((t (:background "white" :foreground "black"))))
 '(cursor ((t (:background "red"))))
 '(border ((t (:foreground "blue"))))
 '(fringe ((t (:background "grey95"))))
 '(mode-line ((t (:foreground "black" :background "grey75" ))))
 '(region ((t (:foreground "black" :background "lightgoldenrod2"))))

 '(font-lock-builtin-face ((t (:foreground "dark slate blue"))))
 '(font-lock-comment-face ((t (:foreground "Firebrick"))))
 '(font-lock-constant-face ((t (:foreground "dark cyan"))))
 '(font-lock-function-name-face ((t (:foreground "Blue1"))))
 '(font-lock-keyword-face ((t (:foreground "Purple"))))
 '(font-lock-string-face ((t (:foreground "VioletRed4"))))
 '(font-lock-type-face ((t (:foreground "ForestGreen"))))
 '(font-lock-variable-name-face ((t (:foreground "sienna"))))
 '(font-lock-warning-face ((t (:foreground "Red" :bold t))))

 '(ido-subdir ((t (:foreground "green" :bold t))))
 '(ido-only-match ((t (:foreground "orange" :bold t)))))

(provide-theme 'default-light)
