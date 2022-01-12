(deftheme gl-dark
  "gl-dark theme")
(defun is_ssh ()
  (if (and (getenv "SSH_CONNECTION") (not (daemonp))) t  nil))

(let* ((BG-term                             (if (is_ssh) "color-235" "unspecified-bg"))
       (FG-term                             (if (is_ssh) "color-249" "unspecified-fg"))
       (BG                                  (if gl/colours "#000000" "#333333"))
       (FG                                  (if gl/colours "#BEBEBE" "#E5E5E5"))
       (cursor                              (if gl/colours "#DB0600" "#00FF00")) ;; was ff0000 for dark theme
       (border                              "#0000FF")
       (fringe                              "#1A1A1A") ;; was 121212 for colours and 1a... for grey

       (mode-line-bg                        (if (is_ssh) "#373333" "#292929"))
       (mode-line-fg                        (if (is_ssh) "#838383" nil))
       (mode-line-bold                      (if (is_ssh) t         nil))
       (mode-line-inactive-fg               (if (is_ssh) "#847f54" "#CCCCCC"))
       (mode-line-inactive-bg               (if (is_ssh) "#292424" "#4D4D4D"))
       (mode-line-inactive-box              (if (is_ssh) mode-line-inactive-bg "#666666"))
       (mode-line-buffer-id                 (if (is_ssh) "#B680B1" nil))

       (region-bg                           "#114488")
       (region-fg                           FG)

       (ido-subdir                          "#A1C659")
       (ido-only-match                      "#FFCC33")
       (ido-first-match                     FG)

       (font-lock-builtin-face              (if gl/colours "#75507B" nil))
       (font-lock-comment-delimiter-face    (if gl/colours "#CC0000" nil))
       (font-lock-comment-face              (if gl/colours "#CC0000" nil))
       (font-lock-constant-face             (if gl/colours "#4E9A06" nil))
       (font-lock-doc-face                  (if gl/colours "#4E9A06" nil))
       (font-lock-function-name-face        (if gl/colours "#75507B" nil))
       (font-lock-keyword-face              (if gl/colours "#729FCF" nil))
       (font-lock-negation-char-face        nil)
       (font-lock-preprocessor-face         (if gl/colours "#75507B" nil))
       (font-lock-regexp-grouping-backslash nil)
       (font-lock-regexp-grouping-construct nil)
       (font-lock-string-face               (if gl/colours "#4E9A06" nil))
       (font-lock-type-face                 (if gl/colours "#4E9A06" nil))
       (font-lock-variable-name-face        (if gl/colours "#C4A000" nil))
       (font-lock-warning-face              (if gl/colours "#FF0000" nil))

       (sh-quoted-exec                      (if gl/colours "#FA8072" nil))
       (sh-heredoc                          (if gl/colours "#FFFF00" nil))
       (sh-heredoc-bold                     (if gl/colours t         nil))

       (completions-common-part             "#ADD8E6")

       (isearch-fail                        "#8B0000")

       (isearch-bg                          (if gl/colours "#EE799F" BG))
       (isearch-fg                          (if gl/colours "#8B2323" "#1E90FF"))
       (isearch-bold                        (if gl/colours nil t))

       (shadow                              "#aaaaaa")

       (org-level-1-col                     "#75507B")
       (org-level-2-col                     "#C4A000")
       (org-level-3-col                     "#729FCF")
       (org-level-4-col                     "#CC0000")
       (org-level-5-col                     "#4E9A06")
       (org-level-6-col                     "#75507B")
       (org-level-7-col                     "#C4A000")
       (org-level-8-col                     "#729FCF")
       (org-date-col                        "#2C78BF")
       (org-level-1                         (if gl/colours org-level-1-col FG))
       (org-level-2                         (if gl/colours org-level-2-col "#A1A1A1"))
       (org-level-3                         (if gl/colours org-level-3-col "#929292"))
       (org-level-4                         (if gl/colours org-level-4-col "#838383"))
       (org-level-5                         (if gl/colours org-level-5-col "#838383"))
       (org-level-6                         (if gl/colours org-level-6-col "#838383"))
       (org-level-7                         (if gl/colours org-level-7-col "#929292"))
       (org-level-8                         (if gl/colours org-level-8-col FG))
       (org-date                            (if gl/colours org-date-col "#00FFFF"))
       (org-special-keyword                 "#729FCF")
       (org-priority                        "#729FCF")
       (org-todo                            "#FFC0CB")
       (org-done                            "#98FB98")
       (org-headline-done                   "#FFA07A")
       (org-meta-line                       "#CC0000")
       (org-time-grid                       "#EEDD82")
       (org-agenda-structure                "#87CEFA")
       (org-agenda-clocking                 "#4A708B")
       (org-block-delim                     (if gl/colours "#CC0000" FG))
       (org-latex-and-related               "#DEB887")
       (org-table                           "#87CEFA")


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
       (Man-overstrike                       (if gl/colours "#FF0000" FG))
       (Man-underline                        (if gl/colours "#00FF00" "#4286F4"))
       (Man-underline-bold                   (if gl/colours t nil))

       (error                                (if gl/colours "#ff0000" FG))
       (error-bold                           (if gl/colours t nil))

       (show-paren-match-bg                  "#4f94cd")
       (show-paren-mismatch-bg               "#a020f0")
       (show-paren-mismatch-fg               "#ffffff")
       )
  (custom-theme-set-faces
   'gl-dark

   `(default                             ((((type tty)) (:background ,BG-term :foreground ,FG-term))
                                          (t (:background ,BG :foreground ,FG))))
   `(cursor                              ((t (:background ,cursor))))
   `(border                              ((t (:foreground ,border))))
   `(fringe                              ((t (:background ,fringe))))
   `(minibuffer-prompt                   ((t (:inherit default :bold t))))
   `(mode-line                           ((t (:inherit default
                                                       :background ,mode-line-bg :foreground ,mode-line-fg
                                                       :bold ,mode-line-bold))))
   `(mode-line-inactive                  ((t (:background ,mode-line-inactive-bg :foreground ,mode-line-inactive-fg
                                                          :box (:line-width -1 :color ,mode-line-inactive-box :style nil)))))
   `(mode-line-buffer-id                 ((t (:inherit mode-lines :foreground, mode-line-buffer-id :bold t))))

   `(region                              ((((type tty)) (:foreground ,FG-term :background "blue" :extend t))
                                          (t (:background ,region-bg :foreground ,region-fg :extend t))))

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
   `(ido-first-match                     ((t (:foreground ,ido-first-match :bold t :underline t))))

   `(sh-quoted-exec                      ((t (:inherit default :foreground ,sh-quoted-exec))))
   `(sh-heredoc                          ((t (:inherit default :foreground ,sh-heredoc
                                                       :bold ,sh-heredoc-bold))))

   `(italic                              ((t (:inherit italic :underline nil))))

   `(completions-common-part             ((t (:foreground ,completions-common-part :bold t))))

   `(isearch-fail                        ((t (:background ,isearch-fail))))
   `(isearch                             ((t (:background ,isearch-bg :foreground ,isearch-fg
                                                          :bold ,isearch-bold))))

   `(shadow                              ((t (:foreground ,shadow))))

   `(org-level-1                         ((((type tty)) (:foreground ,org-level-1-col))
                                          (t (:foreground ,org-level-1))))
   `(org-level-2                         ((((type tty)) (:foreground ,org-level-2-col))
                                          (t (:foreground ,org-level-2))))
   `(org-level-3                         ((((type tty)) (:foreground ,org-level-3-col))
                                          (t (:foreground ,org-level-3))))
   `(org-level-4                         ((((type tty)) (:foreground ,org-level-4-col))
                                          (t (:foreground ,org-level-4))))
   `(org-level-5                         ((((type tty)) (:foreground ,org-level-5-col))
                                          (t (:foreground ,org-level-5))))
   `(org-level-6                         ((((type tty)) (:foreground ,org-level-6-col :bold t))
                                          (t (:foreground ,org-level-6 :bold t))))
   `(org-level-7                         ((((type tty)) (:foreground ,org-level-7-col :bold t))
                                          (t (:foreground ,org-level-7 :bold t))))
   `(org-level-8                         ((((type tty)) (:foreground ,org-level-8-col :bold t))
                                          (t (:foreground ,org-level-8 :bold t))))
   `(org-date                            ((((type tty)) (:foreground ,org-date-col))
                                          (t (:foreground ,org-date))))
   `(org-todo                            ((((type tty)) (:foreground "brightmagenta" :bold t))
                                          (t            (:foreground ,org-todo :bold t))))
   `(org-done                            ((t (:foreground ,org-done :bold t))))
   `(org-special-keyword                 ((t (:foreground ,org-special-keyword))))
   `(org-priority                        ((t (:foreground ,org-priority))))
   `(org-headline-done                   ((t (:foreground ,org-headline-done))))
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

   `(Man-overstrike                   ((t (:foreground ,Man-overstrike :bold t))))
   `(Man-underline                    ((t (:foreground ,Man-underline :underline nil
                                                       :bold ,Man-underline-bold))))

   `(error                            ((t (:foreground ,error :bold ,error-bold))))

   `(show-paren-match                 ((t (:inherit default :background ,show-paren-match-bg))))
   `(show-paren-mismatch              ((t (:foreground ,show-paren-mismatch-fg
                                                       :background ,show-paren-mismatch-bg))))

   ))
(provide-theme 'gl-dark)
