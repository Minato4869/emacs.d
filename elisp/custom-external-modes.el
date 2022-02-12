;;; external packages
;; == elscreen
(use-package elscreen
  :if (daemonp)
  :ensure t
  :defer  nil
  :config
  (setq-default elscreen-prefix-key "\M-s")
  (defun elscreen-kill-window-then-screen ()
    (interactive)
    (if (one-window-p)
        (elscreen-kill)
      (delete-window)))
  (custom-set-variables
   '(elscreen-tab-display-kill-screen nil)
  '(elscreen-display-tab t)
  '(elscreen-display-screen-number nil))
  (defun elscreen-kill-buffer-and-screen ()
    (interactive)
    (when (y-or-n-p "Kill current buffer and close screen? ")
      (kill-current-buffer)
      (elscreen-kill)))
  (elscreen-start)
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
        ("S"       . elscreen-toggle)
        ("C-s"     . elscreen-split)
        ("4"       . elscreen-screen-nickname)
        ("r"       . elscreen-screen-nickname)
        ("s"       . elscreen-swap)
        ("k"       . elscreen-kill)
        ("x"       . elscreen-kill-window-then-screen)
        ("M-k"     . elscreen-kill-buffer-and-screen)
        ("g"       . elscreen-goto)
        ("t"       . elscreen-toggle-display-tab)
        ("h"       . split-window-horizontally)
        ("v"       . split-window-veritcally)
        ))

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
  (defalias 'bkr 'browse-kill-ring))

(use-package magit
  :if (my_daemonp)
  :ensure t
  :defer t
  :config
  (custom-set-faces
   '(magit-diff-header                   ((t (:inherit diff-header))))
   '(magit-diff-context-highlight        ((t (:inherit diff-context))))
   '(magit-diff-removed-highlight        ((t (:inherit diff-removed))))
   '(magit-diff-refine-removed-highlight ((t (:inherit diff-refine-removed))))
   '(magit-diff-added-highlight          ((t (:inherit diff-added))))))

;; == diminish
(use-package diminish   ;; hide/"diminish" always enabled modes
  :ensure t
  :defer nil
  :config
  (diminish 'subword-mode) ;; iterate over camelCase
  (diminish 'yas-minor-mode)
;;  (diminish 'auto-fill-function)
  (diminish 'eldoc-mode))
;; == mu4e
(let ((mupath (if (string= system-type "berkeley-unix")
                  "/usr/local/share/emacs/site-lisp/mu4e"
                "/usr/eshare/emacs/site-lisp/mu4e")))
  (use-package mu4e
    :if (file-directory-p mupath)
    :ensure nil
    :defer nil
    :config
    (setq mail-user-agent 'mu4e-user-agent
          mu4e-sent-folder   "/Sent"
          mu4e-drafts-folder "/Drafts"
          mu4e-trash-folder  "/Archive/trash"
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
    )
  (defalias 'mail 'mu4e)
  (defalias 'mu   'mu4e)
  (when (daemonp)
    (add-to-list 'load-path mupath)
    (load-library "mu4e")))
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
;;(use-package auctex               :ensure t :defer t :pin gnu)
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
(use-package rainbow-delimiters   :ensure t :defer t)
(use-package haskell-mode         :ensure t :defer t)
