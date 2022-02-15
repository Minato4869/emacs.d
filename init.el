(setq gc-cons-threshold 64000000)
(add-hook
 'after-init-hook
 #'(lambda ()
     (setq gc-cons-threshold 800000))) ;; restore after startup
(custom-set-variables
 '(initial-scratch-message ";; Unfortunately, there's a radio connected to my brain
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
 '(diff-switches "-urN") ;; no separators; use +/- instead of >/<, unify
 '(dired-auto-revert-buffer t)
 '(whitespace-style
   '(face trailing tabs spaces lines newline empty indentation space-after-tab
          space-before-tab space-mark tab-mark))
 '(blink-cursor-mode nil)
 '(inhibit-startup-screen t)
 '(scroll-error-top-bottom t)
 '(show-paren-mode t)
 '(menu-bar-mode nil)
 '(tooltip-mode nil)
 '(use-dialog-box nil)
 '(default-input-method "rfc1345")
 '(require-final-newline t)
 '(auto-fill-mode -1)
 '(fill-column 80)
 '(show-trailing-whitespace nil)
 '(line-move-visual nil)
 '(epg-gpg-home-directory "~/.gnupg")
 '(indent-tabs-mode t)
 '(c-basic-offset 8)
 '(sh-basic-offset 8)
 '(tab-width 8)
 '(c-default-style '((awk-mode  . "awk")  (other     . "linux")))
 '(backward-delete-char-untabify-method 'hungry)
 '(ispell-dictionary "en_GB")
 '(frame-title-format (if (daemonp)
                          '("" "emacsclient@" system-name " - %b")
                        '("" "emacs@" system-name " - %b")))
 '(visible-bell nil)
 '(ring-bell-function 'ignore) ;; disable audible bell on windows
 '(vc-follow-symlinks nil)
 '(visible-cursor nil)
 '(frame-inhibit-implied-resize t)
 '(tramp-shell-prompt-pattern "^[^$>\n]*[#$%>] *\\(\[[0-9;]*[a-zA-Z] *\\)*")
 '(blink-matching-paren nil) ;; disable paren/$ jumping
 '(show-paren-mode t)
 '(show-paren-delay 0) ;; immediately show parens
 '(mouse-autoselect-window t)
 '(electric-indent-mode t)
 '(xterm-mouse-mode 0)
 '(mouse-yank-at-point t)
 '(savehist-mode 1)
 '(transient-mark-mode t)
 '(delete-selection-mode t)
 '(global-subword-mode 1)               ; iterate through CamelCase words
 '(winner-mode 1)
 '(winner-dont-bind-my-keys t) ;; dont rebind keys
 '(ps-paper-type 'a4)
 '(ps-print-color-p 'black-white)
 '(shift-select-mode nil)
 '(custom-file "~/.emacs.d/.custom.el")
 '(line-move-visual t)
 '(default-frame-alist '((width . 80) (height . 57)))
 '(initial-frame-alist default-frame-alist)
 )

(defun my_daemonp()
  (if (or (daemonp) (display-graphic-p)) t nil))

(defun is_ssh ()
  (if (= (length (getenv "SSH_CONNECTION")) 0) nil t))


(setq gnutls-algorithm-priority "NORMAL:-VERS-TLS1.3")
(package-initialize)
(setq package-archives nil)
(defvar gnu-archive   '("gnu"   . "https://elpa.gnu.org/packages/"))
(defvar elpa-archive  '("elpa"  . "https://elpa.gnu.org/packages/"))
(defvar melpa-archive '("melpa" . "https://melpa.org/packages/"))
(push elpa-archive  package-archives)
(push gnu-archive   package-archives)
(push melpa-archive package-archives)
(setq package-archives (nreverse package-archives))
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

(require 'use-package)
(require 'bind-key)
(setq use-package-verbose t
      use-package-always-ensure t)
;; paths
(let ((basedir "~/.emacs.d/elisp/"))
  (add-to-list 'load-path basedir)
  (add-to-list 'load-path (concat basedir "external"))
  (add-to-list 'custom-theme-load-path (concat basedir "themes")))

;; custom files
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
(when (my_daemonp)
  (setq confirm-kill-emacs 'yes-or-no-p)
  (load-library-wrap-error "custom-font-mode"))
(load-library-wrap-error "custom-external-modes")

(load-library-wrap-error "custom-terminal-mode")
(load-library-wrap-error "custom-frame")
(load-library-wrap-error "custom-theme")
;;(load-library-wrap-error "custom-colours")
(load-library-wrap-error "custom-aliases")

(when (daemonp)
;;  (load-library-wrap-error "custom-desktop-save")
  (load-library-wrap-error "custom-emacsclient"))

(let ((ln "~/.emacs.local.el")
      (pl "~/.emacs.personal.el"))
  (when (file-regular-p pl) (load-file pl))
  (when (file-regular-p ln) (load-file ln)))

(setq backup-by-copying t   ; don't clobber symlinks
      version-control t     ; use versioned backups
      delete-old-versions t
      kept-new-versions 12
      kept-old-versions 6)

(let ((backupdir "~/.emacs.d/backup/")
      (autosavedir "~/.emacs.d/autosave/"))
  (mkdir backupdir t)
  (mkdir autosavedir t)
  (setq backup-directory-alist `(("." . ,backupdir))
        auto-save-file-name-transforms `((".*" ,autosavedir t))))
