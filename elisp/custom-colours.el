;; fixme mode
(defgroup fixme nil
  "Hilight TODO/STUDY/IMPROTANT/NOTE in special colours") ;; were underlined
(defface font-lock-fixme-face
  '((t (:foreground "#FFC0CB" :bold t))) ;; was red
  "Font lock face for TODO comments"
  :group 'fixme)
(defface font-lock-done-face
  '((t (:foreground "#98fb98" :bold t)))
  "Font lock face for DONE comments"
  :group 'fixme)
(defface font-lock-study-face
  '((t (:foreground "Yellow" :bold t)))
  "Font lock face for STUDY comments"
  :group 'fixme)
(defface font-lock-wontfix-face
  '((t (:foreground "red" :bold t))) ;; was Yellow
  "Font lock face for WONTFIX comments"
  :group 'fixme)
(defface font-lock-important-face
  '((t (:foreground "red" :bold t))) ;; was Yellow
  "Font lock face for IMPORTANT comments"
  :group 'fixme)
(defface font-lock-note-face
  '((t (:foreground "ForestGreen" :bold t))) ;; was DarkGreen
  "Font lock face for NOTE comments"
  :group 'fixme)

(mapc
 (lambda (mode)
   (font-lock-add-keywords
    mode
    '(("\\<\\(TODO\\)"      . 'font-lock-fixme-face)
      ("\\<\\(DONE\\)"      . 'font-lock-done-face)
      ("\\<\\(STUDY\\)"     . 'font-lock-study-face)
      ("\\<\\(IMPORTANT\\)" . 'font-lock-important-face)
      ("\\<\\(WONT\ FIX\\)" . 'font-lock-wontfix-face)
      ("\\<\\(NOTE\\)"      .  'font-lock-note-face))))
 '(c++-mode c-mode emacs-lisp-mode java-mode latex-mode plain-tex-mode puppet-mode))

(mapc
 (lambda (mode)
   (font-lock-add-keywords
    mode
    '(("\\<\\(STUDY\\)"     . 'font-lock-study-face)
      ("\\<\\(IMPORTANT\\)" . 'font-lock-important-face)
      ("\\<\\(WONT\ FIX\\)" . 'font-lock-wontfix-face)
      ("\\<\\(NOTE\\)"      .  'font-lock-note-face))))
 '(org-mode orgalist-mode))
(setq dired-directory         "brightblue"
      dired-symlink           "magenta"
      eshell-ls-executable    "red"
      trailing-whitespace     "maroon"
      Man-overstrike          "brightred"
      Man-underline           "brightgreen"
      whitespace-space        "color-238")
(when (or (display-graphic-p) (daemonp))
    (setq dired-directory      "#4286F4"
          dired-symlink        "#75507B"
          eshell-ls-executable "#cc0000"
          trailing-whitespace  "#FFB6B0"
          Man-overstrike       "#FF0000" ;; was "#EF2929"
          Man-underline        "#00FF00" ;; was "#8AE234"
          whitespace-space     "#444444"))
(custom-set-faces
 `(header-line                  ((t (:background "grey40" :foreground "#BEBEBE"
                                               :box  (:line-width -1 :style released-button)))))
 `(Man-overstrike               ((t (:foreground ,Man-overstrike :bold t))))
 `(Man-underline                ((t (:foreground ,Man-underline :underline nil :bold t))))
 `(diff-added                   ((t (:foreground "green"))))
 `(diff-refine-added            ((t (:foreground "green" :underline t))))
 `(diff-header                  ((t (nil))))
 `(diff-context                 ((t (nil))))
 `(diff-removed                 ((t (:foreground "red"))))
 `(diff-refine-removed          ((t (:foreground "red" :underline t))))
 `(dired-directory              ((t (:foreground ,dired-directory ))))
 `(dired-symlink                ((t (:foreground ,dired-symlink))))
 `(eshell-ls-archive            ((t (:inherit foreground))))
 `(eshell-ls-backup             ((t (:inherit foreground))))
 `(eshell-ls-clutter            ((t (:inherit foreground))))
 `(eshell-ls-directory          ((t (:inherit dired-directory))))
 `(eshell-ls-symlink            ((t (:inherit dired-symlink))))
 `(eshell-ls-executable         ((t (:foreground ,eshell-ls-executable))))
 `(font-latex-sectioning-0-face ((t (:inherit font-lock-variable-name-face))))
 `(font-latex-sectioning-1-face ((t (:inherit font-latex-sectioning-0-face))))
 `(font-latex-sectioning-2-face ((t (:inherit font-latex-sectioning-1-face))))
 `(font-latex-sectioning-3-face ((t (:inherit font-latex-sectioning-2-face))))
 `(font-latex-sectioning-4-face ((t (:inherit font-latex-sectioning-3-face))))
 `(font-latex-sectioning-5-face ((t (:inherit font-latex-sectioning-4-face))))
 `(font-latex-verbatim-face     ((t (:foreground "burlywood"))))
 `(font-lock-warning-face       ((t (:foreground "red" :bold t ))))
 `(hl-line                      ((t (:inherit region :extend t))))
 `(ido-first-match              ((t (:inherit foreground :bold t :underline t))))
 `(ido-incomplete-regexp        ((t (:inherit foreground))))
 `(ido-indicator                ((t (:inherit foreground))))
 `(line-number                  ((t (:inherit foreground :bold t))))
 `(link                         ((t (:foreground ,dired-directory :underline t))))
 `(mouse                        ((t (:background "grey"))))
 `(trailing-whitespace          ((t (:background ,trailing-whitespace))))
 `(whitespace-space             ((t (:foreground ,whitespace-space :inherit background))))
 `(whitespace-tab               ((t (:inherit     whitespace-space))))
 `(whitespace-empty             ((t (:foreground "firebrick"  :inherit  background))))
 `(whitespace-trailing          ((t (:foreground ,trailing-ws :inherit background))))
 `(whitespace-line              ((t (:inherit foreground))))
 `(nobreak-space                ((t (:foreground "cyan"))))
;; v-- default colours bg: 333333 fg: e5e5e5, tab: 666666
 `(menu                         ((t (:background "#292929" :foreground "#bebebe"))))
 `(scroll-bar                   ((t (:stipple nil :inherit default))))
 `(match                        ((t (:background "#CDCD00" :foreground "#000000")))) ;; def: bg=RoyalBlue3
 `(org-date                     ((t (:inherit org-date :underline nil))))
 )
