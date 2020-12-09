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
      (region             "#191970")
      (warning            "#FF0000")

      (ido-subdir         "#FF0000")
      (ido-only-match     "#228B22")

      (cm/builtin         "#6B8E23")
      (cm/olivedrab       "#DAB98F")
      (cm/grey50          "#7F7F7F")
      (cm/DarkGoldenrod3  "#CD950C")
      (cm/Red             "#FF0000")
      (cm/Yellow          "#FFFF00")
      (cm/DarkGreen       "#006400")
      )

  (custom-theme-set-faces
   'muratori

   `(default                      ((,class (:background ,BG :foreground ,FG))))
   `(cursor                       ((,class (:background ,cursor))))
   `(border                       ((,class (:foreground ,border))))
   `(fringe                       ((,class (:background ,fringe))))
   `(minibuffer-prompt            ((,class (:foreground ,minibuffer))))
   `(mode-line                    ((,class (:background ,modeline-bg :foreground ,modeline-fg))))
   `(region                       ((,class (:background ,region :foreground ,FG))))

   `(font-lock-builtin-face       ((,class (:foreground ,cm/builtin))))
   `(font-lock-comment-face       ((,class (:foreground ,cm/grey50))))
   `(font-lock-constant-face      ((,class (:foreground ,cm/olivedrab))))
   `(font-lock-doc-face           ((,class (:foreground ,cm/grey50))))
   `(font-lock-function-name-face ((,class (:foreground ,FG))))
   `(font-lock-keyword-face       ((,class (:foreground ,cm/DarkGoldenrod3))))
   `(font-lock-string-face        ((,class (:foreground ,cm/olivedrab))))
   `(font-lock-type-face          ((,class (:foreground ,FG))))
   `(font-lock-variable-name-face ((,class (:foreground ,FG))))
   `(font-lock-warning-face       ((,class (:foreground ,warning :bold t))))

   `(ido-subdir                   ((,class (:foreground ,ido-subdir))))
   `(ido-only-match               ((,class (:foreground ,ido-only-match))))))

(provide-theme 'muratori)
