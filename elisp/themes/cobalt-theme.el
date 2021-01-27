(deftheme cobalt
  "cobalt theme")

(let ((class '((class color) (min-colors 89)))
      (BG                 "#001B33")
      (FG                 "#D8D8D8")
      (cursor             "#FFFFFF") ;; was #FF0000
      (border             "#203F6A")
      (fringe             "#000D1a")
      (modeline           "#292929")
      (region-bg          "#423C38")
      (region-fg          "#D8D8D8D")

      (ido-subdir         "#0080FA")
      (ido-only-match     "#FFCC33")

      (cb/builtin         "#EF851F")
      (cb/comment         "#0080FA")
      (cb/constant        "#D318C3") ;; was commented
      (cb/function        "#CCCCCC")
      (cb/keyword         "#FF9D00")
      (cb/string          "#03D100")
      (cb/type            "#80FFBB")
      (cb/variable        "#EEEEEC"))

  (custom-theme-set-faces
   'cobalt

   `(default                      ((,class (:background ,BG :foreground ,FG))))
   `(cursor                       ((,class (:background ,cursor))))
   `(border                       ((,class (:foreground ,border))))
   `(fringe                       ((,class (:background ,fringe))))
   `(minibuffer-prompt            ((,class (:inherit forground :bold t))))
   `(mode-line                    ((,class (:background ,modeline :inherit foreground))))
   `(region                       ((,class (:background ,region-bg :foreground ,region-fg))))

   `(font-lock-builtin-face       ((,class (:foreground ,cb/builtin))))
   `(font-lock-comment-face       ((,class (:foreground ,cb/comment))))
   `(font-lock-constant-face      ((,class (:foreground ,cb/constant)))) ;; was commented
   `(font-lock-function-name-face ((,class (:foreground ,cb/function))))
   `(font-lock-keyword-face       ((,class (:foreground ,cb/keyword))))
   `(font-lock-string-face        ((,class (:foreground ,cb/string))))
   `(font-lock-type-face          ((,class (:foreground ,cb/type))))
   `(font-lock-variable-name-face ((,class (:foreground ,cb/variable))))

   `(ido-subdir                   ((,class (:foreground ,ido-subdir))))
   `(ido-only-match               ((,class (:foreground ,ido-only-match))))))

(provide-theme 'cobalt)
