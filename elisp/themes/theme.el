(deftheme <themename>
  "<themename> theme")

(let ((class '((class color) (min-colors 89)))
      (BG                 "#000000")
      (FG                 "#BEBEBE")
      (cursor             "#DB0600") ;; was #FF0000
      (border             "#0000FF")
      (fringe             "#121212")
      (modeline           "#292929")
      (region             "#114488")

      (ido-subdir          "#A1C659")
      (ido-only-match      "#FFCC33")

      (<theme>/builtin         "#75507B")
      (<theme>/comment         "#CC0000")
      (<theme>/constant        "#4E9A06")
      (<theme>/function        "#75507B")
      (<theme>/keyword         "#729FCF")
      (<theme>/string          "#4E9A06")
      (<theme>/type            "#4E9A06")
      (<theme>/variable        "#C4A000"))

  (custom-theme-set-faces
   '<themename>

   `(default                      ((,class (:background ,BG :foreground ,FG))))
   `(cursor                       ((,class (:background ,cursor))))
   `(border                       ((,class (:foreground ,border))))
   `(fringe                       ((,class (:background ,fringe))))
   `(minibuffer-prompt            ((,class (:inherit forground :bold t))))
   `(mode-line                    ((,class (:background ,modeline :inherit foreground))))
   `(region                       ((,class (:background ,region :foreground ,FG))))

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
