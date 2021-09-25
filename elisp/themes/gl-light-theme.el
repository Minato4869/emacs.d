(deftheme gl-light
  "gl-light theme")

(let  ((BG                                  "#FFFFFF")
       (FG                                  "#000000")
       (cursor                              "#DB0600") ;; was ff0000
       (border                              "#0000FF")
       (fringe                              "#EDEDED")
       (mode-line-bg                        "#d6d6d6")

       (mode-line-inactive-fg               "#CCCCCC")
       (mode-line-inactive-bg               "#4D4D4D")
       (mode-line-inactive-box              "#666666")

       (region-bg                           "#114488")
       (region-fg                           "#FFFFFF")

       (ido-subdir                          "#A1C659")
       (ido-only-match                      "#FFCC33")

       (font-lock-builtin-face              "#75507B")
       (font-lock-comment-delimiter-face    "#CC0000")
       (font-lock-comment-face              "#CC0000")
       (font-lock-constant-face             "#4E9A06")
       (font-lock-doc-face                  "#4E9A06")
       (font-lock-function-name-face        "#75507B")
       (font-lock-keyword-face              "#729FCF")
       (font-lock-negation-char-face        "#BEBEBE")
       (font-lock-preprocessor-face         "#75507B")
       (font-lock-regexp-grouping-backslash "#BEBEBE")
       (font-lock-regexp-grouping-construct "#BEBEBE")
       (font-lock-string-face               "#4E9A06")
       (font-lock-type-face                 "#4E9A06")
       (font-lock-variable-name-face        "#C4A000")
       (font-lock-warning-face              "#FF0000")

       (sh-quoted-exec                      "#FA8072")
       (sh-heredoc                          "#FFFF00")
       (completions-common-part             "#ADD8E6")

       (org-level-1                         "#75507B")
       (org-level-2                         "#C4A000")
       (org-level-3                         "#729FCF")
       (org-level-4                         "#CC0000")
       (org-level-5                         "#4E9A06")
       (org-date                            "#2C78BF") ;; was cyan
       (org-todo                            "#D70000")
       (org-done                            "#228B22")
       (org-headline-done                   "#FFA07A")
       (org-meta-line                       "#CC0000")
       )
  (custom-theme-set-faces
   'gl-light

   `(default                             ((((type tty)) (:background "unspecified-bg" :foreground "unspecified-fg"))
                                          (t            (:background ,BG :foreground ,FG))))
   `(cursor                              ((t (:background ,cursor))))
   `(border                              ((t (:foreground ,border))))
   `(fringe                              ((t (:background ,fringe))))
   `(minibuffer-prompt                   ((t (:inherit foreground :bold t))))
   `(mode-line                           ((t (:background ,mode-line-bg :inherit foreground))))
   `(mode-line-inactive                  ((t (:background ,mode-line-inactive-bg :foreground ,mode-line-inactive-fg
                                                          :box (:line-width -1 :color ,mode-line-inactive-box :style nil)))))
   `(region                              ((t (:background ,region-bg :foreground ,region-fg))))

   `(font-lock-builtin-face              ((t (:foreground ,font-lock-builtin-face))))
   `(font-lock-comment-delimiter-face    ((t (:foreground ,font-lock-comment-delimiter-face))))
   `(font-lock-comment-face              ((t (:foreground ,font-lock-comment-face))))
   `(font-lock-constant-face             ((t (:foreground ,font-lock-constant-face))))
   `(font-lock-doc-face                  ((t (:foreground ,font-lock-doc-face))))
   `(font-lock-function-name-face        ((t (:foreground ,font-lock-function-name-face))))
   `(font-lock-keyword-face              ((t (:foreground ,font-lock-keyword-face))))
   `(font-lock-negation-char-face        ((t (:foreground ,font-lock-negation-char-face))))
   `(font-lock-preprocessor-face         ((t (:foreground ,font-lock-preprocessor-face))))
   `(font-lock-regexp-grouping-backslash ((t (:foreground ,font-lock-regexp-grouping-backslash :bold t))))
   `(font-lock-regexp-grouping-construct ((t (:foreground ,font-lock-regexp-grouping-construct :bold t))))
   `(font-lock-string-face               ((t (:foreground ,font-lock-string-face))))
   `(font-lock-type-face                 ((t (:foreground ,font-lock-type-face))))
   `(font-lock-variable-name-face        ((t (:foreground ,font-lock-variable-name-face))))
   `(font-lock-warning-face              ((t (:foreground ,font-lock-warning-face :bold t))))

   `(ido-subdir                          ((t (:foreground ,ido-subdir))))
   `(ido-only-match                      ((t (:foreground ,ido-only-match))))

   `(sh-quoted-exec                      ((t (:foreground ,sh-quoted-exec))))
   `(sh-heredoc                          ((t (:foreground ,sh-heredoc :bold t))))
   `(completions-common-part             ((t (:foreground ,completions-common-part :bold t))))

   `(org-level-1                         ((t (:foreground ,org-level-1))))
   `(org-level-2                         ((t (:foreground ,org-level-2))))
   `(org-level-3                         ((t (:foreground ,org-level-3))))
   `(org-level-4                         ((t (:foreground ,org-level-4))))
   `(org-level-5                         ((t (:foreground ,org-level-5))))
   `(org-date                            ((t (:foreground ,org-date))))
   `(org-todo                            ((t (:foreground ,org-todo :bold t))))
   `(org-done                            ((t (:foreground ,org-done :bold t))))
   `(org-headline-done                   ((t (:foreground ,org-headline-done))))
   `(org-meta-line                       ((t (:foreground ,org-meta-line))))
   `(org-block-begin-line                ((t (:inherit org-meta-line))))
   `(org-block-end-line                  ((t (:inherit org-meta-line))))
   ))
(provide-theme 'gl-light)
