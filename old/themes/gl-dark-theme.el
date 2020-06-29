(deftheme gl-dark
  "gl-dark theme")

(custom-theme-set-faces
 'gl-dark

 '(default ((t (:background "black" :foreground "#bebebe"))))
 '(cursor ((t (:background "#ff0000"))))
 '(border ((t (:foreground "blue"))))
 '(fringe ((t (:background "#121212"))))
 '(mode-line ((t (:inherit foreground :background "#292929" ))))
 '(region ((t (:foreground "#bebebe" :background "#114488"))))

 '(font-lock-builtin-face ((t (:foreground "#75507b"))))
 '(font-lock-comment-face ((t (:foreground "#cc0000"))))
 '(font-lock-constant-face ((t (:foreground "#4e9a06"))))
 '(font-lock-function-name-face ((t (:foreground "#75507b"))))
 '(font-lock-keyword-face ((t (:foreground "#729fcf"))))
 '(font-lock-string-face ((t (:foreground "#4e9a06"))))
 '(font-lock-type-face ((t (:foreground "#4e9a06"))))
 '(font-lock-variable-name-face ((t (:foreground "#c4a000"))))
 '(font-lock-warning-face ((t (:foreground "Red" :bold t))))

 '(ido-subdir ((t (:foreground "#a1c659"))))
 '(ido-only-match ((t (:foreground "#ffcc33"))))
 )

(provide-theme 'gl-dark)
