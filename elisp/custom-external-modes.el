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
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(use-package neotree
	:ensure nil
	:defer t
  :bind
	(("<f1>" . neotree-toggle))
	(:map neotree-mode-map
				("a"       . neotree-select-up-node)
				("s"       . neotree-next-line)
				("w"       . neotree-previous-line)
				("d"       . neotree-quick-look)
				("D"       . neotree-change-root)
				("<left>"     . neotree-select-up-node)
				("<down>"     . neotree-next-line)
				("<up>"       . neotree-previous-line)
				("<right>"    . neotree-quick-look)
				("C-<right>"  . neotree-change-root)
				("<C-return>" . neotree-change-root)
				("C-h"     . neotree-hidden-file-toggle)
				("u"       . neotree-select-up-node)
	 )
	:config
	(setq neo-theme 'ascii
				neo-smart-open t))
