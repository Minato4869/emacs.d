  (deftheme gl-grey
  "gl-grey theme")
;; (defun theme/display-colors ()
;;  (or (= (display-color-cells) 16777216) (display-graphic-p) (daemonp)))

(let ((class '((class color) (min-colors 89)))
      (BG  (when (theme/display-colors) "#333333"))
      (FG  (when (theme/display-colors) "#E5E5E5"))
      (cursor                           "#00FF00")
      (border                           "#FF00FF")
      (fringe                           "#1A1A1A")
      (region-bg                        "#114488")
      (region-fg                        "#E5E5E5")

      (gl/builtin                       "#E5E5E5")
      (gl/comment                       "#E5E5E5")
      (gl/constant                      "#E5E5E5")
      (gl/function                      "#E5E5E5")
      (gl/keyword                       "#E5E5E5")
      (gl/string                        "#E5E5E5")
      (gl/type                          "#E5E5E5")
      (gl/variable                      "#E5E5E5")
      (org-level-2                      "#E5E5E5")
      (org-level-3                      "#E5E5E5")
      (org-level-4                      "#E5E5E5")
      (org-level-5                      "#E5E5E5"))

  (setq global-font-lock-mode nil)
  (custom-theme-set-faces
   'gl-grey

   `(default                      ((,class (:background ,BG :foreground ,FG))))
   `(cursor                       ((,class (:background ,cursor))))
   `(border                       ((,class (:foreground ,border))))
   `(fringe                       ((,class (:background ,fringe))))
   `(minibuffer-prompt            ((,class (:inherit foreground :bold t))))
   `(region                       ((,class (:background ,region-bg :foreground ,FG))))

   `(font-lock-builtin-face       ((,class (:foreground ,gl/builtin))))
   `(font-lock-comment-face       ((,class (:foreground ,gl/comment))))
   `(font-lock-constant-face      ((,class (:foreground ,gl/constant))))
   `(font-lock-function-name-face ((,class (:foreground ,gl/function))))
   `(font-lock-keyword-face       ((,class (:foreground ,gl/keyword))))
   `(font-lock-string-face        ((,class (:foreground ,gl/string))))
   `(font-lock-type-face          ((,class (:foreground ,gl/type))))
   `(font-lock-variable-name-face ((,class (:foreground ,gl/variable))))

   `(org-level-2                  ((,class (:foreground ,org-level-2))))
   `(org-level-3                  ((,class (:foreground ,org-level-3))))
   `(org-level-4                  ((,class (:foreground ,org-level-4))))
   `(org-level-5                  ((,class (:foreground ,org-level-5))))))

(provide-theme 'gl-grey)
