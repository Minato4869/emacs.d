(require 'diminish)
;; hide/"diminish" always enabled modes
(when (fboundp 'diminish)
  (progn
    (diminish 'yas-minor-mode)
    (diminish 'eldoc-mode)
    (diminish 'auto-fill-function)))
