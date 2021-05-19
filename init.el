(setq gc-cons-threshold 64000000)
(add-hook
 'after-init-hook
 #'(lambda ()
     (setq gc-cons-threshold 800000))) ;; restore after startup
                                        ;
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
   '(ace-window notmuch puppet-mode yasnippet use-package magit
                keychain-environment haskell-mode diminish
                auctex))
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
(defun load-library-wrap-error (lib)
  "Load library lib and catch any errors that it might throw.
Errors will be logged to the buffer *Init Errors*"
  (condition-case err (load-library lib)
    (error
     (progn
       (switch-to-buffer "*Init Errors*")
       (let (buf (get-buffer-create "*Init Errors*"))
         (with-temp-buffer
           (erase-buffer) (insert "Error in '" lib
                                  ":\n  " (error-message-string err) "\n")
           (print "**")
           (print (car err))
           (append-to-buffer "*Init Errors*" (point-min) (point-max))))))))
(load-library-wrap-error "custom-editing")
(load-library-wrap-error "custom-keys")
(load-library-wrap-error "custom-functions")
(load-library-wrap-error "custom-internal-modes")

(when (or (daemonp) (display-graphic-p))
  (tooltip-mode -1)
  (display-time-mode t)
  (display-battery-mode t)

  (load-library-wrap-error "custom-terminal-mode")
  (load-library-wrap-error "custom-font-mode")

  (setq confirm-kill-emacs 'yes-or-no-p)

  (when (daemonp)
		(keychain-refresh-environment)
		(load-library-wrap-error "custom-desktop-save")
		(let ((ln "~/.emacs.local.el")
					(pl "~/.local/emacs.personal.el"))
			(when (file-regular-p ln)
				(load-file ln))
			(when (file-regular-p pl)
				(load-file pl)))
		))

(load-library-wrap-error "custom-external-modes")
(load-library-wrap-error "custom-aliases")
(load-library-wrap-error "custom-theme")
