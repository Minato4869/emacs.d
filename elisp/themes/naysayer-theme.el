(deftheme naysayer
  "naysayer theme")

  (custom-theme-set-faces
   'naysayer

   `(default                       ((t (:foreground "#d3b58d" :background "#072626")))) ;; :background "#041818"
   `(cursor                        ((t (:background "#90ee90"))))
   `(mode-line                     ((t (:inverse-video t))))
   `(region                        ((t (:background "#0000ff" :extend t))))
   `(highlight                     ((t (:foreground "#000080" :background "#b4eeb4"))))

   `(font-lock-builtin-face        ((t (:foreground "#90ee90")))) ;; was nil
   `(font-lock-comment-face        ((t (:foreground "#4fdf1f"))))
   `(font-lock-function-name-face  ((t (:foreground "#FFFFFF")))) ;; was cyan3
   `(font-lock-keyword-face        ((t (:foreground "#FFFFFF")))) ;; was dodgerblue
   `(font-lock-string-face         ((t (:foreground "#0fdfaf")))) ;; was green3
   `(font-lock-variable-name-face  ((t (:foreground "#c8d4ec")))) ;; was coral

   ;; `(font-constant-face            ((t (:foreground "#darkred"))))
   ;; `(font-type-face                ((t (:foreground "dodgerblue"))))
)
(provide-theme 'naysayer)
