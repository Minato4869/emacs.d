;;; interesting packages:
;; narrowed-page-navigation
;; so-long mode

;; == ace-window
(use-package ace-window
  :ensure t
  :defer  t
  :config
  (setq aw-keys '(?a ?s ?d ?f ?g ?h ?j ?k ?l))
  :bind
  (("C-x o" . ace-window)))



;; == elscreen
(use-package elscreen
  :ensure t
  :defer  t
  :config
  (custom-set-faces
   '(elscreen-tab-background-face     ((t (:background "#292929"))))
   '(elscreen-tab-control-face        ((t (:background "#292929" :foreground "#bebebe"))))
   '(elscreen-tab-current-screen-face ((t (:background "#666666" :foreground "#e5e5e5"))))
   '(elscreen-tab-other-screen-face   ((t (:background "#292929" :foreground "#bebebe")))))
  (setq-default elscreen-prefix-key "\M-s")
  (custom-set-variables
   '(elscreen-display-screen-number nil)
   '(elscreen-tab-display-kill-screen nil))
  (defun elscreen-kill-confirm ()
    (interactive)
    (when (y-or-n-p "Kill current screen? ")
      (elscreen-kill)))
  (defun elscreen-kill-buffer-and-screen ()
    (interactive)
    (when (y-or-n-p "Kill current buffer and close screen? ")
      (kill-current-buffer)
      (elscreen-kill)))

  (defun elscreen-kill-window-or-screen ()
    (interactive)
    (if (one-window-p)
        (elscreen-kill-confirm)
      (delete-window)))
  :bind*
  (("M-<left>"    . elscreen-previous)
   ("M-<right>"   . elscreen-next)
   ("ESC <left>"    . elscreen-previous)
   ("ESC <right>"   . elscreen-next))
  (:map elscreen-map
        ("<left>"  . elscreen-previous)
        ("<right>" . elscreen-next)
        ("M-s"     . elscreen-toggle)
        ("s"       . elscreen-toggle)
        ("S"       . elscreen-split)
        ("C-s"     . elscreen-swap)
        ("k"       . elscreen-kill)
        ("x"       . elscreen-kill-window-or-screen)
        ("M-k"     . elscreen-kill-buffer-and-screen)
        ("g"       . elscreen-goto)
        ("h"       . split-window-horizontally)
        ("v"       . split-window-veritcally)
        ))
(when (or (daemonp) (display-graphic-p))
  (elscreen-start))


;; == yas
(use-package yasnippet
  :ensure t
  :defer  nil
  :init
  (setq yas-snippet-dirs '("~/.emacs.d/elisp/snippets"))
  (yas-global-mode 1)
  :config
 (setq yas-prompt-functions '(yas-ido-prompt
                              yas-completing-prompt
                              yas-no-prompt))
  (defun yas-force-update ()
    (interactive)
    (yas-recompile-all)
    (yas-reload-all))
  (defalias 'yas 'yas-force-update))

;; == orgalist
(use-package orgalist
  :ensure t
  :defer  t
  :bind
  (:map orgalist-mode-map
        ("M-<left>"  . nil)
        ("M-<right>" . nil)
        ("S-<up>"    . orgalist--maybe-move-up)
        ("S-<down>"  . orgalist--maybe-move-down)
        ("S-<left>"  . orgalist--maybe-outdent-tree)
        ("S-<right>" . orgalist--maybe-indent-tree)))

;; == browse-kill-ring
(use-package browse-kill-ring
  :ensure t
  :defer t
  :init
  (defalias 'bkr 'browse-kill-ring)
  (defalias 'kr  'browse-kill-ring))


;; == haskell-mode
(use-package haskell-mode
  :ensure t
  :defer t
  :init
  (add-hook 'haskell-mode-hook
            (lambda () (cedit/indent-conf 2 nil nil 80))))

(use-package magit
  :ensure t
  :defer t
  :config
  (custom-set-faces
   '(magit-diff-header                   ((t (:inherit diff-header))))
   '(magit-diff-context-highlight        ((t (:inherit diff-context))))
   '(magit-diff-removed-highlight        ((t (:inherit diff-removed))))
   '(magit-diff-refine-removed-highlight ((t (:inherit diff-refine-removed))))
   '(magit-diff-added-highlight          ((t (:inherit diff-added)))))
  )

;; == packages without config
(use-package ag                   :ensure t :defer t)
(use-package auctex               :ensure t :defer t)
(use-package dumb-jump            :ensure t :defer t)
(use-package keychain-environment :ensure t :defer t)
(use-package goto-chg             :ensure t :defer t)
(use-package go-mode              :ensure t :defer t)
(use-package lua-mode             :ensure t :defer t)
(use-package projectile           :ensure t :defer t)
(use-package iflipb               :ensure t :defer t)
(use-package puppet-mode          :ensure t :defer t)
(use-package wgrep                :ensure t :defer t)
(use-package so-long              :ensure t :defer t)
;; == ranger
(use-package ranger
  :ensure t
  :defer t
  :bind*
  ("C-x C-d" . ranger))
(defalias 'z 'ranger)
;; == diminish
(use-package diminish   ;; hide/"diminish" always enabled modes
  :ensure t
  :defer nil
  :config
  (diminish 'subword-mode) ;; iterate over camelCase
  (diminish 'yas-minor-mode)
  (diminish 'eldoc-mode)
  (diminish 'auto-fill-function))
