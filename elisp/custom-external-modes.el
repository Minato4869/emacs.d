;;; external packages

;; == ace-window
(use-package ace-window
  :ensure t
  :defer  t
  :config
  (setq aw-keys '(?a ?s ?d ?f ?g ?h ?j ?k ?l))
  :bind
  (("C-c o" . ace-window)))

;; == elscreen
(use-package elscreen
  :if (my_daemonp)
  :ensure t
  :defer  t
  :config
  (custom-set-faces
   '(elscreen-tab-background-face     ((t (:background "#292929" :foreground "#bebebe"))))
   '(elscreen-tab-control-face        ((t (:inherit elscreen-tab-background-face))))
   '(elscreen-tab-other-screen-face   ((t (:inherit elscreen-tab-background-face))))
   '(elscreen-tab-current-screen-face ((t (:background "#666666" :foreground "#e5e5e5")))))
  (setq elscreen-prefix-key "\M-s")
  (custom-set-variables
   '(elscreen-display-screen-number t)
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
      (when (y-or-n-p "Kill window? ")
        (delete-window))))
  :bind*
  (("M-<left>"     . elscreen-previous)
   ("M-<right>"    . elscreen-next)
   ("ESC <left>"   . elscreen-previous)
   ("ESC <right>"  . elscreen-next))
  (:map elscreen-map
        ("<left>"  . elscreen-previous)
        ("<right>" . elscreen-next)
        ("M-s"     . elscreen-toggle)
        ("s"       . elscreen-toggle)
        ("C-s"     . elscreen-split)
        ("4"       . elscreen-screen-nickname)
        ("r"       . elscreen-screen-nickname)
        ("S"       . elscreen-swap)
        ("k"       . elscreen-kill)
        ("x"       . elscreen-kill-window-or-screen)
        ("M-k"     . elscreen-kill-buffer-and-screen)
        ("g"       . elscreen-goto)
        ("t"       . elscreen-toggle-display-tab)
        ("h"       . split-window-horizontally)
        ("v"       . split-window-veritcally)
        ))
(when (daemonp)
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

;; == diminish
(use-package diminish   ;; hide/"diminish" always enabled modes
  :ensure t
  :defer nil
  :config
  (diminish 'subword-mode) ;; iterate over camelCase
  (diminish 'yas-minor-mode)
  (diminish 'eldoc-mode)
  (diminish 'auto-fill-function))

;; == mu4e
(when (file-directory-p "/usr/share/emacs/site-lisp/mu4e")
  (use-package mu4e
    :ensure nil
    :defer nil
    :init
    (add-to-list 'load-path "/usr/share/emacs/site-lisp/mu4e")
    (when(or (daemonp) (display-graphic-p))
        (load-library "mu4e"))
    :config
    (setq mail-user-agent 'mu4e-user-agent
          mu4e-sent-folder   "/Sent"
          mu4e-drafts-folder "/Drafts"
          mu4e-trash-folder  "/Trash"
          message-send-mail-function   nil
          smtpmail-default-smtp-server nil
          smtpmail-smtp-server         nil
          smtpmail-local-domain        nil)
    (custom-set-faces
     '(mu4e-header-highlight-face       ((t (:background "#AF8700" :foreground "#000000" :bold nil))))
     '(mu4e-unread-face                 ((t (:foreground "#0087FF" :bold nil))))
     '(mu4e-replied-face                ((t (:foreground "#4286F4" :bold t))))
     '(mu4e-header-face                 ((t (:foreground "#585858" :bold nil))))
     '(mu4e-header-key-face             ((t (:foreground "#585858" :bold nil))))
     )
))
(defun my-mu4e ()
  (interactive)
  (load-library "mu4e")
  (if (or (daemonp) (display-graphic-p))
      (progn
        (elscreen-create)
        (mu4e))
    (mu4e)))
(defalias 'mu   'my-mu4e)
(defalias 'mail 'my-mu4e)

;; ==ripgrep
(use-package rg
  :ensure t
  :defer t)
(defalias 'ag 'rg)

(use-package yaml-mode
  :ensure nil
  :defer nil)
(defalias 'yml 'yaml-mode)

(require 'yaml-mode)

;; == interesting packages:
;; narrowed-page-navigation

;; == packages without config
(use-package auctex               :ensure t :defer t :pin gnu)
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
