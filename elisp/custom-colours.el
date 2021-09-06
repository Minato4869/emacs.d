;; fixme mode
(defgroup fixme nil
  "Hilight TODO/STUDY/IMPROTANT/NOTE in special colours") ;; were underlined
(defface ccol/fixme-face
  '((t (:foreground "#FFC0CB" :bold t))) ;; was red
  "Font lock face for TODO comments"
  :group 'fixme)
(defface ccol/done-face
  '((t (:foreground "#98fb98" :bold t)))
  "Font lock face for DONE comments"
  :group 'fixme)
(defface ccol/study-face
  '((t (:foreground "Yellow" :bold t)))
  "Font lock face for STUDY comments"
  :group 'fixme)
(defface ccol/wontfix-face
  '((t (:foreground "red" :bold t))) ;; was Yellow
  "Font lock face for WONTFIX comments"
  :group 'fixme)
(defface ccol/important-face
  '((t (:foreground "red" :bold t))) ;; was Yellow
  "Font lock face for IMPORTANT comments"
  :group 'fixme)
(defface ccol/note-face
  '((t (:foreground "ForestGreen" :bold t))) ;; was DarkGreen
  "Font lock face for NOTE comments"
  :group 'fixme)

(mapc
 (lambda (mode)
   (font-lock-add-keywords
    mode
    '(("\\<\\(TODO\\)"      . 'ccol/fixme-face)
      ("\\<\\(DONE\\)"      . 'ccol/done-face)
      ("\\<\\(STUDY\\)"     . 'ccol/study-face)
      ("\\<\\(IMPORTANT\\)" . 'ccol/important-face)
      ("\\<\\(WONT\ FIX\\)" . 'ccol/wontfix-face)
      ("\\<\\(NOTE\\)"      .  'ccol/note-face))))
 '(c++-mode c-mode emacs-lisp-mode java-mode latex-mode plain-tex-mode puppet-mode))

(mapc
 (lambda (mode)
   (font-lock-add-keywords
    mode
    '(("\\<\\(STUDY\\)"     . 'ccol/study-face)
      ("\\<\\(IMPORTANT\\)" . 'ccol/important-face)
      ("\\<\\(WONT\ FIX\\)" . 'ccol/wontfix-face)
      ("\\<\\(NOTE\\)"      .  'ccol/note-face))))
 '(org-mode orgalist-mode))
(defun gui-theme()
  (or (display-graphic-p) (daemonp)))
(let ((dired-directory       (if (gui-theme) "#4286F4" "brightblue"))
       (dired-symlink        (if (gui-theme) "#75507B" "magenta"))
       (eshell-ls-executable (if (gui-theme) "#cc0000" "red"))
       (trailing-whitespace  (if (gui-theme) "#FFB6B0" "maroon"))
       (Man-overstrike       (if (gui-theme) "#FF0000" "brightred"))   ;; was "#EF2929"
       (Man-underline        (if (gui-theme) "#00FF00" "brightgreen")) ;; was "#8AE234"
       (whitespace-space     (if (gui-theme) "#444444" "color-238"))
       )
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
;; `(error                        ((t (:foreground "red" :bold t))))
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
 `(whitespace-trailing          ((t (:foreground ,trailing-whitespace :inherit background))))
 `(whitespace-line              ((t (:inherit foreground))))
 `(nobreak-space                ((t (:foreground "cyan"))))
;; v-- default colours bg: 333333 fg: e5e5e5, tab: 666666
 `(menu                         ((t (:background "#292929" :foreground "#bebebe"))))
 `(scroll-bar                   ((t (:stipple nil :inherit default))))
 `(match                        ((t (:background "#CDCD00" :foreground "#000000")))) ;; def: bg=RoyalBlue3
;;; org mode
 `(org-date                     ((t (:inherit org-date :underline nil))))
 `(org-latex-and-related        ((t (:foreground "#DEB887"))))
 `(org-table                    ((t (:foreground "#87CEFA"))))
 ))
