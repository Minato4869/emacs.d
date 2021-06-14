;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; ace-window
(use-package ace-window
  :ensure t
	:defer t
  :config
  (setq aw-keys '(?a ?s ?d ?f ?g ?h ?j ?k ?l))
  :bind
  (("C-x o"   . ace-window)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; notmuch
(use-package notmuch
  :defer t
	:ensure t
  :config
	(xterm-mouse-mode -1)
	(setq notmuch-search-oldest-first nil
				notmuch-multipart/alternative-discouraged '()))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; diminish
(use-package diminish 	;; hide/"diminish" always enabled modes
	:ensure t
	:defer nil
	:config
	(when (fboundp 'diminish)
		(progn
			(diminish 'subword-mode) ;; iterate over camelCase
			(diminish 'ws-butler-mode)
			(diminish 'ws-butler-global-mode)
			(diminish 'yas-minor-mode)
			(diminish 'eldoc-mode)
			(diminish 'auto-fill-function))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; elscreen
(use-package elscreen
	:ensure t
	:defer t
	:config
	(custom-set-faces
	 '(elscreen-tab-background-face     ((t (:background "#292929"))))
	 '(elscreen-tab-control-face        ((t (:background "#292929" :foreground "#bebebe"))))
	 '(elscreen-tab-current-screen-face ((t (:background "#666666" :foreground "#e5e5e5"))))
	 '(elscreen-tab-other-screen-face   ((t (:background "#292929" :bebebe "#foreground")))))
	(setq-default elscreen-prefix-key "\M-s")
	(custom-set-variables
	 '(elscreen-display-screen-number nil)
	 '(elscreen-tab-display-kill-screen nil)
	 '(elscreen-tab-display-control nil))
	(defun elscreen-close-current-tab ()
    (interactive)
    (when (y-or-n-p "Close current screen? ")
      (elscreen-kill)))

	(bind-keys
   ("M-<left>"        . elscreen-previous)
   ("M-<right>"       . elscreen-next))
	(bind-keys*
	 ("M-["             . elscreen-previous)
   ("M-]"             . elscreen-next)
	 ("M-s <left>"      . elscreen-previous)
   ("M-s <right>"     . elscreen-next)
   ("M-s M-s"         . elscreen-toggle)
   ("M-s s"           . elscreen-toggle)
   ("M-s x"           . elscreen-kill)
   ("M-s k"           . elscreen-close-current-tab)
	 ("M-s g"           . elscreen-goto)
   ("M-s 4"           . elscreen-create)))
(when (daemonp)
	(elscreen-start))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; yas
(use-package yasnippet
  :ensure t
	:defer t
	:config
	(defun yas-force-update ()
		(interactive)
		(yas-recompile-all)
		(yas-reload-all))
	(defalias 'yas 'yas-force-update))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; orgalist
(use-package orgalist
  :ensure t
	:defer t
	:bind
	(:map orgalist-mode-map
				("M-<left>"  . nil)
				("M-<right>" . nil)
				("S-<up>"    . orgalist--maybe-move-up)
				("S-<down>"  . orgalist--maybe-move-down)
				("S-<left>"  . orgalist--maybe-outdent-tree)
				("S-<right>" . orgalist--maybe-indent-tree)
				))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; browse-kill-ring
(use-package browse-kill-ring
  :ensure t
	:defer t
	:config
	(defalias 'bkr 'browse-kill-ring))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; packages without config
(use-package auctex               :ensure t :defer t)
(use-package dumb-jump            :ensure t :defer t)
(use-package haskell-mode         :ensure t :defer t)
(use-package keychain-environment :ensure t :defer nil)
(use-package goto-chg             :ensure t :defer t)
(use-package go-mode              :ensure t :defer t)
(use-package lua-mode             :ensure t :defer t)
(use-package magit                :ensure t :defer t)
(use-package projectile           :ensure t :defer t)
(use-package iflipb               :ensure t :defer t)
(use-package puppet-mode          :ensure t :defer t)
(use-package wgrep                :ensure t :defer t)


;;; interesting packages:
;; narrowed-page-navigation
