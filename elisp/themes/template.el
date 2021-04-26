(deftheme <themename>
  "<themename> theme")
;; (defun theme/display-colors ()
;;  (or (= (display-color-cells) 16777216) (display-graphic-p) (daemonp)))

(let ((class '((class color) (min-colors 89)))
      (BG  (when (theme/display-colors) ""))
      (FG  (when (theme/display-colors) ""))
      (FG                               "")
      (cursor                           "")
      (border                           "")
      (fringe                           "")
      (modeline                         "")
      (region-bg                        "")
      (region-fg                        "")

      (ido-subdir                       "")
      (ido-only-match                   "")

      (<theme>/builtin                  "")
      (<theme>/comment                  "")
      (<theme>/constant                 "")
      (<theme>/function                 "")
      (<theme>/keyword                  "")
      (<theme>/string                   "")
      (<theme>/type                     "")
      (<theme>/variable                 ""))

  (custom-theme-set-faces
   '<themename>

   `(default                      ((,class (:background ,BG :foreground ,FG))))
   `(cursor                       ((,class (:background ,cursor))))
   `(border                       ((,class (:foreground ,border))))
   `(fringe                       ((,class (:background ,fringe))))
   `(minibuffer-prompt            ((,class (:inherit foreground :bold t))))
   `(mode-line                    ((,class (:background ,modeline :inherit foreground))))
   `(region                       ((,class (:background ,region-bg :foreground ,FG))))

   `(font-lock-builtin-face       ((,class (:foreground ,<theme>/builtin))))
   `(font-lock-comment-face       ((,class (:foreground ,<theme>/comment))))
   `(font-lock-constant-face      ((,class (:foreground ,<theme>/constant))))
   `(font-lock-function-name-face ((,class (:foreground ,<theme>/function))))
   `(font-lock-keyword-face       ((,class (:foreground ,<theme>/keyword))))
   `(font-lock-string-face        ((,class (:foreground ,<theme>/string))))
   `(font-lock-type-face          ((,class (:foreground ,<theme>/type))))
   `(font-lock-variable-name-face ((,class (:foreground ,<theme>/variable))))

   `(ido-subdir                   ((,class (:foreground ,ido-subdir))))
   `(ido-only-match               ((,class (:foreground ,ido-only-match))))))

(provide-theme '<themename>)
