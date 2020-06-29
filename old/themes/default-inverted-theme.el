(deftheme default-inverted
  "default-inverted theme")

(custom-theme-set-faces
 'default-inverted

 '(default ((t (:background "black" :foreground "#bebebe"))))
 '(cursor ((t (:background "red"))))
 '(border ((t (:foreground "blue"))))
 '(fringe ((t (:background "#151515"))))
 '(mode-line ((t (:inherit foreground :background "#292929" ))))
 '(region ((t (:foreground "#bebebe" :background "#114488")))) ;; #lightgoldenrod2, 11237d

 '(font-lock-builtin-face ((t (:foreground "#b7c274"))))
 '(font-lock-comment-face ((t (:foreground "#74e5e5"))))
 '(font-lock-constant-face ((t (:foreground "#ff7474"))))
 '(font-lock-function-name-face ((t (:foreground "#ff4000"))))
 '(font-lock-keyword-face ((t (:foreground "#5fdf0f"))))
 '(font-lock-string-face ((t (:foreground "#74ddad"))))
 '(font-lock-type-face ((t (:foreground "#dd74dd"))))
 '(font-lock-variable-name-face ((t (:foreground "#5fadd2"))))
 '(font-lock-warning-face ((t (:foreground "Red" :bold t))))

 '(ido-subdir ((t (:foreground "5fdf0f" :bold t))))
 '(ido-only-match ((t (:foreground "orange" :bold t))))
 )

(provide-theme 'default-inverted)
