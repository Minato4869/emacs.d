(deftheme gl-dark
  "gl-dark-theme")

(let* ((default-term (cond ((is_ssh)  '(:background "color-235"      :foreground "unspecified-fg"))
                           ((daemonp) '(:background "color-236"      :foreground "color-254"))
                           (t         '(:background "unspecified-bg" :foreground "unspecified-fg"))))
       (mode-line-term                (if (is_ssh) '(:background "#373333"  :foreground "#838383" :bold t)
                                                   '(:background "color-235" :foreground "color-250")))
       (mode-line-inactive-term       (if (is_ssh) '(:background "#292424"  :foreground "#847f54" :bold t)
                                                   '(:background "color-239" :foreground "color-252")))
       (mode-line-buffer-id           (if (is_ssh) "#B680B1" nil))
       )
  (custom-theme-set-faces
   'gl-dark
   '(default ((((type tty))                       ,default-term)
             ;; (((class color) (background dark))  (:background "#000000" :foreground "#bebebe"))
             ;; (((class color) (background light)) (:background "#ffffff" :foreground "#000000"))
              (t                                  (:background "#333333" :foreground "#e5e5e5"))))
   '(cursor  ((((class color) (background dark))  (:background "#ff0000" :foreground "#000000"))
              (((class color) (background light)) (:background "#4286F4" :foreground "#FFFFFF"))
              (t                                  (:background "#00ff00" :foreground "#000000"))))
   '(border                              ((t (:foreground "#0000ff"))))
   '(fringe                              ((((class color) (background light)) (:background "#C9C6B0"))
                                          (t                                  (:background "#1A1A1A"))))
   '(minibuffer-prompt                   ((t (:inherit default :bold t))))
   '(mode-line                           ((((type  tty))                      ,mode-line-term)
                                          (((class color) (background light)) (:background "#3E3E3D" :foreground "#d9d5ba"))
                                          (t                                  (:background "#292929" :inherit default))))
   '(mode-line-inactive                 ((((type  tty)) ,mode-line-inactive-term)
                                         (t             (:background "#4D4D4D" :foreground "#CCCCCC" :box (:line-width -1 :color "#666666" :style nil)))))
   '(mode-line-inactive                 ((((type  tty)) ,mode-line-buffer-id)))
   '(region                             ((t (:inherit default :background "#114488" :extend t))))
   '(hl-line                            ((t (:inherit fringe :extend t))))

   '(font-lock-builtin-face              ((((class color) (background dark)) (:foreground "#75507B")) (t (:inherit default))))
   '(font-lock-comment-face              ((((class color) (background dark)) (:foreground "#CC0000")) (t (:inherit default))))
   '(font-lock-comment-delimiter-face    ((((class color) (background dark)) (:inherit font-lock-comment-face))))
   '(font-lock-constant-face             ((((class color) (background dark)) (:foreground "#4E9A06")) (t (:inherit default))))
   '(font-lock-doc-face                  ((((class color) (background dark)) (:foreground "#4E9A06")) (t (:inherit default))))
   '(font-lock-function-name-face        ((((class color) (background dark)) (:foreground "#75507B")) (t (:inherit default))))
   '(font-lock-keyword-face              ((((class color) (background dark)) (:foreground "#729FCF")) (t (:inherit default))))
   '(font-lock-negation-char-face        ((t                                     (:inherit default))))
   '(font-lock-preprocessor-face         ((((class color) (background dark)) (:foreground "#75507B")) (t (:inherit default))))
   '(font-lock-regexp-grouping-backslash ((((class color) (background dark)) (:inherit default :bold t))))
   '(font-lock-regexp-grouping-construct ((((class color) (background dark)) (:inherit default :bold t))))
   '(font-lock-string-face               ((((class color) (background dark)) (:foreground "#4E9A06")) (t (:inherit default))))
   '(font-lock-type-face                 ((((class color) (background dark)) (:foreground "#4E9A06")) (t (:inherit default))))
   '(font-lock-variable-name-face        ((((class color) (background dark)) (:foreground "#C4A000")) (t (:inherit default))))
   '(font-lock-warning-face              ((t                                    (:foreground "#FF0000" :bold t))))

   '(ido-subdir                          ((((class color) (background light)) (:foreground "#4E9A06"))
                                          (t                                 (:foreground "#A1C659"))))
   '(ido-only-match                      ((((class color) (background light)) (:foreground "#8B8B00"))
                                          (t                                 (:foreground "#FFCC33"))))
   '(ido-fist-match                      ((t (:inherit default :bold t :underline t))))
   '(ido-incomplete-regexp               ((t (:inherit default))))
   '(ido-indicator                       ((t (:inherit default))))

   '(sh-quoted-exec                      ((((class color) (background dark)) (:foreground "#FA8072"))         (t (:inherit default))))
   '(sh-heredoc                          ((((class color) (background dark)) (:foreground "#FFFF00" :bold t)) (t (:inherit default))))

   '(italic                              ((t (:slant italic :underline nil))))

   '(completions-common-part ((((class color) (background dark))  (:foreground "#1e90ff"))
                              (((class color) (background light))    (:foreground "#121212"))
                              (t                                     (:foreground "#add8e6"))))

   '(isearch-fail                        ((t (:background "#8B0000" :foreground "#E5E5E5"))))
   '(isearch                             ((t (:background "#333333" :foreground "#1E90FF" :bold t))))

   '(shadow                              ((t (:foreground "#aaaaaa"))))

   '(org-level-1                         ((((class color) (background dark))  (:foreground "#75507B"))
                                          (((class color) (background light)) (:foreground "#000000" :bold t))
                                          (t                                  (:foreground "#A1A1A1" :bold t))))
   '(org-level-2                         ((((class color) (background dark))  (:foreground "#C4A000"))
                                          (((class color) (background light)) (:foreground "#333333"))
                                          (t                                  (:foreground "#929292"))))
   '(org-level-3                         ((((class color) (background dark))  (:foreground "#729FCF"))
                                          (((class color) (background light)) (:foreground "#696969" :bold t))
                                          (t                                  (:foreground "#838383" :bold t))))
   '(org-level-4                         ((((class color) (background dark))  (:foreground "#CC0000"))
                                          (((class color) (background light)) (:foreground "#565252"))
                                          (t                                  (:foreground "#757575" t))))
   '(org-level-5                         ((((class color) (background dark))  (:foreground "#4E9A06"))
                                          (((class color) (background light)) (:foreground "#0000ff"))
                                          (t                                  (:foreground "#8b8fc6"))))
   '(org-level-6                         ((((class color) (background dark))  (:foreground "#75507B" :bold t))
                                          (((class color) (background light)) (:foreground "#a0522d"))
                                          (t                                  (:foreground "#bd845f"))))
   '(org-level-7                         ((((class color) (background dark))  (:foreground "#c4a000" :bold t))
                                          (((class color) (background light)) (:foreground "#a020f0"))
                                          (t                                  (:foreground "#71a46c"))))
   '(org-level-8                         ((((class color) (background dark))  (:foreground "#729fcf" :bold t))
                                          (((class color) (background light)) (:foreground "#b22222"))
                                          (t                                  (:foreground "#71a19f"))))

   '(org-date                            ((t (:foreground "#2C78BF"))))
   '(org-todo                            ((((class color) (background dark)) (:foreground "#FFC0CB" :bold t))
                                          (t                                 (:foreground "#D70000" :bold t))))
   '(org-done                            ((((class color) (background dark)) (:foreground "#98FB98" :bold t))
                                          (t                                 (:foreground "#228b22" :bold t))))
   '(org-special-keyword                 ((t (:foreground "#729FCF"))))
   '(org-priority                        ((t (:foreground "#729FCF"))))
   '(org-headline-done                   ((((class color) (background light)) (:foreground "#d2691e"))
                                          (t                                 (:foreground "#FFA07A"))))
   '(org-meta-line                       ((((class color) (background dark))  (:foreground "#CC0000"))
                                          (t                                 (:inherit default :bold t))))
   '(org-time-grid                       ((t (:foreground "#EEDD82"))))
   '(org-agenda-clocking                 ((t (:inherit default :background "#4A708B" :extend t))))
   '(org-agenda-structure                ((t (:foreground "#87CEFA"))))
   '(org-agenda-date                     ((t (:inherit org-agenda-structure))))
   '(org-agenda-date-today               ((t (:inherit org-agenda-date :bold t :underline t))))
   '(org-agenda-date-weekend             ((t (:inherit org-agenda-date :bold t))))
   '(org-block-begin-line                ((((class color) (background dark)) (:foreground "#CC0000"))
                                          (t                                (:inherit default)))) ;; was inherit org-meta-line
   '(org-block-end-line                  ((t (:inherit org-block-begin-line))))
   '(org-block                           ((t (:inherit default :extend t))))
   '(org-latex-and-related               ((t (:foreground "#DEB887"))))
   '(org-table                           ((((class color) (background light) (:foreground "#000000"))
                                           (t                                (:foreground "#87CEFA")))))


   '(tex-verbatim                        ((((class color) (background dark) (:foreground "#a0522d"))
                                           (t                               (:foreground "#DEB887")))))
   '(tex-math                            ((t (:inherit tex-verbatim))))

   '(header-line                         ((t (:inherit mode-line
                                                       :box (:line-width -1 :style released-button)))))

   '(dired-header                     ((((class color) (background dark)) (:foreground "#4E9A06"))
                                       (t                                (:foreground  "#98fb98"))))
   '(dired-directory                  ((((class color) (background dark)) (:foreground "#4286F4"))
                                       (((class color) (background dark)) (:foreground "#114488"))
                                       (t                                (:foreground  "#87CEFA"))))
   '(dired-symlin                     ((((class color) (background dark)) (:foreground "#75507b"))
                                       (t                                (:foreground  "#1e90ff"))))

   '(buffer-menu-buffer               ((t (:inherit default))))

   '(Man-overstrike                   ((t (:inherit default :bold t)))) ;; was ff0000 for dark
   '(Man-underline                    ((t (:foreground "#4286F4" :underline nil ;; was 00ff00 for dark
                                                       :bold t))))

   '(error                            ((t (:foreground "#ff0000" :bold t))))

   '(show-paren-match                 ((t (:inherit default :background "#4f94cd"))))
   '(show-paren-mismatch              ((t (:foreground "#ffffff" :background "#a020f0"))))

   '(escape-glyph                     ((t (:foreground "#00ffff" :bold t))))

   '(magit-diff-header                   ((t (:inherit diff-header))))
   '(magit-diff-context-highlight        ((t (:inherit diff-context))))
   '(magit-diff-removed-highlight        ((t (:inherit diff-removed))))
   '(magit-diff-refine-removed-highlight ((t (:inherit diff-refine-removed))))
   '(magit-diff-added-highlight          ((t (:inherit diff-added))))

   '(mu4e-header-highlight-face       ((t (:background "#AF8700" :foreground "#000000" :bold nil))))
   '(mu4e-unread-face                 ((t (:foreground "#0087FF" :bold nil))))
   '(mu4e-replied-face                ((t (:foreground "#4286F4" :bold t))))
   '(mu4e-header-face                 ((((class color) (background dark))  (:foreground "#585858"))
                                       (((class color) (background light)) (:foreground "#333333"))
                                       (t                                  (:foreground "#888888"))))
   '(mu4e-header-key-face             ((t (:inherit mu4e-header-face))))

   '(eshell-ls-directory              ((t (:inherit dired-directory))))
   '(eshell-ls-symlink                ((t (:inherit dired-symlink))))
   ;; '(eshell-ls-executable             ((t (:foreground ,eshell-ls-executable))))

   '(elscreen-tab-background-face     ((t (:inherit mode-line :box
                                                    (:line-width -1 :style released-button)))))
   '(elscreen-tab-control-face        ((t (:inherit elscreen-tab-background-face))))
   '(elscreen-tab-other-screen-face   ((t (:inherit elscreen-tab-background-face))))
   '(elscreen-tab-current-screen-face ((((type tty)) (:inherit mode-line-inactive))
                                       (t (:foreground "#e5e5e5" :background "#666666"))))

   '(highlight                        ((((class color) (background light)) (:inherit default :background "#b4eeb4"))
                                       (t                                  (:inherit default :background "#556b2f"))))
   ))
(provide-theme 'gl-dark)
;;;; fixme mode
  ;;(defgroup fixme nil    "Hilight TODO/STUDY/IMPROTANT/NOTE in special colours") ;; were underlined
  ;;(defface ccol/fixme-face
  ;;  '((t (:inherit org-todo))) ;; was red
  ;;  "Font lock face for TODO comments"
  ;;  :group 'fixme)
  ;;(defface ccol/done-face
  ;;  '((t (:inherit org-todo)))
  ;;  "Font lock face for DONE comments"
  ;;  :group 'fixme)
  ;;(defface ccol/study-face
  ;;  '((t (:foreground "Yellow" :bold t)))
  ;;  "Font lock face for STUDY comments"
  ;;  :group 'fixme)
  ;;(defface ccol/wontfix-face
  ;;  '((t (:foreground "red" :bold t))) ;; was Yellow
  ;;  "Font lock face for WONTFIX comments"
  ;;  :group 'fixme)
  ;;(defface ccol/important-face
  ;;  '((t (:foreground "red" :bold t))) ;; was Yellow
  ;;  "Font lock face for IMPORTANT comments"
  ;;  :group 'fixme)
  ;;(defface ccol/note-face
  ;;  '((t (:foreground "ForestGreen" :bold t))) ;; was DarkGreen
  ;;  "Font lock face for NOTE comments"
  ;;  :group 'fixme)
  ;;
  ;;(mapc
  ;; (lambda (mode)
  ;;   (font-lock-add-keywords
  ;;    mode
  ;;    '(("\\<\\(TODO\\)"      . 'ccol/fixme-face)
  ;;      ("\\<\\(DONE\\)"      . 'ccol/done-face)
  ;;      ("\\<\\(STUDY\\)"     . 'ccol/study-face)
  ;;      ("\\<\\(IMPORTANT\\)" . 'ccol/important-face)
  ;;      ("\\<\\(WONT\ FIX\\)" . 'ccol/wontfix-face)
  ;;      ("\\<\\(NOTE\\)"      .  'ccol/note-face))))
  ;; '(c++-mode c-mode emacs-lisp-mode java-mode latex-mode plain-tex-mode puppet-mode))
  ;;
  ;;(mapc
  ;; (lambda (mode)
  ;;   (font-lock-add-keywords
  ;;    mode
  ;;    '(("\\<\\(STUDY\\)"     . 'ccol/study-face)
  ;;      ("\\<\\(IMPORTANT\\)" . 'ccol/important-face)
  ;;      ("\\<\\(WONT\ FIX\\)" . 'ccol/wontfix-face)
  ;;      ("\\<\\(NOTE\\)"      .  'ccol/note-face))))
  ;; '(org-mode orgalist-mode))
  ;;
  ;;(defun gui-theme()
  ;;  (or (display-graphic-p) (daemonp)))
  ;;(let ((eshell-ls-executable (if (gui-theme) "#cc0000" "red"))
  ;;      (trailing-whitespace  (if (gui-theme) "#FFB6B0" "maroon"))
  ;;      (whitespace-space     (if (gui-theme) "#444444" "color-238")))
  ;;  (custom-set-faces
  ;; `(header-line                  ((t (:box  (:line-width -1 :style released-button)))))
  ;; `(diff-added                   ((t (:foreground "green"))))
  ;; `(diff-refine-added            ((t (:foreground "green" :underline t))))
  ;; `(diff-header                  ((t (nil))))
  ;; `(diff-context                 ((t (nil))))
  ;; `(diff-removed                 ((t (:foreground "red"))))
  ;; `(diff-refine-removed          ((t (:foreground "red" :underline t))))
  ;; `(eshell-ls-archive            ((t (:inherit default))))
  ;; `(eshell-ls-backup             ((t (:inherit default))))
  ;; `(eshell-ls-clutter            ((t (:inherit default))))
  ;; `(eshell-ls-directory          ((t (:inherit dired-directory))))
  ;; `(eshell-ls-symlink            ((t (:inherit dired-symlink))))
  ;; `(eshell-ls-executable         ((t (:foreground ,eshell-ls-executable))))
  ;; `(font-latex-sectioning-0-face ((t (:inherit font-lock-variable-name-face))))
  ;; `(font-latex-sectioning-1-face ((t (:inherit font-latex-sectioning-0-face))))
  ;; `(font-latex-sectioning-2-face ((t (:inherit font-latex-sectioning-1-face))))
  ;; `(font-latex-sectioning-3-face ((t (:inherit font-latex-sectioning-2-face))))
  ;; `(font-latex-sectioning-4-face ((t (:inherit font-latex-sectioning-3-face))))
  ;; `(font-latex-sectioning-5-face ((t (:inherit font-latex-sectioning-4-face))))
  ;; `(font-latex-verbatim-face     ((t (:foreground "burlywood"))))
  ;; `(font-lock-warning-face       ((t (:foreground "red" :bold t ))))
  ;; `(region                       ((t (:inherit region :extend t))))
  ;; `(line-number                  ((t (:inherit default :bold t))))
  ;; `(link                         ((t (:foreground ,dired-directory :underline t))))
  ;; `(mouse                        ((t (:background "grey"))))
  ;; `(trailing-whitespace          ((t (:background ,trailing-whitespace))))
  ;; `(whitespace-space             ((t (:foreground ,whitespace-space :inherit background))))
  ;; `(whitespace-tab               ((t (:inherit     whitespace-space))))
  ;; `(whitespace-empty             ((t (:foreground "firebrick"  :inherit  background))))
  ;; `(whitespace-trailing          ((t (:foreground ,trailing-whitespace :inherit background))))
  ;; `(whitespace-line              ((t (:inherit default))))
  ;; `(nobreak-space                ((t (:foreground "cyan"))))
;;;; v-- default colours bg: 333333 fg: e5e5e5, tab: 666666
  ;; `(menu                         ((t (:background "#292929" :foreground "#bebebe"))))
  ;; `(scroll-bar                   ((t (:stipple nil :inherit default))))
  ;; `(match                        ((t (:background "#CDCD00" :foreground "#000000")))) ;; def: bg=RoyalBlue3
  ;; ))
