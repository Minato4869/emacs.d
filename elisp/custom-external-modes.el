;;; external packages
;; == elscreen
(use-package elscreen
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
  '(elscreen-display-screen-number t))
  (defun elscreen-kill-buffer-and-screen ()
    (interactive)
    (when (y-or-n-p "Kill current buffer and close screen? ")
      (kill-current-buffer)
      (elscreen-kill)))
  (when (daemonp)
    (elscreen-start))
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
;;(use-package mu4e
;;  :if (and (my_daemonp)
;;           (or (file-directory-p "/usr/share/emacs/site-lisp/mu4e")
;;               (file-directory-p "/usr/local/share/emacs/site-lisp/mu4e")))
;;  :ensure nil
;;  :defer nil
;;  :config
;;  (setq mail-user-agent 'mu4e-user-agent
;;        mu4e-sent-folder   "/Sent"
;;        mu4e-drafts-folder "/Drafts"
;;        mu4e-trash-folder  "/Archive/trash"
;;        message-send-mail-function   nil
;;        smtpmail-default-smtp-server nil
;;        smtpmail-smtp-server         nil
;;          smtpmail-local-domain        nil))
;;(defalias 'mail 'mu4e)
;;(defalias 'mu   'mu4e)
;;(when (my_daemonp)
;;    (load-library "mu4e"))
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
(use-package magit :if (my_daemonp) :ensure t :defer t)
(use-package howm                 :ensure t :defer t)
