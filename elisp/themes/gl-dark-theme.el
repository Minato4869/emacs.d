(deftheme gl-dark
  "gl-dark theme")

(let* ((is_ttf                               (if (string-match "PfEd" (prin1-to-string (face-attribute 'default :font)))
                                                t
                                               nil))
       (FG                                   (cond (gl/light   "#000000")
                                                   (is_ttf     "#FFFFFF")
                                                   (gl/colours "#BEBEBE")
                                                   (t          "#E5E5E5")))
       (default-term                        (cond ((is_ssh)  '(:background "color-233"      :foreground "color-254"))
                                                 (gl/light   '(:background "color-16"       :foreground "color-250"))
                                                 ((daemonp)  '(:background "color-236"      :foreground "color-254"))
                                                 (t          '(:background "unspecified-bg" :foreground "unspecified-fg"))))
       (BG                                  (cond (gl/light   "#D9D5BA")
                                                  ((and gl/colours is_ttf)
                                                              "#000000")
                                                  (is_ttf     "#333333")
                                                  (gl/colours "#000000")
                                                  (t          "#333333")))
       (cursor                              (cond (gl/light   '(:background "#4286F4" :foreground "#FFFFFF"))
                                                  (gl/colours '(:background "#ff0000" :foreground "#000000"))
                                                  (t          '(:background "#00ff00" :foreground "#000000"))))
       (fringe                              (if gl/light "#C9C6B0" "#1A1A1A"))
       (mode-line                           (if gl/light '(:background "#3E3E3D" :foreground "#d9d5ba")
                                                         '(:background "#292929" :inherit default)))
       (mode-line-inactive                  '(:background "#4D4D4D" :foreground "#CCCCCC" :box (:line-width -1 :color "#666666" :style nil)))

       (mode-line-term                     (if (is_ssh) '(:background "#373333"  :foreground "#838383" :bold t)
                                                        '(:background "color-235" :foreground "color-250")))
       (mode-line-inactive-term            (if (is_ssh) '(:background "#292424"  :foreground "#847f54" :bold t)
                                                        '(:background "color-239" :foreground "color-252")))
       (mode-line-buffer-id                (if (is_ssh) "#B680B1" nil))

       (region-fg                           (if gl/light BG FG))
       (ido-subdir                          (if gl/light "#4E9A06" "#A1C659"))
       (ido-only-match                      (if gl/light "#8b8b00" "#FFCC33"))

       (font-lock-builtin-face              (if gl/colours "#75507B" nil)) ;; "#71a46c"))
       (font-lock-comment-face              (if gl/colours "#CC0000" nil)) ;; "#888888")) ;; was "#5d5a58" for grey
       (font-lock-constant-face             (if gl/colours "#4E9A06" nil)) ;; "#bd845f"))
       (font-lock-doc-face                  (if gl/colours "#4E9A06" nil)) ;; font-lock-comment-face))
       (font-lock-function-name-face        (if gl/colours "#75507B" nil)) ;; "#b680b1"))
       (font-lock-keyword-face              (if gl/colours "#729FCF" nil)) ;; "#96905f"))
       (font-lock-negation-char-face        (if gl/colours nil       nil)) ;; font-lock-constant-face))
       (font-lock-preprocessor-face         (if gl/colours "#75507B" nil)) ;; nil))
       (font-lock-string-face               (if gl/colours "#4E9A06" nil)) ;; "#71a19f"))
       (font-lock-type-face                 (if gl/colours "#4E9A06" nil)) ;; "#8b8fc6"))
       (font-lock-variable-name-face        (if gl/colours "#C4A000" nil)) ;; "#c27d7b"))

       (sh-quoted-exec                      (if gl/colours "#FA8072" nil))
       (sh-heredoc                          (if gl/colours "#FFFF00" nil))
       (sh-heredoc-bold                     (if gl/colours t         nil))

       (org-level-1                         (cond (gl/light "#000000") (gl/colours "#75507B") (t "#A1A1A1"))) ;; was FG
       (org-level-2                         (cond (gl/light "#333333") (gl/colours "#C4A000") (t "#929292")))
       (org-level-3                         (cond (gl/light "#696969") (gl/colours "#729FCF") (t "#838383")))
       (org-level-4                         (cond (gl/light "#565252") (gl/colours "#CC0000") (t "#757575"))) ;;(t "#565252")))
       (org-level-5                         (cond (gl/light "#0000ff") (gl/colours "#4E9A06") (t "#8b8fc6")))
       (org-level-6                         (cond (gl/light "#a0522d") (gl/colours "#75507B") (t "#bd845f")))
       (org-level-7                         (cond (gl/light "#a020f0") (gl/colours "#C4A000") (t "#71a46c")))
       (org-level-8                         (cond (gl/light "#b22222") (gl/colours "#729FCF") (t "#71a19f")))
       (org-level-1-bold                    (if gl/colours nil       t))
       (org-level-3-bold                    (if gl/colours nil       t))
       (org-level-6-bold                    (if gl/colours t         nil))
       (org-level-7-bold                    (if gl/colours t         nil))
       (org-level-8-bold                    (if gl/colours t         nil))



       (org-todo-term                       (if gl/colours "brightmagenta" "#d70000"))
       (org-todo                            (if gl/colours "#FFC0CB" "#d70000"))
       (org-done                            (if gl/colours "#98FB98" "#228b22"))
       (org-headline-done                   (if gl/light "#d2691e" "#FFA07A"))
       (org-meta-line                       (if gl/colours "#CC0000" "#E5E5E5"))
       (org-meta-line-bold                  (if gl/colours nil       t))
       (org-block-delim                     (if gl/colours "#CC0000" "#E5E5E5"))
       (org-table                           (if gl/light "#000000" "#87CEFA"))
       (completions-common-part             (cond (gl/light   "#121212") (gl/colours "#1e90ff") (t "#ADD8E6")))

       (tex-verbatim                           (if gl/light "#a0522d" "#DEB887"))
       (tex-math                               (if gl/light "#a0522d" "#DEB887"))

       (header-line                          '(:inherit mode-line :box  (:line-width -1 :style released-button)))

       (dired-header                         (if gl/colours "#4E9A06" "#98fb98"))
       (dired-directory                      (cond (gl/light "#114488") (gl/colours "#4286F4") (t "#87CEFA")))
       (dired-symlink                        (if gl/colours "#75507B" "#1E90FF"))
       (Man-overstrike                       (if gl/colours "#FF0000" "#E5E5E5"))
       (Man-underline                        (if gl/colours "#00FF00" "#4286F4"))
       (Man-underline-bold                   (if gl/colours t nil))

       ;; mu4e
       (mu4e-header-face                     (cond (gl/light "#333333") (gl/colours "#585858") (t "#888888")))

       ;; eshell
       (eshell-ls-executable                 (if (or gl/colours gl/light) "#ff0000" "#FF00FF"))
     )
(custom-theme-set-faces
 'gl-dark

 `(default                             ((((type tty)) ,default-term)
                                        (t            (:background ,BG :foreground ,FG))))
 `(cursor                              ((t ,cursor)))
 `(border                              ((t (:foreground "#0000ff"))))
 `(fringe                              ((t (:background ,fringe))))
 `(minibuffer-prompt                   ((t (:inherit default :bold t))))

   `(mode-line                           ((((type tty)) ,mode-line-term) (t ,mode-line)))
   `(mode-line-inactive                  ((((type tty)) ,mode-line-inactive-term) (t ,mode-line-inactive)))
   `(mode-line-buffer-id                 ((t           (:foreground ,mode-line-buffer-id :bold t))))

   `(region                              ((((type tty)) (:inherit default :background "blue" :extend t))
                                          (t           (:inherit default :background "#114488" :foreground ,region-fg :extend t))))

   `(hl-line                             ((t (:inherit fringe :extend t))))

   `(font-lock-builtin-face              ((t (:inherit default :foreground ,font-lock-builtin-face))))
   `(font-lock-comment-delimiter-face    ((t (:inherit font-lock-comment-face))))
   `(font-lock-comment-face              ((t (:inherit default :foreground ,font-lock-comment-face))))
   `(font-lock-constant-face             ((t (:inherit default :foreground ,font-lock-constant-face))))
   `(font-lock-doc-face                  ((t (:inherit default :foreground ,font-lock-doc-face))))
   `(font-lock-function-name-face        ((t (:inherit default :foreground ,font-lock-function-name-face))))
   `(font-lock-keyword-face              ((t (:inherit default :foreground ,font-lock-keyword-face))))
   `(font-lock-negation-char-face        ((t (:inherit default :foreground ,font-lock-negation-char-face))))
   `(font-lock-preprocessor-face         ((t (:inherit default :foreground ,font-lock-preprocessor-face))))
   `(font-lock-regexp-grouping-backslash ((t (:inherit default :bold t))))
   `(font-lock-regexp-grouping-construct ((t (:inherit default :bold t))))
   `(font-lock-string-face               ((t (:inherit default :foreground ,font-lock-string-face))))
   `(font-lock-type-face                 ((t (:inherit default :foreground ,font-lock-type-face))))
   `(font-lock-variable-name-face        ((t (:inherit default :foreground ,font-lock-variable-name-face))))
   `(font-lock-warning-face              ((t (:inherit default :foreground "#FF0000" :bold t))))

   `(ido-subdir                          ((t (:foreground ,ido-subdir))))
   `(ido-only-match                      ((t (:foreground ,ido-only-match))))
   `(ido-fist-match                      ((((type tty)) (:inherit default :bold t :underline t))
                                          (t (:inherit default :bold t :underline t))))
   `(ido-incomplete-regexp               ((t (:inherit default))))
   `(ido-indicator                       ((t (:inherit default))))
   `(sh-quoted-exec                      ((t (:inherit default :foreground ,sh-quoted-exec))))
   `(sh-heredoc                          ((t (:inherit default :foreground ,sh-heredoc
                                                       :bold ,sh-heredoc-bold))))

   `(italic                              ((t (:slant italic :underline nil))))

   `(completions-common-part             ((t (:foreground ,completions-common-part :bold t))))

   `(isearch-fail                        ((t (:background "#8B0000" :foreground "#E5E5E5"))))
   `(isearch                             ((t (:background "#333333" :foreground "#1E90FF" :bold t))))

   `(shadow                              ((t (:foreground "#aaaaaa"))))

   `(org-level-1                         ((t (:foreground ,org-level-1 :bold ,org-level-1-bold))))
   `(org-level-2                         ((t (:foreground ,org-level-2))))
   `(org-level-3                         ((t (:foreground ,org-level-3 :bold ,org-level-3-bold))))
   `(org-level-4                         ((t (:foreground ,org-level-4))))
   `(org-level-5                         ((t (:foreground ,org-level-5))))
   `(org-level-6                         ((t (:foreground ,org-level-6 :bold ,org-level-6-bold))))
   `(org-level-7                         ((t (:foreground ,org-level-7 :bold ,org-level-7-bold))))
   `(org-level-8                         ((t (:foreground ,org-level-8 :bold ,org-level-8-bold))))
   `(org-date                            ((t (:foreground "#2C78BF"))))
   `(org-todo                            ((((type tty)) (:foreground ,org-todo-term :bold t))
                                          (t            (:foreground ,org-todo :bold t))))
   `(org-do                              ((t (:foreground ,org-done :bold t))))
   `(org-special-keyword                 ((t (:foreground "#729FCF"))))
   `(org-priority                        ((t (:foreground "#729FCF"))))
   `(org-headline-done                   ((t (:foreground ,org-headline-done))))
   `(org-meta-line                       ((t (:foreground ,org-meta-line :bold ,org-meta-line-bold))))
   `(org-time-grid                       ((t (:foreground "#EEDD82"))))
   `(org-agenda-clocking                 ((t (:inherit default :background "#4A708B" :extend t))))
   `(org-agenda-structure                ((t (:foreground "#87CEFA"))))
   `(org-agenda-date                     ((t (:inherit org-agenda-structure))))
   `(org-agenda-date-today               ((t (:inherit org-agenda-date :bold t :underline t))))
   `(org-agenda-date-weekend             ((t (:inherit org-agenda-date :bold t))))
   `(org-block-begin-line                ((t (:fokreground ,org-block-delim))));; was inherit org-meta-line
   `(org-block-end-line                  ((t (:foreground ,org-block-delim))))
   `(org-block                           ((t (:inherit default :extend t))))
   `(org-latex-and-related               ((t (:foreground "#DEB887"))))
   `(org-table                           ((t (:foreground ,org-table))))


   `(tex-verbatim                        ((t (:foreground ,tex-verbatim))))
   `(tex-math                            ((t (:foreground ,tex-math))))


   `(header-line                         ((((type tty)) (:inherit mode-line))
                                          (t ,header-line)))

   `(dired-header                     ((t (:foreground ,dired-header))))
   `(dired-directory                  ((t (:foreground ,dired-directory ))))
   `(dired-symlink                    ((t (:foreground ,dired-symlink))))

   `(buffer-menu-buffer               ((t (:inherit default))))

   `(Man-overstrike                   ((t (:foreground ,Man-overstrike :bold t))))
   `(Man-underline                    ((t (:foreground ,Man-underline :underline nil
                                                       :bold ,Man-underline-bold))))

   `(error                            ((t (:foreground "#ff0000" :bold t))))

   `(show-paren-match                 ((t (:inherit default :background "#4f94cd"))))
   `(show-paren-mismatch              ((t (:foreground "#ffffff" :background "#a020f0"))))

   '(escape-glyph                     ((t (:foreground "#00ffff" :bold t))))

   `(magit-diff-header                   ((t (:inherit diff-header))))
   `(magit-diff-context-highlight        ((t (:inherit diff-context))))
   `(magit-diff-removed-highlight        ((t (:inherit diff-removed))))
   `(magit-diff-refine-removed-highlight ((t (:inherit diff-refine-removed))))
   `(magit-diff-added-highlight          ((t (:inherit diff-added))))

   `(mu4e-header-highlight-face       ((t (:background "#AF8700" :foreground "#000000" :bold nil))))
   `(mu4e-unread-face                 ((t (:foreground "#0087FF" :bold nil))))
   `(mu4e-replied-face                ((t (:foreground "#4286F4" :bold t))))
   `(mu4e-header-face                 ((t (:foreground ,mu4e-header-face :bold nil))))
   `(mu4e-header-key-face             ((t (:inherit mu4e-header-face))))

   `(eshell-ls-directory              ((t (:inherit dired-directory))))
   `(eshell-ls-symlink                ((t (:inherit dired-symlink))))
   `(eshell-ls-executable             ((t (:foreground ,eshell-ls-executable))))
   ))
(provide-theme 'gl-dark)
