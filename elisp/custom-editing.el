(put 'upcase-region 'disabled nil)
(put 'downcase-region 'disabled nil)
(put 'scroll-left 'disabled nil)

(prefer-coding-system 'utf-8)
(set-default-coding-systems 'utf-8)
(set-terminal-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)
(setq default-input-method "rfc1345")

(setq frame-title-format '("" "emacs@" system-name " - %b"))
(setq require-final-newline t)
(set-default 'truncate-lines t)
;; region
(transient-mark-mode 1)
(delete-selection-mode t)

;; fill column
(setq-default auto-fill-function 'do-auto-fill)
(setq-default fill-column 80)

;; whitespace
(setq-default show-trailing-whitespace nil)
(add-hook 'before-save-hook 'delete-trailing-whitespace)

;; gpg
(setq-default epg-gpg-home-directory "~/.gnupg")

;; tab width
(setq-default indent-tabs-mode t
              tab-width 8
              c-default-style '((awk-mode  . "awk")
                                (other     . "linux"))
              backward-delete-char-untabify-method 'hungry)
(defvaralias 'c-basic-offset 'tab-width)
;; mouse
(setq mouse-autoselect-window t)
(xterm-mouse-mode 1)

;; mode indentation
(setq-default c-basic-offset 8)
(setq-default sh-basic-offset 8)
(defun cedit/indent-conf (offset autofill tabs &optional fill)
  (setq c-basic-offset offset
        tab-width offset
        auto-fill-mode autofill
        indent-tabs-mode tabs)
  (when (equal autofill nil)
    (auto-fill-mode -1))
  (unless (equal fill nil)
    (setq fill-column fill)))

(defun cedit/sh-indent ()
  (setq-default sh-basic-offset 8
                c-basic-offset 8
                tab-width 8
                fill-column 80
                indent-tabs-mode nil
                auto-fill-mode t))

(defun cedit/lisp-indent ()
  (setq offset 2
        lisp-body-indent offset)
  (auto-fill-mode -1)
  (cedit/indent-conf offset nil nil))

;; hooks
(add-hook 'emacs-lisp-mode-hook 'cedit/lisp-indent)
(add-hook 'lisp-mode-hook       'cedit/lisp-indent)
(add-hook 'LaTeX-mode-hook      (lambda () (cedit/indent-conf 2 nil nil)))
(add-hook 'TeX-mode-hook        (lambda () (cedit/indent-conf 2 nil nil)))
(add-hook 'haskell-mode-hook    (lambda () (cedit/indent-conf 2 nil nil 80)))
(add-hook 'conf-space-mode-hook (lambda () (cedit/indent-conf 4 nil nil)))
(add-hook 'conf-mode-hook       (lambda () (cedit/indent-conf 4 nil nil)))
(add-hook 'conf-xdefaults-mode-hook
                                (lambda () (cedit/indent-conf 4 nil nil)))
(add-hook 'java-mode-hook       (lambda () (cedit/indent-conf 4 t t)))
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

(use-package org
  :defer t
  :config
  (progn
    (setq org-highlight-latex-and-related
          '(latex script entities)
          indent-rigidly t
          org-src-fontify-natively t
          org-src-tab-acts-natively t
          org-confirm-babel-evaluate nil
          org-edit-preserve-indentation nil
          org-edit-src-content-indentation 0)
    (cedit/indent-conf 2 nil nil))
    :bind
    (("C-c C-c" . org-latex-export-to-pdf)
     ("C-c c"   . org-export-dispatch)))

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
            (cedit/indent-conf 8 t t)
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

;; misc
(global-subword-mode 1)               ; iterate through CamelCase words
(setq visible-bell nil)
(setq ring-bell-function 'ignore);; disable audible bell on windows
(setq vc-follow-symlinks t)
(setq visible-cursor nil)
(fset 'yes-or-no-p 'y-or-n-p)
(setq auto-mode-alist
      (append auto-mode-alist
              '(("neomutt"      . mail-mode)
                ("\\.epub\\'"   . nov-mode)
                (".shrc"        . shell-script-mode)
                (".shenv"       . shell-script-mode)
                ("\\.xpm\\'"    . text-mode)
                (".fvwm2rc'"    . conf-mode)
                (".Xdefaults'"  . conf-xdefaults-mode)
                (".Xresources'" . conf-xdefaults-mode)
                ("\\gnus\\'"    . emacs-lisp-mode)
                ("Makefile"     . makefile-gmake-mode))))

(setq frame-inhibit-implied-resize t)

;; disable paren/$ jumping
(setq-default blink-matching-paren nil)
(setq-default show-paren-mode t)
(setq-default show-paren-delay 0)

(setq tramp-shell-prompt-pattern "^[^$>\n]*[#$%>] *\\(\[[0-9;]*[a-zA-Z] *\\)*")

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
