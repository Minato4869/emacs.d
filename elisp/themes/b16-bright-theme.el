(deftheme b16-bright
  "b16-bright theme")

(let ((class '((class color) (min-colors 89)))
      (BG                 "#000000")
      (FG                 "#BEBEBE")
      (cursor             "#DB0600") ;; was #FF0000
      (border             "#0000FF")
      (fringe             "#121212")
      (modeline           "#292929")
      (region-bg          "#00077A")
      (region-fg          "#BEBEBE")

      (ido-subdir          "#A1C659")
      (ido-only-match      "#FFCC33")

      (b16b/builtin        "#6FB3D2")
      (b16b/comment        "#76C7B7")
      (b16b/constant       "#D315C3") ;; was commented
      (b16b/function       "#00FFFF")
      (b16b/keyword        "#FB0120")
      (b16b/string         "#D318C3")
      (b16b/type           "#A1C659")
      (b16b/variable       "#FDA331"))

  (custom-theme-set-faces
   'b16-bright

   `(default                      ((,class (:background ,BG :foreground ,FG))))
   `(cursor                       ((,class (:background ,cursor))))
   `(border                       ((,class (:foreground ,border))))
   `(fringe                       ((,class (:background ,fringe))))
   `(minibuffer-prompt            ((,class (:inherit forground :bold t))))
   `(mode-line                    ((,class (:background ,modeline :inherit foreground))))
   `(region                       ((,class (:background ,region-bg :foreground ,region-fg))))

   `(font-lock-builtin-face       ((,class (:foreground ,b16b/builtin))))
   `(font-lock-comment-face       ((,class (:foreground ,b16b/comment))))
   `(font-lock-constant-face      ((,class (:foreground ,b16b/constant)))) ;; was commented
   `(font-lock-function-name-face ((,class (:foreground ,b16b/function))))
   `(font-lock-keyword-face       ((,class (:foreground ,b16b/keyword))))
   `(font-lock-string-face        ((,class (:foreground ,b16b/string))))
   `(font-lock-type-face          ((,class (:foreground ,b16b/type))))
   `(font-lock-variable-name-face ((,class (:foreground ,b16b/variable))))

   `(ido-subdir                   ((,class (:foreground ,ido-subdir))))
   `(ido-only-match               ((,class (:foreground ,ido-only-match))))))

(provide-theme 'b16-bright)
