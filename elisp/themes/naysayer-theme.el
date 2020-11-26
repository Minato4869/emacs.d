(deftheme naysayer
  "naysayer theme")

(let ((class '((class color) (min-colors 89)))
      (BG                 "#072626")
      (FG                 "#D3B58D")
      (cursor             "#8FEE90")
      (border             "#0000FF")
      (fringe             "#050404")
      (modeline           "#292929")
      (region-bg          "#0000FF")
      (region-fg          "#BEBEBE")
      (warning            "#FF0000")

      (ido-green          "#A1C659")
      (ido-yellow         "#FFCC33")

      (nay-lightgreen     "#8FEE90")
      (nay-lightgreen-hl  "#B4EEB4")
      (nay-palegreen      "#98FB98")
      (nay-green          "#3FDF1F")
      (nay-green-string   "#3FDF1F")
      (nay-white          "#FFFFFF") ;; was #BEBEBE, white is default
      (nay-lightblue      "#C8D4EC")
      (nay-brown          "#504038")
      (nay-navyblue       "#000080"))

  (custom-theme-set-faces
   'naysayer

   `(default                       ((,class (:background ,BG :foreground ,FG))))
   `(cursor                        ((,class (:background ,cursor))))
   `(border                        ((,class (:foreground ,border))))
   `(fringe                        ((,class (:background ,fringe))))
   `(mode-line                     ((,class (:inverse-video t))))
   ;;   `(region                        ((,class (:background ,region-bg))))
   `(region                        ((,class (:background ,region-bg
                                             :foreground ,region-fg))))

   `(font-lock-builtin-face        ((,class (:foreground ,nay-lightgreen))))
   `(font-lock-comment-face        ((,class (:foreground ,nay-green))))
   `(font-lock-type-face           ((,class (:foreground ,nay-palegreen))))
   `(font-lock-function-name-face  ((((class color) (background dark)) (:foreground ,nay-white))))
   `(font-lock-keyword-face        ((,class (:foreground ,nay-white))))
   `(font-lock-string-face         ((,class (:foreground ,nay-green-string))))
   `(font-lock-variable-name-face  ((((class color) (background dark)) (:foreground ,nay-lightblue))))
   `(font-lock-warning-face        ((,class (:foreground ,nay-brown ))))
   `(highlight                     ((,class (:foreground ,nay-navyblue
                                                         :background ,nay-lightgreen-hl))))
   `(ido-subdir                   ((,class (:foreground ,ido-green))))
   `(ido-only-match               ((,class (:foreground ,ido-yellow))))))

(provide-theme 'naysayer)
