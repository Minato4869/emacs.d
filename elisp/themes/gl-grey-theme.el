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
   `(region                       ((,class (:background ,region-bg :foreground ,FG))))))


(provide-theme 'gl-grey)
