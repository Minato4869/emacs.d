(deftheme naysayer-grey
  "naysayer-grey theme")

(let ((class '((class color) (min-colors 89)))
      (BG                 "#272727") ;; was #041818
      (FG                 "#D3B58D")
      (cursor             "#8FEE90")
      (border             "#0000FF")
      (fringe             "#050404")
      (modeline           "")
      (minibuffer         "#00FFFF")
      (region-bg          "#0000FF")
      (region-fg          "#BEBEBE")

      (ido-subdir          "#A1C659")
      (ido-only-match      "#FFCC33")

      (nay/builtin         "#8FEE90")
      (nay/comment         "#FFFF00")
      ;; (nay/constant        "")
      (nay/function        "#FFFFFF")
      (nay/keyword         "#FFFFFF")
      (nay/string          "#C8D4EC")
      (nay/type            "#98FB98")
      (nay/variable        "#FFFFFF")

      (nay/highlight-bg    "#B4EEEB4")
      (nay/highlight-fg    "#0000080")

      (nay/warning         "#0000080"))

  (custom-theme-set-faces
   'naysayer-grey

   `(default                      ((,class (:background ,BG :foreground ,FG))))
   `(cursor                       ((,class (:background ,cursor))))
   `(border                       ((,class (:foreground ,border))))
   `(fringe                       ((,class (:background ,fringe))))
   `(minibuffer-prompt             ((,class (:foreground ,minibuffer))))
   `(minibuffer-prompt            ((,class (:inherit forground :bold t))))
   `(mode-line                    ((,class (:inverse-video t))))
   ;; `(region                        ((,class (:background ,region-bg
   ;;                                           :foreground ,region-fg))))
   `(region                       ((,class (:background ,region-bg :inherit foreground))))

   `(font-lock-builtin-face       ((,class (:foreground ,nay/builtin))))
   `(font-lock-comment-face       ((,class (:foreground ,nay/comment))))
   ;;`(font-lock-constant-face      ((,class (:foreground ,nay/constant))))
   `(font-lock-function-name-face ((,class (:foreground ,nay/function))))
   `(font-lock-keyword-face       ((,class (:foreground ,nay/keyword))))
   `(font-lock-string-face        ((,class (:foreground ,nay/string))))
   `(font-lock-type-face          ((,class (:foreground ,nay/type))))
   `(font-lock-variable-name-face ((,class (:foreground ,nay/variable))))
   `(highlight                    ((,class (:foreground ,nay/highlight-fg
                                                         :background ,nay/highlight-bg))))
   ;; `(font-lock-warning-face        ((,class (:foreground ,nay/warning ))))

   `(ido-subdir                   ((,class (:foreground ,ido-subdir))))
   `(ido-only-match               ((,class (:foreground ,ido-only-match))))
   ))


(provide-theme 'naysayer-grey)
