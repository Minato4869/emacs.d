(deftheme muratori
  "Theme based on Casey Muratori's emacs setup")

(let ((class '((class color) (min-colors 89)))
      (BG                 "#161616")
      (FG                 "#CDAA7D") ;; burlywood3
      (cursor             "#40FF40")
      (border             "#0000FF")
      (fringe             "#1A1A1A")
      (modeline-bg        "#BFBFBF")
      (modeline-fg        "#000000")
      (minibuffer         "#00FFFF")
      (region-bg          "#191970")
      (region-fg          "#161616")

      (ido-subdir         "#FF0000")
      (ido-only-match     "#228B22")

      (cm/doc             "#7F7F7F")

      (cm/builtin         "#DAB98F")
      (cm/comment         "#7F7F7F")
      (cm/constant        "#6B8E23")
      (cm/function        "#CDAA7D")
      (cm/keyword         "#CD950C")
      (cm/string          "#6B8E23")
      (cm/type            "#CDAA7D")
      (cm/variable        "#CDAA7D")
      (cm/DarkGreen       "#006400"))

  (custom-theme-set-faces
   'muratori

   `(default                      ((,class (:background ,BG :foreground ,FG))))
   `(cursor                       ((,class (:background ,cursor))))
   `(border                       ((,class (:foreground ,border))))
   `(fringe                       ((,class (:background ,fringe))))
   `(minibuffer-prompt            ((,class (:foreground ,minibuffer))))
;;   `(mode-line                    ((,class (:background ,modeline-bg :foreground ,modeline-fg))))
   `(region                       ((,class (:background ,region-bg :foreground ,region-fg))))

   `(font-lock-builtin-face       ((,class (:foreground ,cm/builtin))))
   `(font-lock-comment-face       ((,class (:foreground ,cm/comment))))
   `(font-lock-constant-face      ((,class (:foreground ,cm/constant))))
   `(font-lock-function-name-face ((,class (:foreground ,cm/function))))
   `(font-lock-keyword-face       ((,class (:foreground ,cm/keyword))))
   `(font-lock-string-face        ((,class (:foreground ,cm/string))))
   `(font-lock-type-face          ((,class (:foreground ,cm/type))))
   `(font-lock-variable-name-face ((,class (:foreground ,cm/variable))))

   `(font-lock-doc-face           ((,class (:foreground ,cm/doc))))

   `(ido-subdir                   ((,class (:foreground ,ido-subdir))))
   `(ido-only-match               ((,class (:foreground ,ido-only-match))))))

(provide-theme 'muratori)
