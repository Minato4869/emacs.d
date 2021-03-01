;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; ace-window
(use-package ace-window
  :ensure nil
  :config
  (setq aw-keys '(?a ?s ?d ?f ?g ?h ?j ?k ?l))
  :bind
  (("C-x C-o" . ace-window)
   ("C-c o"   . ace-window)))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; notmuch
(use-package notmuch
  :defer t
	:ensure nil
  :config
	(xterm-mouse-mode -1)
	(setq notmuch-search-oldest-first nil))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; diminish
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
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; notmuch
(setq notmuch-multipart/alternative-discouraged '())
