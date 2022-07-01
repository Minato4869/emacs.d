(deftheme gl-dark
  "gl-dark theme")

(let* ((BG-term                             "unspecified-bg")
       (FG-term                             "unspecified-fg")
       (BG                                  "#000000")
       (FG                                  "#bebebe")
       (cursor-bg                           "#DB0600") ;; was ff0000
       (cursor-fg                           "#000000")
       (border                              "#0000FF")
       (fringe                              "#1A1A1A") ;; was 121212 for colours and 1a... for grey

       (mode-line-bg                         "#292929")
       (mode-line-fg                         FG)
       (mode-line-inactive-fg                "#CCCCCC")
       (mode-line-inactive-bg                "#4D4D4D")
       (mode-line-inactive-box               "#666666")

       (mode-line-bg-term                   "color-235")
       (mode-line-fg-term                   "color-250")
       (mode-line-inactive-fg-term          "color-252")
       (mode-line-inactive-bg-term          "color-239")

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

       (dired-header                         "#4E9A06")
       (dired-directory                      "#4286F4")
       (dired-symlink                        "#75507B")


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

   `(mode-line                           ((t            (:background ,mode-line-bg :foreground ,mode-line-fg))))
   `(mode-line-inactive                  ((t (:background ,mode-line-inactive-bg :foreground ,mode-line-inactive-fg
                                                          :box (:line-width -1 :color ,mode-line-inactive-box :style nil)))))
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
   `(ido-fist-match                      ((((type tty)) ( :foreground ,FG-term :bold t :underline t))
                                         (t (:foreground ,ido-first-match :bold t :underline t))))
   `(ido-incomplete-regexp               ((t (:inherit default))))
   `(ido-indicator                       ((t (:inherit default))))
   `(sh-quoted-exec                      ((t (:inherit default :foreground ,sh-quoted-exec))))
   `(sh-heredoc                          ((t (:inherit default :foreground ,sh-heredoc
                                                       :bold ,sh-heredoc-bold))))

   `(italic                              ((t (:inherit italic :underline nil))))

   `(completions-common-part             ((t (:foreground ,completions-common-part :bold t))))

   `(dired-header                     ((t (:foreground ,dired-header))))
   `(dired-directory                  ((t (:foreground ,dired-directory ))))
   `(dired-symlink                    ((t (:foreground ,dired-symlink))))

   `(buffer-menu-buffer               ((t (:inherit default))))
   ))
(provide-theme 'gl-dark)
