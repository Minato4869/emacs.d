(deftheme default-dark
  "default-dark theme")

(let ((class '((class color) (min-colors 89)))
      (BG)
      (FG)
      (cursor             "#DB0600") ;; was #FF0000
      (border             "#0000FF")
      (fringe             "#1A1A1A")
;;      (modeline           "")
      (region-bg          "#0000cd")
;;      (region-fg          "")

      (ido-subdir         "#FF0000")
      (ido-only-match     "##228B22")

      (dt/builtin         "#B0C4DE")
      (dt/comment         "#FF7F24")
      (dt/constant        "#7FFFD4")
      (dt/function        "#87CEFA")
      (dt/keyword         "#1E90FF") ;; was #00ffff
      (dt/string          "#FFA07A")
      (dt/type            "#98FB98")
      (dt/variable        "#EEDD82"))

  (if (display-graphic-p)
      (setq BG "#000000"
            FG "#BEBEBE")
    (setq BG "unspecified-bg"
          FG "unspecified-fg"))

  (custom-theme-set-faces
   'default-dark

   `(default                      ((,class (:background ,BG :foreground ,FG))))
   `(cursor                       ((,class (:background ,cursor))))
   `(border                       ((,class (:foreground ,border))))
   `(fringe                       ((,class (:background ,fringe))))
   `(minibuffer-prompt            ((,class (:inherit forground :bold t))))
;;   `(mode-line                    ((,class (:background ,modeline :inherit foreground))))
   ;;   `(region                       ((,class (:background ,region-bg :foreground ,FG))))
   `(region                       ((,class (:background ,region-bg :inherit foreground))))

   `(font-lock-builtin-face       ((,class (:foreground ,dt/builtin))))
   `(font-lock-comment-face       ((,class (:foreground ,dt/comment))))
   `(font-lock-constant-face      ((,class (:foreground ,dt/constant))))
   `(font-lock-function-name-face ((,class (:foreground ,dt/function))))
   `(font-lock-keyword-face       ((,class (:foreground ,dt/keyword))))
   `(font-lock-string-face        ((,class (:foreground ,dt/string))))
   `(font-lock-type-face          ((,class (:foreground ,dt/type))))
   `(font-lock-variable-name-face ((,class (:foreground ,dt/variable))))

   `(ido-subdir                   ((,class (:foreground ,ido-subdir))))
   `(ido-only-match               ((,class (:foreground ,ido-only-match))))))

(provide-theme 'default-dark)
