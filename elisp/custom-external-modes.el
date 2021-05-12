;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; ace-window
(use-package ace-window
  :ensure nil
  :config
  (setq aw-keys '(?a ?s ?d ?f ?g ?h ?j ?k ?l))
  :bind
  (("C-c o"   . ace-window)
	 ("C-x o"   . ace-window)))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; notmuch
(use-package notmuch
  :defer t
	:ensure nil
  :config
	(xterm-mouse-mode -1)
	(setq notmuch-search-oldest-first nil
				notmuch-multipart/alternative-discouraged '()))
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
