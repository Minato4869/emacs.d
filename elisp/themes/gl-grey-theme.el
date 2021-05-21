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
      (region-fg                        "#E5E5E5"))

  (setq global-font-lock-mode nil)
  (custom-theme-set-faces
   'gl-grey

   `(default                      ((,class (:background ,BG :foreground ,FG))))
   `(cursor                       ((,class (:background ,cursor))))
   `(border                       ((,class (:foreground ,border))))
   `(fringe                       ((,class (:background ,fringe))))
   `(minibuffer-prompt            ((,class (:inherit foreground :bold t))))
   `(region                       ((,class (:background ,region-bg :foreground ,FG))))

   `(font-lock-builtin-face       ((,class (:inherit foreground))))
   `(font-lock-comment-face       ((,class (:inherit foreground))))
   `(font-lock-constant-face      ((,class (:inherit foreground))))
   `(font-lock-function-name-face ((,class (:inherit foreground))))
   `(font-lock-keyword-face       ((,class (:inherit foreground))))
   `(font-lock-string-face        ((,class (:inherit foreground))))
   `(font-lock-type-face          ((,class (:inherit foreground))))
   `(font-lock-variable-name-face ((,class (:inherit foreground))))

   `(org-level-2                  ((,class (:inherit foreground))))
   `(org-level-3                  ((,class (:inherit foreground))))
   `(org-level-4                  ((,class (:inherit foreground))))
   `(org-level-5                  ((,class (:inherit foreground))))))

(provide-theme 'gl-grey)
