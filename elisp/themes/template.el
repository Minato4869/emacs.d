(deftheme <themename>
  "<themename> theme")

(let ((class '((class color) (min-colors 89)))
      (BG  (when (theme/display-colors) ""))
      (FG  (when (theme/display-colors) ""))
      (cursor                           "")
      (border                           "")
      (fringe                           "")
      (mode-line-bg                     "")

      (mode-line-inactive-fg            "")
      (mode-line-inactive-bg            "")
      (mode-line-inactive-box           "")

      (region-bg                        "")
      (region-fg                        "")

      (ido-subdir                       "")
      (ido-only-match                   "")

      (font-lock-builtin-face           "")
      (font-lock-comment-face           "")
      (font-lock-constant-face          "")
      (font-lock-function-name-face     "")
      (font-lock-keyword-face           "")
      (font-lock-string-face            "")
      (font-lock-type-face              "")
      (font-lock-variable-name-face     "")

      (org-level-2                      "")
      (org-level-3                      "")
      (org-level-4                      "")
      (org-level-5                      "")
      (org-date                         "") ;; was cyan

      (sh-quoted-exec                   "")
      )
  (custom-theme-set-faces
   '<themename>

   `(default                      ((,class (:background ,BG :foreground ,FG))))
   `(cursor                       ((,class (:background ,cursor))))
   `(border                       ((,class (:foreground ,border))))
   `(fringe                       ((,class (:background ,fringe))))
   `(minibuffer-prompt            ((,class (:inherit foreground :bold t))))
   `(mode-line-inactive                    ((,class (:background ,mode-line-bg :inherit foreground))))
   `(mode-line-inactive-inactive           ((,class (:background ,mode-line-inactive-bg :foreground ,mode-line-inactive-fg
                                                        :box (:line-width -1 :color ,mode-line-inactive-box :style nil)))))
   `(region                       ((,class (:background ,region-bg :foreground ,region-fg))))

   `(font-lock-builtin-face       ((,class (:foreground ,font-lock-builtin-face))))
   `(font-lock-comment-face       ((,class (:foreground ,font-lock-comment-face))))
   `(font-lock-constant-face      ((,class (:foreground ,font-lock-constant-face))))
   `(font-lock-function-name-face ((,class (:foreground ,font-lock-function-name-face))))
   `(font-lock-keyword-face       ((,class (:foreground ,font-lock-keyword-face))))
   `(font-lock-string-face        ((,class (:foreground ,font-lock-string-face))))
   `(font-lock-type-face          ((,class (:foreground ,font-lock-type-face))))
   `(font-lock-variable-name-face ((,class (:foreground ,font-lock-variable-name-face))))

   `(ido-subdir                   ((,class (:foreground ,ido-subdir))))
   `(ido-only-match               ((,class (:foreground ,ido-only-match))))

   `(org-level-2                  ((,class (:foreground ,org-level-2))))
   `(org-level-3                  ((,class (:foreground ,org-level-3))))
   `(org-level-4                  ((,class (:foreground ,org-level-4))))
   `(org-level-5                  ((,class (:foreground ,org-level-5))))
   `(org-date                     ((,class (:foreground ,org-date :underline nil))))
   `(sh-quoted-exec               ((,class (:foreground ,sh-quoted-exec))))


   ))
(provide-theme '<themename>)
