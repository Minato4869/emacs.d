(deftheme gl-dark
  "gl-dark theme")

(let* ((BG                                  (if (gl/black-theme) "#000000" "#333333"))
       (FG                                  (if (gl/black-theme) "#BEBEBE" "#E5E5E5"))
       (cursor                              (if (gl/black-theme) "#DB0600" "#00FF00")) ;; was ff0000 for dark theme
       (border                              "#0000FF")
       (fringe                              (if (gl/black-theme) "#121212" "#1A1A1A"))
       (mode-line-bg                        "#292929")
       (mode-line-fg                        FG       )


       (mode-line-inactive-fg               "#CCCCCC")
       (mode-line-inactive-bg               "#4D4D4D")
       (mode-line-inactive-box              "#666666")

       (region-bg                           "#114488")
       (region-fg                           FG)

       (ido-subdir                          "#A1C659")
       (ido-only-match                      "#FFCC33")
       (ido-first-match                     FG)

       (font-lock-builtin-face              (if gl/colours "#75507B" FG))
       (font-lock-comment-delimiter-face    (if gl/colours "#CC0000" FG))
       (font-lock-comment-face              (if gl/colours "#CC0000" FG))
       (font-lock-constant-face             (if gl/colours "#4E9A06" FG))
       (font-lock-doc-face                  (if gl/colours "#4E9A06" FG))
       (font-lock-function-name-face        (if gl/colours "#75507B" FG))
       (font-lock-keyword-face              (if gl/colours "#729FCF" FG))
       (font-lock-negation-char-face        FG)
       (font-lock-preprocessor-face         (if gl/colours "#75507B" FG))
       (font-lock-regexp-grouping-backslash FG)
       (font-lock-regexp-grouping-construct FG)
       (font-lock-string-face               (if gl/colours "#4E9A06" FG))
       (font-lock-type-face                 (if gl/colours "#4E9A06" FG))
       (font-lock-variable-name-face        (if gl/colours "#C4A000" FG))
       (font-lock-warning-face              (if gl/colours "#FF0000" FG))
       ;; (font-lock-bold-or-underlined-face   (if gl/colours nil       t))

       (sh-quoted-exec                      (if gl/colours "#FA8072" FG))
       (sh-heredoc                          (if gl/colours "#FFFF00" FG))

       (completions-common-part             "#ADD8E6")

       (isearch-fail                        "#8B0000")

       (isearch-bg                          (if gl/colours "#EE799F" BG))
       (isearch-fg                          (if gl/colours "#8B2323" "#1E90FF"))
       (isearch-bold                        (if gl/colours nil t))

       (shadow                              "#aaaaaa")

       (org-level-1                         (if gl/colours "#75507B" FG))
       (org-level-2                         (if gl/colours "#C4A000" "#A1A1A1"))
       (org-level-3                         (if gl/colours "#729FCF" "#929292"))
       (org-level-4                         (if gl/colours "#CC0000" "#838383"))
       (org-level-5                         (if gl/colours "#4E9A06" "#838383"))
       (org-level-6                         (if gl/colours "#75507B" "#838383"))
       (org-level-7                         (if gl/colours "#C4A000" "#929292"))
       (org-level-8                         (if gl/colours "#729FCF" FG))
       (org-date                            (if gl/colours "#2C78BF" "#00FFFF"))
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

       (header-line-bg                       (if gl/colours "#292929" "#333333"))
       (header-line-fg                       FG)
       (elscreen-tab-current-screen-face-bg  "#666666")
       (elscreen-tab-current-screen-face-fg  "#E5E5E5")

       (dired-header                         (if gl/colours "#4E9A06" "#98fb98"))
       (dired-directory                      (if gl/colours "#4286F4" "#87CEFA"))
       (dired-symlink                        (if gl/colours "#75507B" "#1E90FF"))
       )
  (custom-theme-set-faces
   'gl-dark

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

   `(font-lock-builtin-face              ((t (:foreground ,font-lock-builtin-face))))
   `(font-lock-comment-delimiter-face    ((t (:foreground ,font-lock-comment-delimiter-face))))
   `(font-lock-comment-face              ((t (:foreground ,font-lock-comment-face))))
   `(font-lock-constant-face             ((t (:foreground ,font-lock-constant-face))))
   `(font-lock-doc-face                  ((t (:foreground ,font-lock-doc-face)))) ;; :underline  ,font-lock-bold-or-underlined-face))))
   `(font-lock-function-name-face        ((t (:foreground ,font-lock-function-name-face))))
   `(font-lock-keyword-face              ((t (:foreground ,font-lock-keyword-face))))
                                                          ;; :bold  ,font-lock-bold-or-underlined-face))))
   `(font-lock-negation-char-face        ((t (:foreground ,font-lock-negation-char-face))))
   `(font-lock-preprocessor-face         ((t (:foreground ,font-lock-preprocessor-face))))
   `(font-lock-regexp-grouping-backslash ((t (:foreground ,font-lock-regexp-grouping-backslash :bold t))))
   `(font-lock-regexp-grouping-construct ((t (:foreground ,font-lock-regexp-grouping-construct :bold t))))
   `(font-lock-string-face               ((t (:foreground ,font-lock-string-face)))) ;; :underline ,font-lock-bold-or-underlined-face))))
   `(font-lock-type-face                 ((t (:foreground ,font-lock-type-face)))) ;;:bold  ,font-lock-bold-or-underlined-face))))
   `(font-lock-variable-name-face        ((t (:foreground ,font-lock-variable-name-face))))
   `(font-lock-warning-face              ((t (:foreground ,font-lock-warning-face :bold t))))

   `(ido-subdir                          ((t (:foreground ,ido-subdir))))
   `(ido-only-match                      ((t (:foreground ,ido-only-match))))
   `(ido-first-match                     ((t (:foreground ,ido-first-match :bold t :underline t))))

   `(sh-quoted-exec                      ((t (:foreground ,sh-quoted-exec))))
   `(sh-heredoc                          ((t (:foreground ,sh-heredoc :bold t))))

   `(italic                              ((t (:inherit italic :underline nil))))

   `(completions-common-part             ((t (:foreground ,completions-common-part :bold t))))

   `(isearch-fail                        ((t (:background ,isearch-fail))))
   `(isearch                             ((t (:background ,isearch-bg :foreground ,isearch-fg
                                                          :bold ,isearch-bold))))

   `(shadow                              ((t (:foreground ,shadow))))

   `(org-level-1                         ((t (:foreground ,org-level-1))))
   `(org-level-2                         ((t (:foreground ,org-level-2))))
   `(org-level-3                         ((t (:foreground ,org-level-3))))
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


   `(header-line                         ((t (:background ,header-line-bg :foreground ,header-line-fg
                                               :box  (:line-width -1 :style released-button)))))
   `(elscreen-tab-background-face     ((t (:inherit header-line))))
   `(elscreen-tab-control-face        ((t (:inherit elscreen-tab-background-face))))
   `(elscreen-tab-other-screen-face   ((t (:inherit elscreen-tab-background-face))))
   `(elscreen-tab-current-screen-face ((t (:background "#666666" :foreground "#e5e5e5"))))

   `(dired-header                     ((t (:foreground ,dired-header))))
   `(dired-directory                  ((t (:foreground ,dired-directory ))))
   `(dired-symlink                    ((t (:foreground ,dired-symlink))))

   `(buffer-menu-buffer               ((t (:inherit default))))

   ))
(provide-theme 'gl-dark)
