;; disable modes
;; enable modes
(put 'upcase-region   'disabled nil)
(put 'downcase-region 'disabled nil)
(put 'scroll-left     'disabled nil)
(put 'dired-find-alternate-file 'disabled nil)
(prefer-coding-system       'utf-8)
(set-default-coding-systems 'utf-8)
(set-terminal-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)

(set-default 'truncate-lines t) ;; dont break lines at window edge
(defvaralias 'c-basic-offset 'tab-width)
(setq-default default-input-method "rfc1345"
              frame-title-format '("" "emacs@" system-name " - %b")
              require-final-newline t
              ;; fill column
              auto-fill-function 'do-auto-fill
              fill-column 80
              ;; whitespace
              show-trailing-whitespace nil
              ;; gpg
              epg-gpg-home-directory "~/.gnupg"
              ispell-dictionary "de_AT"
              ;; tab width
              indent-tabs-mode t
              c-basic-offset 8
              sh-basic-offset 8
              tab-width 8
              c-default-style '((awk-mode  . "awk")
                                (other     . "linux"))
              backward-delete-char-untabify-method 'hungry)
;; region
(transient-mark-mode 1)
(delete-selection-mode t)
(add-hook 'before-save-hook 'delete-trailing-whitespace)

;; mouse
(setq mouse-autoselect-window t)
(xterm-mouse-mode 1)


(defun cedit/indent-conf (offset autofill tabs &optional fill)
  (setq c-basic-offset offset
        tab-width offset
        standard-indent offset
        auto-fill-mode autofill
        indent-tabs-mode tabs)
  (when (equal autofill nil)
    (auto-fill-mode -1))
  (unless (equal fill nil)
    (setq fill-column fill)))

(defun cedit/sh-indent ()
  (setq-default sh-basic-offset 8
                c-basic-offset 8
                standard-intent 8
                tab-width 8
                fill-column 80
                indent-tabs-mode nil
                auto-fill-mode t))

(defun cedit/lisp-indent ()
  (setq-default offset 2
                lisp-body-indent offset)
  (auto-fill-mode -1)
  (cedit/indent-conf offset nil nil))

;; hooks
(add-hook 'emacs-lisp-mode-hook 'cedit/lisp-indent)
(add-hook 'lisp-mode-hook       'cedit/lisp-indent)
(add-hook 'LaTeX-mode-hook      (lambda () (cedit/indent-conf 2 nil nil)))
(add-hook 'TeX-mode-hook        (lambda () (cedit/indent-conf 2 nil nil)))
(add-hook 'conf-space-mode-hook (lambda () (cedit/indent-conf 4 nil nil)))
(add-hook 'conf-mode-hook       (lambda () (cedit/indent-conf 4 nil nil)))
(add-hook 'conf-xdefaults-mode-hook
          (lambda () (cedit/indent-conf 4 nil nil)))
(add-hook 'java-mode-hook       (lambda () (cedit/indent-conf 4 t t 100)))
(add-hook 'mail-mode-hook       (lambda () (cedit/indent-conf 4 t nil 70)))
(add-hook 'sql-mode-hook        (lambda () (setq auto-fill-mode nil)))
(add-hook 'html-mode-hook       (lambda () (setq auto-fill-mode nil)))
(add-hook 'sh-mode-hook         (lambda () (cedit/sh-indent)))
(add-hook 'shell-script-mode-hook
          (lambda () (cedit/sh-indent)))
(add-hook 'sql-mode-hook        (lambda () (setq auto-fill-mode nil)))
(add-hook 'mail-mode-hook       (lambda ()
                                  (setq standard-indent 2)
                                  (cedit/indent-conf 4 t nil 70)))
(add-hook 'text-mode-hook       (lambda ()
                                  (setq standard-indent 2)
                                  (cedit/indent-conf 2 t nil 80)))
(defun guess-tab-settings ()
  (save-excursion
    (goto-char (point-min))
    (if (re-search-forward "^\t" 8192 t)
        (progn
          (setq indent-tabs-mode t)
          (message "File uses tabs for indentation"))
      (progn
        (setq indent-tabs-mode nil)
        (message "File uses spaces for indentation")))))
(add-hook 'find-file-hook 'guess-tab-settings)

(add-hook 'python-mode-hook
          (lambda ()
            (cedit/indent-conf 4 nil nil)
            (setq python-indent 4)))

(defun c-lineup-arglist-tabs-only (ignored)
  "Line up argument lists by tabs, not spaces"
  (let* ((anchor (c-langelem-pos c-syntactic-element))
         (column (c-langelem-2nd-pos c-syntactic-element))
         (offset (- (1+ column) anchor))
         (steps (floor offset c-basic-offset)))
    (* (max steps 1)
       c-basic-offset)))

(add-hook 'c-mode-hook
          (lambda ()
            (cedit/indent-conf  8 t t 80)
            (c-set-style "linux")
            (setq c-label-minimum-indentation 0)
            '(c-offsets-alist
              . ((arglist-close         . c-lineup-arglist-tabs-only)
                 (arglist-cont-nonempty . (c-lineup-gcc-asm-reg
                                           c-lineup-arglist-tabs-only))
                 (arglist-intro         . +)
                 (brace-list-intro      . +)
                 (c                     . c-lineup-C-comments)
                 (case-lbael            . 0)
                 (comment-intro         . c-lineup-comment)
                 (cpp-define-intro      . +)
                 (cpp-macro             . -1000)
                 (cpp-macro-cont        . +)
                 (defun-block-intro     . +)
                 (else-clause           . 0)
                 (func-decl-cont        . +)
                 (inclass               . +)
                 (inher-cont            . c-lineup-multi-inher)
                 (knr-argdecl-intro     . 0)
                 (label                 . -1000)
                 (statement             . 0)
                 (statement-block-intro . +)
                 (statement-case-intro  . +)
                 (statement-cont        . +)
                 (substatement          . +)))))

(add-hook 'c++-mode-hook
          (lambda ()
            (cedit/indent-conf  4 t t 120)
            (c-set-style "stroustrup")
            (setq c++-tab-always-indent t
                  c-indent-level 4
                  c-label-minimum-indentation 0
                  tab-width 4
                  indent-tabs-mode t)
            (c-set-offset 'innamespace '0)
            (c-set-offset 'inextern-lang '0)
            (c-set-offset 'inline-open '0)
            (c-set-offset 'label '*)
            (c-set-offset 'case-label '*)
            (c-set-offset 'access-label '/)))

;; misc
(global-subword-mode 1)               ; iterate through CamelCase words
(setq visible-bell nil
      ring-bell-function 'ignore ;; disable audible bell on windows
      vc-follow-symlinks t
      visible-cursor nil
      frame-inhibit-implied-resize t)

(fset 'yes-or-no-p 'y-or-n-p)

(setq auto-mode-alist
      (append auto-mode-alist
              '(("neomutt"       . mail-mode)
                ("\\.epub\\'"    . nov-mode)
                (".shrc"         . shell-script-mode)
                (".shenv"        . shell-script-mode)
                ("\\.xpm\\'"     . text-mode)
                (".Xdefaults'"   . conf-xdefaults-mode)
                (".Xresources'"  . conf-xdefaults-mode)
                ("\\gnus\\'"     . emacs-lisp-mode)
                ("\\emacs\\'"    . emacs-lisp-mode)
                ("\\conkyrc\\'"  . lua-mode)
                ("Makefile"      . makefile-gmake-mode))))

;; disable paren/$ jumping
(setq-default blink-matching-paren nil
              show-paren-mode t
              show-paren-delay 0)

(setq tramp-shell-prompt-pattern "^[^$>\n]*[#$%>] *\\(\[[0-9;]*[a-zA-Z] *\\)*")

(setq winner-dont-bind-my-keys t) ;; dont rebind keys
(winner-mode 1)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; buffer hooks
(add-hook 'minibuffer-exit-hook '(lambda ()
                                   (let ((buffer "*Completions*"))
                                     (and (get-buffer buffer)
                                          (kill-buffer buffer)))))
(defun custom-bury-buffer ()
  (if (not (or (equal (buffer-name) "*scratch*")
               (string-match "^\\(reminder\\|plan\\).org.gpg" (buffer-name))
               (string-match (concat (system-name) ".org.gpg") (buffer-name))))
      t
    (message "Not allowed to kill %s, burying instead" (buffer-name))
    (bury-buffer) nil))
(add-hook 'kill-buffer-query-functions 'custom-bury-buffer)

;; reuse compilation window even if it is in anoter frame
(add-to-list 'display-buffer-alist
             '("\\*compilaition\\*"
               . (nil (reusable-frames . visible))))

(setq backup-by-copying t   ; don't clobber symlinks
      version-control t     ; use versioned backups
      delete-old-versions t
      kept-new-versions 12
      kept-old-versions 6)

(let ((backupdir "~/.emacs.d/backup/")
      (autosavedir "~/.emacs.d/autosave/"))
  (mkdir backupdir t)
  (setq backup-directory-alist `(("." . ,backupdir)))
  (mkdir autosavedir t)
  (setq auto-save-file-name-transforms `((".*" ,autosavedir t))))
