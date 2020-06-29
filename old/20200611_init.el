(custom-set-variables
 '(display-battery-mode t)
 '(battery-mode-line-format " [%b%p%%] ")
 '(blink-cursor-mode nil)
 '(column-number-mode t)
 '(cua-mode nil nil (cua-base))
 '(display-time-24hr-format t)
 '(display-time-day-and-date t)
 '(display-time-default-load-average nil)
 '(display-time-format "%H:%M")
 '(display-time-mode t)
 '(inhibit-startup-screen t)
 '(menu-bar-mode nil)
 '(package-selected-packages
	 (quote
		(diminish keychain-environment yasnippet haskell-mode flx auctex)))
 '(scroll-bar-mode (quote nil))
 '(show-paren-mode t)
 '(size-indication-mode t)
 '(tool-bar-mode nil)
 '(tooltip-mode nil)
 '(use-dialog-box nil))

(savehist-mode 1)
(add-to-list 'load-path "~/.emacs.d/elisp")
(require 'package)
(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/"))
(package-initialize)

(setq exec-path (append '("~/.bin" "~/bin") exec-path))
(add-to-list
 'custom-theme-load-path
 (file-name-as-directory "~/.emacs.d/elisp/themes"))

(keychain-refresh-environment)

(ido-mode t)
(setq ido-enable-flex-matching t)
(ido-everywhere t)
(setq ido-auto-merge-work-directories-length -1)
(setq ido-default-buffer-method 'selected-window)
(setq ido-default-file-method 'selected-window)

(setq yas-snippet-dirs '("~/.emacs.d/elisp/snippets"))
(yas-global-mode 1)

(setq custom-file "~/.emacs.d/elisp/custom.el")
(load-library "custom-load-file")
(load-library-wrap-error "custom-editing")
(load-library-wrap-error "custom-functions")
(load-library-wrap-error "custom-x11")
(load-library-wrap-error "custom-buffer-mode")
(load-library-wrap-error "custom-diminish-mode")
(load-library-wrap-error "custom-dired-mode")
(load-library-wrap-error "custom-font-mode")
(load-library-wrap-error "custom-ibuffer")
(load-library-wrap-error "custom-keys")
(load-library-wrap-error "custom-terminal-mode")
(load-library-wrap-error "custom-tex")
(load-library-wrap-error "custom-aliases")
(load-library-wrap-error "custom-theme-switch")
(load-library-wrap-error "custom-theme")
;; manage backups/autosaves
(load-library "backup-autosave")
