(deftheme gl-grey
  "gl-grey theme")

(let  ((BG                                  "#333333")
       (FG                                  "#BEBEBE") ;; was e5e5e5
       (cursor                              "#00FF00")
       (border                              "#0000FF")
       (fringe                              "#121212")
       (mode-line-bg                        "#292929")

       (mode-line-inactive-fg               "#CCCCCC")
       (mode-line-inactive-bg               "#4D4D4D")
       (mode-line-inactive-box              "#666666")

       (region-bg                           "#114488")
       (region-fg                           "#BEBEBE")

       (ido-subdir                          "#A1C659")
       (ido-only-match                      "#FFCC33")
       (ido-first-match                     "#BEBEBE")

       (font-lock-regexp-grouping-backslash "#BEBEBE")
       (font-lock-regexp-grouping-construct "#BEBEBE")

       (sh-quoted-exec                      "#FA8072")
       (sh-heredoc                          "#FFFF00")

       (completions-common-part             "#ADD8E6")

       (isearch-fail                        "#8B0000")

       (shadow                              "#aaaaaa")

       (org-level-1                         "#E5E5E5")
       (org-level-3                         "#888888")
       (org-level-4                         "#CC0000")
       (org-level-5                         "#4E9A06")
       (org-level-6                         "#75507B")
       (org-level-7                         "#C4A000")
       (org-level-8                         "#729FCF")
       (org-date                            "#2C78BF") ;; was cyan
       (org-todo                            "#FFC0CB")
       (org-done                            "#98FB98")
       (org-headline-done                   "#FFA07A")
       (org-meta-line                       "#CC0000")
       (org-time-grid                       "#EEDD82")
       (org-agenda-structure                "#87CEFA")
       (org-agenda-clocking                 "#4A708B")

       (font-latex-sedate-face              "#D3D3D3") ;; == lightgray; alt tui colour: 6C6C6C
       (font-latex-verbatim-face            "#DEB887") ;; == burlywood
       (tex-verbatim                        "#DEB887")
       (tex-math                            "#DEB887")
       (font-latex-math-face                "#DEB887")
       )
  (custom-theme-set-faces
   'gl-grey

   `(default                             ((((type tty)) (:background "unspecified-bg" :foreground "unspecified-fg"))
                                          (t            (:background ,BG :foreground ,FG))))
   `(cursor                              ((t (:background ,cursor))))
   `(border                              ((t (:foreground ,border))))
   `(fringe                              ((t (:background ,fringe))))
   `(minibuffer-prompt                   ((t (:inherit default :bold t))))
   `(mode-line                           ((t (:background ,mode-line-bg :inherit default))))
   `(mode-line-inactive                  ((t (:background ,mode-line-inactive-bg :foreground ,mode-line-inactive-fg
                                                          :box (:line-width -1 :color ,mode-line-inactive-box :style nil)))))
   `(region                              ((t (:background ,region-bg :foreground ,region-fg))))

   `(font-lock-builtin-face              ((t (:inherit default))))
   `(font-lock-comment-delimiter-face    ((t (:inherit default))))
   `(font-lock-comment-face              ((t (:inherit default))))
   `(font-lock-constant-face             ((t (:inherit default))))
   `(font-lock-doc-face                  ((t (:inherit default))))
   `(font-lock-function-name-face        ((t (:inherit default))))
   `(font-lock-keyword-face              ((t (:inherit default))))
   `(font-lock-negation-char-face        ((t (:inherit default))))
   `(font-lock-preprocessor-face         ((t (:inherit default))))
   `(font-lock-regexp-grouping-backslash ((t (:foreground ,font-lock-regexp-grouping-backslash :bold t))))
   `(font-lock-regexp-grouping-construct ((t (:foreground ,font-lock-regexp-grouping-construct :bold t))))
   `(font-lock-string-face               ((t (:inherit default))))
   `(font-lock-type-face                 ((t (:inherit default))))
   `(font-lock-variable-name-face        ((t (:inherit default))))
   `(font-lock-warning-face              ((t (:inherit default))))

   `(ido-subdir                          ((t (:foreground ,ido-subdir))))
   `(ido-only-match                      ((t (:foreground ,ido-only-match))))
   `(ido-first-match                     ((t (:foreground ,ido-first-match :bold t :underline t))))

   `(sh-quoted-exec                      ((t (:foreground ,sh-quoted-exec))))
   `(sh-heredoc                          ((t (:foreground ,sh-heredoc :bold t))))

   `(italic                              ((t (:inherit italic :underline nil))))

   `(completions-common-part             ((t (:foreground ,completions-common-part :bold t))))

   `(isearch-fail                        ((t (:background ,isearch-fail))))

   `(shadow                              ((t (:foreground ,shadow))))

   `(org-level-1                         ((t (:foreground ,org-level-1 :bold t))))
   `(org-level-2                         ((t (:inherit default :bold t))))
   `(org-level-3                         ((t (:foreground ,org-level-3 :bold t))))
   `(org-level-4                         ((t (:foreground ,org-level-4))))
   `(org-level-5                         ((t (:foreground ,org-level-5))))
   `(org-level-6                         ((t (:foreground ,org-level-6 :bold t))))
   `(org-level-7                         ((t (:foreground ,org-level-7 :bold t))))
   `(org-level-8                         ((t (:foreground ,org-level-8 :bold t))))
   `(org-date                            ((t (:foreground ,org-date))))
   `(org-todo                            ((((type tty)) (:foreground "brightmagenta" :bold t))
                                          (t            (:foreground ,org-todo :bold t))))
   `(org-done                            ((t (:foreground ,org-done :bold t))))
   `(org-headline-done                   ((t (:foreground ,org-headline-done))))
   `(org-meta-line                       ((t (:foreground ,org-meta-line))))
   `(org-block-begin-line                ((t (:inherit org-meta-line))))
   `(org-block-end-line                  ((t (:inherit org-meta-line))))
   `(org-time-grid                       ((t (:foreground ,org-time-grid))))
   `(org-agenda-clocking                 ((t (:inherit default :background ,org-agenda-clocking :extend t))))
   `(org-agenda-structure                ((t (:foreground ,org-agenda-structure))))
   `(org-agenda-date                     ((t (:inherit org-agenda-structure))))
   `(org-agenda-date-today               ((t (:inherit org-agenda-date :bold t :underline t))))
   `(org-agenda-date-weekend             ((t (:inherit org-agenda-date :bold t))))

   ;; == LaTeX
   `(font-latex-sedate-face              ((t (:foreground ,font-latex-sedate-face))))
   `(font-latex-verbatim-face            ((t (:foreground ,font-latex-verbatim-face))))
   `(font-latex-math-face                ((t (:foreground ,font-latex-math-face))))

   `(tex-verbatim                        ((t (:foreground ,tex-verbatim))))
   `(tex-math                            ((t (:foreground ,tex-math))))

   ))
(provide-theme 'gl-grey)
