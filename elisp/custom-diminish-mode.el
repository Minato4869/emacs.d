(require 'diminish)
;; hide/"diminish" always enabled modes
(when (fboundp 'diminish)
  (progn
    (diminish 'subword-mode) ;; iterate over camelCase
    (diminish 'ws-butler-mode)
    (diminish 'ws-butler-global-mode)
    (diminish 'yas-minor-mode)
    (diminish 'eldoc-mode)
    (diminish 'auto-fill-function)))
