(setq gc-cons-threshold 64000000)
(add-hook
 'after-init-hook
 #'(lambda ()
     (setq gc-cons-threshold 800000))) ;; restore after startup

(custom-set-variables
 '(initial-scratch-message
";; Unfortunately, there's a radio connected to my brain
;; Actually, it's the BBC controlling us from London.

")
 '(battery-mode-line-format " [%b%p%%] ")
 '(display-time-default-load-average nil)
 '(display-time-format "%Y-%m-%d %H:%M")
 '(display-time-mail-string "")
 '(display-time-24hr-format t)
 '(display-time-day-and-date t)
 '(size-indication-mode t)
 '(column-number-mode t)
 '(package-selected-packages
   (quote
    (ag use-package bind-key diminish keychain-environment yasnippet haskell-mode flx auctex)))
 '(blink-cursor-mode nil)
 '(inhibit-startup-screen t)
 '(scroll-error-top-bottom t)
 '(show-paren-mode t)
 '(menu-bar-mode nil)
 '(use-dialog-box nil))

(setq gnutls-algorithm-priority "NORMAL:-VERS-TLS1.3")

(package-initialize)
(add-to-list 'package-archives
             '("melpa" . "https://melpa.org/packages/"))
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install-selected-packages))

(require 'use-package)
(require 'bind-key)

(setq use-package-verbose t
      use-package-always-ensure t)

(setq exec-path (append "~/bin" exec-path))
(add-to-list 'load-path "~/.emacs.d/elisp")
(add-to-list 'custom-theme-load-path
             (file-name-as-directory "~/.emacs.d/elisp/themes"))

(setq yas-snippet-dirs '("~/.emacs.d/elisp/snippets"))
(yas-global-mode 1)

(setq custom-file "~/.emacs.d/elisp/custom.el")
(load-library "custom-load-file")
(load-library-wrap-error "custom-editing")
(load-library-wrap-error "custom-dired-mode")
(load-library-wrap-error "custom-ido-mode")
(load-library-wrap-error "custom-keys")
(load-library-wrap-error "custom-ibuffer")
(load-library-wrap-error "custom-functions")
(load-library-wrap-error "custom-buffer-mode")
(load-library-wrap-error "custom-compile")
(when (or (daemonp) (display-graphic-p))
  (unless (file-directory-p "~/git/dotfiles/x11/Xresources")
    (menu-bar-mode -1)
    (scroll-bar-mode -1)
    (tool-bar-mode -1))
  (savehist-mode 1)
  (tooltip-mode -1)
  (display-time-mode t)
  (display-battery-mode t)

  (keychain-refresh-environment)

  (load-library-wrap-error "custom-font-mode")
  (load-library-wrap-error "custom-terminal-mode")
  (load-library-wrap-error "custom-tex")
  (load-library-wrap-error "custom-theme-switch")
  (load-library-wrap-error "custom-x11-keys"))

(load-library-wrap-error "custom-theme")
(load-library-wrap-error "custom-diminish-mode")
(load-library-wrap-error "custom-aliases")
;; manage backups/autosaves
(load-library "backup-autosave")
