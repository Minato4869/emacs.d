(deftheme gl-grey
  "gl-grey theme")

(let ((class '((class color) (min-colors 89)))
      (BG                 "#292b2e")
      (FG                 "#b2b2b2")
      (cursor             "#e3dedd")
      (border             "#5d4d7a")
      (fringe             "#4b4e4f")
      (modeline-fg        "#b2b2b2")
      (modeline-fgid      "#bc6ec5")
      (modeline-bg        "#222226")
      (modeline-bgi       "#292b2e")
      (modeline-box       "#5d4d7a")
      (region-bg          "#444155")
      (region-fg          "#b2b2b2")

      (ido-subdir          "#A1C659")
      (ido-only-match      "#FFCC33")

      (glg/builtin         "#839496")
      (glg/comment         "#93a1a1")
      (glg/constant        "#268bd2")
      (glg/function        "#268bd2")
      (glg/keyword         "#859900")
      (glg/string          "#2aa198")
      (glg/type            "#b58900")
      (glg/variable        "#268bd2"))

  (custom-theme-set-faces
   'gl-grey

   `(default                      ((,class (:background ,BG :foreground ,FG))))
   `(cursor                       ((,class (:background ,cursor))))
   `(border                       ((,class (:foreground ,border))))
   `(fringe                       ((,class (:background ,fringe))))
   `(minibuffer-prompt            ((,class (:inherit forground :bold t))))
   `(mode-line                    ((,class (:foreground ,modeline-fg :background ,modeline-bg))))
   `(mode-line-buffer-id          ((,class (:inherit bold :foreground ,modeline-fgid))))
   `(mode-line-inactive           ((,class (:foreground ,modeline-fg :background ,modeline-bgi))))
   `(region                       ((,class (:background ,region-bg :foreground ,FG))))

   `(font-lock-builtin-face       ((,class (:foreground ,glg/builtin))))
   `(font-lock-comment-face       ((,class (:foreground ,glg/comment))))
   `(font-lock-constant-face      ((,class (:foreground ,glg/constant))))
   `(font-lock-function-name-face ((,class (:foreground ,glg/function))))
   `(font-lock-keyword-face       ((,class (:foreground ,glg/keyword))))
   `(font-lock-string-face        ((,class (:foreground ,glg/string))))
   `(font-lock-type-face          ((,class (:foreground ,glg/type))))
   `(font-lock-variable-name-face ((,class (:foreground ,glg/variable))))

   `(ido-subdir                   ((,class (:foreground ,ido-subdir))))
   `(ido-only-match               ((,class (:foreground ,ido-only-match))))))

(provide-theme 'gl-grey)
