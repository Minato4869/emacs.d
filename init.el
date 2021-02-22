(setq gc-cons-threshold 64000000)
(add-hook
 'after-init-hook
 #'(lambda ()
     (setq gc-cons-threshold 800000))) ;; restore after startup
;; custom
(custom-set-variables
 '(initial-scratch-message
   ";; Unfortunately, there's a radio connected to my brain
;; Actually, it's the BBC controlling us from London.

")
 '(battery-mode-line-format " [%b%p%%]")
 '(display-time-default-load-average nil)
 '(display-time-format "%H:%M")
 '(display-time-mail-string "")
 '(display-time-24hr-format t)
 '(display-time-day-and-date t)
 '(size-indication-mode t)
 '(column-number-mode t)
 '(package-selected-packages
   (quote
    (ace-window notmuch puppet-mode yasnippet use-package keychain-environment
                haskell-mode diminish auctex)))
 '(whitespace-style
   '(face trailing tabs spaces lines newline empty indentation space-after-tab
          space-before-tab space-mark tab-mark))
 '(blink-cursor-mode nil)
 '(inhibit-startup-screen t)
 '(scroll-error-top-bottom t)
 '(show-paren-mode t)
 '(menu-bar-mode nil)
 '(use-dialog-box nil))

(savehist-mode 1)
(setq gnutls-algorithm-priority "NORMAL:-VERS-TLS1.3")
(package-initialize)
(setq package-archives nil)
(defvar gnu-archive   '("gnu"   . "https://elpa.gnu.org/packages/"))
(defvar elpa-archive  '("elpa"  . "https://elpa.gnu.org/packages/"))
(defvar melpa-archive '("melpa" . "https://melpa.org/packages/"))
(push elpa-archive package-archives)
(push gnu-archive package-archives)
(push melpa-archive package-archives)
(setq package-archives (nreverse package-archives))
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install-selected-packages))

(require 'use-package)
(require 'bind-key)

(setq use-package-verbose t
      use-package-always-ensure t)
;; paths
(let ((basedir "~/.emacs.d/elisp/"))
  (add-to-list 'load-path basedir)
  (add-to-list 'custom-theme-load-path (concat basedir "themes")))

(setq yas-snippet-dirs '("~/.emacs.d/elisp/snippets"))
(yas-global-mode 1)
;; custom files
(setq custom-file "~/.emacs.d/.custom.el")
(load-library            "custom-load-file")
(load-library-wrap-error "custom-editing")
(load-library-wrap-error "custom-keys")
(load-library-wrap-error "custom-dired-mode")
(load-library-wrap-error "custom-ido-mode")
(load-library-wrap-error "custom-ibuffer")
(load-library-wrap-error "custom-functions")
(load-library-wrap-error "custom-buffer-mode")
(load-library-wrap-error "custom-compile")
(load-library-wrap-error "custom-tex")
(load-library-wrap-error "custom-ag")
(load-library-wrap-error "custom-notmuch")
(load-library-wrap-error "custom-diminish-mode")

(when (or (daemonp) (display-graphic-p))
  (unless (file-directory-p "~/git/dotfiles/x11/Xresources")
    (menu-bar-mode -1)
    (scroll-bar-mode -1)
    (tool-bar-mode -1))

  (tooltip-mode -1)
  (display-time-mode t)
  (display-battery-mode t)

  (keychain-refresh-environment)

  (load-library-wrap-error "custom-terminal-mode")
  (load-library-wrap-error "custom-font-mode")
  (load-library-wrap-error "custom-x11-keys")
  (unless (file-directory-p "~/.altwm")
    (load-library-wrap-error "custom-xmonad-keys"))

  (when (daemonp)
    (find-file-noselect "~/reminder.org")))
(load-library-wrap-error "custom-ace-window")
(load-library-wrap-error "custom-theme")
(load-library-wrap-error "custom-aliases")
;; manage backups/autosaves
(load-library "backup-autosave")
