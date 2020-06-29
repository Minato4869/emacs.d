(deftheme subl-dark
  "subl-dark theme")

(custom-theme-set-faces
 'subl-dark

 '(default ((t (:background "#050505" :foreground "#bebebe"))))
 '(mouse ((t (:foreground "red"))))
 '(cursor ((t (:background "#ff0000"))))
 '(border ((t (:foreground "blue"))))
 '(fringe ((t (:background "#111111"))))
 '(mode-line ((t (:inherit foreground :background "#292929" ))))
 '(region ((t (:background "#114488" :foreground "#bebebe"))))

 '(font-lock-builtin-face ((t (:foreground "#f92627"))))
 '(font-lock-comment-face ((t (:foreground "#17f018"))))
 '(font-lock-constant-face ((t (:foreground "#ae81ff"))))
 '(font-lock-function-name-face ((t (:foreground "#a6e22e"))))
 '(font-lock-keyword-face ((t (:foreground "#f92627"))))
 '(font-lock-string-face ((t (:foreground "#e6db74"))))
 '(font-lock-type-face ((t (:foreground "#66d9ef"))))
 '(font-lock-variable-name-face ((t (:foreground "#fd971f"))))
 '(font-lock-warning-face ((t (:foreground "Red" :bold t))))

 '(minibuffer-prompt ((t (:inherit foreground :bold t))))
 '(linum ((t (:foreground "#585858" :underline nil))))
 '(line-number ((t (:foreground "#585858" :underline nil))))

 '(ido-subdir ((t (:foreground "#a1c659"))))
 '(ido-only-match ((t (:foreground "#ffcc33")))))

(provide-theme 'subl-dark)
