(deftheme gl-dark
  "gl-dark theme")

(let* ((BG-term                             (if (is_ssh) "color-234" "unspecified-bg"))
       (FG-term                             (if (is_ssh) "color-249" "unspecified-fg"))
       (BG                                  "#000000")
       (FG                                  "#BEBEBE")
       (cursor-bg                           "#DB0600") ;; was ff0000
       (cursor-fg                           "#000000")
       (border                              "#0000FF")
       (fringe                              "#1A1A1A") ;; was 121212 for colours and 1a... for grey

       (mode-line-bg                         "#292929")
       (mode-line-fg                         FG)
       (mode-line-inactive-fg                "#CCCCCC")
       (mode-line-inactive-bg                "#4D4D4D")
       (mode-line-inactive-box               "#666666")
       (mode-line-buffer-id                   nil)

       (mode-line-bg-term                   (if (is_ssh) "#373333" "color-235"))
       (mode-line-fg-term                   (if (is_ssh) "#838383" "color-250"))
       (mode-line-bold-term                 (if (is_ssh) t         nil))
       (mode-line-inactive-fg-term          (if (is_ssh) "#847f54" "color-252"))
       (mode-line-inactive-bg-term          (if (is_ssh) "#292424" "color-239"))
       (mode-line-buffer-id-term            (if (is_ssh) "#B680B1" nil))

       (hl-line-bg                          fringe)
       (region-bg                           "#114488")
       (region-fg                           FG)

       (ido-subdir                          "#A1C659")
       (ido-only-match                      "#FFCC33")
       (ido-first-match                     FG)

       (font-lock-builtin-face              "#75507B") ;; "#71a46c"))
       (font-lock-comment-face              "#CC0000") ;; "#888888")) ;; was "#5d5a58" for grey
       (font-lock-comment-delimiter-face    font-lock-comment-face)
       (font-lock-constant-face             "#4E9A06") ;; "#bd845f"))
       (font-lock-doc-face                  "#4E9A06") ;; font-lock-comment-face))
       (font-lock-function-name-face        "#75507B") ;; "#b680b1"))
       (font-lock-keyword-face              "#729FCF") ;; "#96905f"))
       (font-lock-negation-char-face        nil      ) ;; font-lock-constant-face))
       (font-lock-preprocessor-face         "#75507B") ;;)
       (font-lock-regexp-grouping-backslash nil)
       (font-lock-regexp-grouping-construct nil)
       (font-lock-string-face               "#4E9A06") ;; "#71a19f"))
       (font-lock-type-face                 "#4E9A06") ;; "#8b8fc6"))
       (font-lock-variable-name-face        "#C4A000") ;; "#c27d7b"))
       (font-lock-warning-face              "#FF0000")

       (sh-quoted-exec                      "#FA8072")
       (sh-heredoc                          "#FFFF00")
       (sh-heredoc-bold                     t        )

       (completions-common-part             "#ADD8E6")

       (isearch-fail-bg                     "#8B0000")   ;; v-- old conf
       (isearch-fail-fg                     FG)   ;; v-- old conf
       (isearch-bg                          "#333333")   ;; "#EE799F" BG))
       (isearch-fg                          "#1E90FF")   ;; "#8B2323" "#1E90FF"))
       (isearch-bold                        t)           ;; nil t))

       (shadow                              "#aaaaaa")

       (org-level-1                        "#75507B")
       (org-level-2                        "#C4A000")
       (org-level-3                        "#729FCF")
       (org-level-4                        "#CC0000")
       (org-level-5                        "#4E9A06")
       (org-level-6                        "#75507B")
       (org-level-7                        "#C4A000")
       (org-level-8                        "#729FCF")
       (org-date                           "#2C78BF")
       (org-special-keyword                 "#729FCF")
       (org-priority                        "#729FCF")
       (org-todo-term                       (if (is_ssh) "#d70000" "brightmagenta"))
       (org-done-term                       (if (is_ssh) "ForestGreen" "PaleGreen"))
       (org-todo                            (if (is_ssh) "#8B0000" "#FFC0CB"))
       (org-done                            (if (is_ssh) "#228b22" "#98FB98"))
       (org-headline-done-term              "#FFA07A")
       (org-headline-done                   "#FFA07A")
       (org-meta-line                       "#CC0000")
       (org-time-grid                       "#EEDD82")
       (org-agenda-structure                "#87CEFA")
       (org-agenda-clocking                 "#4A708B")
       (org-block-delim                     "#CC0000")
       (org-latex-and-related               "#DEB887")
       (org-table                           "#87CEFA")

       (font-latex-sedate-face              "#D3D3D3") ;; == lightgray; alt tui colour: 6C6C6C
       (font-latex-verbatim-face            "#DEB887") ;; == burlywood
       (tex-verbatim                        "#DEB887")
       (tex-math                            "#DEB887")
       (font-latex-math-face                "#DEB887")

       (header-line-bg                       mode-line-bg)
       (header-line-fg                       FG)
       (elscreen-tab-current-screen-face-bg  "#666666")
       (elscreen-tab-current-screen-face-fg  "#E5E5E5")

       (dired-header                         "#4E9A06")
       (dired-directory                      "#4286F4")
       (dired-symlink                        "#75507B")
       (Man-overstrike                       "#FF0000")
       (Man-underline                        "#00FF00")
       (Man-underline-bold                   t)

       (error                                "#ff0000")
       (error-bold                           t)

       (show-paren-match-bg                  "#4f94cd")
       (show-paren-mismatch-bg               "#a020f0")
       (show-paren-mismatch-fg               "#ffffff")
       )
  (custom-theme-set-faces
   'gl-dark

   `(default                             ((((type tty)) (:background ,BG-term :foreground ,FG-term))
                                          (t            (:background ,BG :foreground ,FG))))
   `(cursor                              ((t (:background ,cursor-bg :foreground ,cursor-fg ))))
   `(border                              ((t (:foreground ,border))))
   `(fringe                              ((t (:background ,fringe))))
   `(minibuffer-prompt                   ((t (:inherit default :bold t))))

   `(mode-line                           ((((type tty)) (:background ,mode-line-bg-term :foreground ,mode-line-fg-term
                                                                     :bold ,mode-line-bold-term))
                                          (t            (:background ,mode-line-bg :foreground ,mode-line-fg))))
   `(mode-line-inactive                  ((((type tty)) (:background ,mode-line-inactive-bg-term
                                                                     :foreground ,mode-line-inactive-fg-term))
                                          (t (:background ,mode-line-inactive-bg :foreground ,mode-line-inactive-fg
                                                          :box (:line-width -1 :color ,mode-line-inactive-box :style nil)))))
   `(mode-line-buffer-id                 ((((type tty)) (:inherit mode-lines :foreground, mode-line-buffer-id-term :bold t))
                                          (t (:inherit mode-lines :foreground, mode-line-buffer-id :bold t))))

   `(region                              ((((type tty)) (:foreground ,FG-term :background "blue" :extend t))
                                          (t (:background ,region-bg :foreground ,region-fg :extend t))))

   `(hl-line                             ((t (:inherit foreground :background ,hl-line-bg :extend t))))

   `(font-lock-builtin-face              ((t (:inherit default :foreground ,font-lock-builtin-face))))
   `(font-lock-comment-delimiter-face    ((t (:inherit default :foreground ,font-lock-comment-delimiter-face))))
   `(font-lock-comment-face              ((t (:inherit default :foreground ,font-lock-comment-face))))
   `(font-lock-constant-face             ((t (:inherit default :foreground ,font-lock-constant-face))))
   `(font-lock-doc-face                  ((t (:inherit default :foreground ,font-lock-doc-face))))
   `(font-lock-function-name-face        ((t (:inherit default :foreground ,font-lock-function-name-face))))
   `(font-lock-keyword-face              ((t (:inherit default :foreground ,font-lock-keyword-face))))
   `(font-lock-negation-char-face        ((t (:inherit default :foreground ,font-lock-negation-char-face))))
   `(font-lock-preprocessor-face         ((t (:inherit default :foreground ,font-lock-preprocessor-face))))
   `(font-lock-regexp-grouping-backslash ((t (:inherit default :foreground ,font-lock-regexp-grouping-backslash :bold t))))
   `(font-lock-regexp-grouping-construct ((t (:inherit default :foreground ,font-lock-regexp-grouping-construct :bold t))))
   `(font-lock-string-face               ((t (:inherit default :foreground ,font-lock-string-face))))
   `(font-lock-type-face                 ((t (:inherit default :foreground ,font-lock-type-face))))
   `(font-lock-variable-name-face        ((t (:inherit default :foreground ,font-lock-variable-name-face))))
   `(font-lock-warning-face              ((t (:inherit default :foreground ,font-lock-warning-face :bold t))))

   `(ido-subdir                          ((t (:foreground ,ido-subdir))))
   `(ido-only-match                      ((t (:foreground ,ido-only-match))))
   `(ido-fist-match                      ((((type tty)) ( :foreground ,FG-term :bold t :underline t))
                                         (t (:foreground ,ido-first-match :bold t :underline t))))
   `(ido-incomplete-regexp               ((t (:inherit default))))
   `(ido-indicator                       ((t (:inherit default))))
   `(sh-quoted-exec                      ((t (:inherit default :foreground ,sh-quoted-exec))))
   `(sh-heredoc                          ((t (:inherit default :foreground ,sh-heredoc
                                                       :bold ,sh-heredoc-bold))))

   `(italic                              ((t (:inherit italic :underline nil))))

   `(completions-common-part             ((t (:foreground ,completions-common-part :bold t))))

   `(isearch-fail                        ((t (:background ,isearch-fail-bg :foreground ,isearch-fail-fg))))
   `(isearch                             ((t (:background ,isearch-bg :foreground ,isearch-fg
                                                          :bold ,isearch-bold))))

   `(shadow                              ((t (:foreground ,shadow))))

   `(org-level-1                         (
                                          (t (:foreground ,org-level-1))))
   `(org-level-2                         (
                                          (t (:foreground ,org-level-2))))
   `(org-level-3                         (
                                          (t (:foreground ,org-level-3))))
   `(org-level-4                         (
                                          (t (:foreground ,org-level-4))))
   `(org-level-5                         (
                                          (t (:foreground ,org-level-5))))
   `(org-level-6                         (
                                          (t (:foreground ,org-level-6 :bold t))))
   `(org-level-7                         (
                                          (t (:foreground ,org-level-7 :bold t))))
   `(org-level-8                         (
                                          (t (:foreground ,org-level-8 :bold t))))
   `(org-date                            (
                                          (t (:foreground ,org-date))))
   `(org-todo                            ((((type tty)) (:foreground ,org-todo-term :bold t))
                                          (t            (:foreground ,org-todo :bold t))))
   `(org-done                            ((((type tty)) (:foreground ,org-done-term :bold t))
                                          (t (:foreground ,org-done :bold t))))
   `(org-special-keyword                 ((t (:foreground ,org-special-keyword))))
   `(org-priority                        ((t (:foreground ,org-priority))))
   `(org-headline-done                   ((((type tty)) (:foreground ,org-headline-done-term))
                                          (t (:foreground ,org-headline-done))))
   `(org-meta-line                       ((t (:foreground ,org-meta-line))))
   `(org-time-grid                       ((t (:foreground ,org-time-grid))))
   `(org-agenda-clocking                 ((t (:inherit default :background ,org-agenda-clocking :extend t))))
   `(org-agenda-structure                ((t (:foreground ,org-agenda-structure))))
   `(org-agenda-date                     ((t (:inherit org-agenda-structure))))
   `(org-agenda-date-today               ((t (:inherit org-agenda-date :bold t :underline t))))
   `(org-agenda-date-weekend             ((t (:inherit org-agenda-date :bold t))))
   `(org-block-begin-line                ((t (:fokreground ,org-block-delim))));; was inherit org-meta-line
   `(org-block-end-line                  ((t (:foreground ,org-block-delim))))
   `(org-block                           ((t (:inherit default :extend t))))
   `(org-latex-and-related               ((t (:foreground ,org-latex-and-related))))
   `(org-table                           ((t (:foreground ,org-table            ))))


   ;; == LaTeX
   `(font-latex-sedate-face              ((t (:foreground ,font-latex-sedate-face))))
   `(font-latex-verbatim-face            ((t (:foreground ,font-latex-verbatim-face))))
   `(font-latex-math-face                ((t (:foreground ,font-latex-math-face))))

   `(tex-verbatim                        ((t (:foreground ,tex-verbatim))))
   `(tex-math                            ((t (:foreground ,tex-math))))


   `(header-line                         ((((type tty)) (:inherit mode-line))
                                          (t (:background ,header-line-bg :foreground ,header-line-fg
                                                          :box  (:line-width -1 :style released-button)))))
   `(elscreen-tab-background-face     ((t (:inherit header-line))))
   `(elscreen-tab-control-face        ((t (:inherit elscreen-tab-background-face))))
   `(elscreen-tab-other-screen-face   ((t (:inherit elscreen-tab-background-face))))
   `(elscreen-tab-current-screen-face ((((type tty)) (:inherit mode-line-inactive))
                                       (t (:background ,elscreen-tab-current-screen-face-bg
                                                       :foreground ,elscreen-tab-current-screen-face-fg))))

   `(dired-header                     ((t (:foreground ,dired-header))))
   `(dired-directory                  ((t (:foreground ,dired-directory ))))
   `(dired-symlink                    ((t (:foreground ,dired-symlink))))

   `(buffer-menu-buffer               ((t (:inherit default))))

   `(Man-overstrike                   ((t (:foreground ,Man-overstrike :bold t))))
   `(Man-underline                    ((t (:foreground ,Man-underline :underline nil
                                                       :bold ,Man-underline-bold))))

   `(error                            ((t (:foreground ,error :bold ,error-bold))))

   `(show-paren-match                 ((t (:inherit default :background ,show-paren-match-bg))))
   `(show-paren-mismatch              ((t (:foreground ,show-paren-mismatch-fg
                                                       :background ,show-paren-mismatch-bg))))

   ))
(provide-theme 'gl-dark)
