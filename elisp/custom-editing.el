;; disable modes
(put 'compose-mail           'disabled t)
(put 'mouse-wheel-text-scale 'disabled t)
(put 'mouse-appearance-menu  'disabled t)
(put 'kmacro-end-call-mouse  'disabled t)
(put 'overwrite-mode         'disabled t)

(put 'org-archive-set-tag                           'disabled t)
(put 'org-archive-subtree                           'disabled t)
(put 'org-archive-subtree-default                   'disabled t)
(put 'org-archive-subtree-default-with-confirmation 'disabled t)
(put 'org-archive-to-archive-sibling                'disabled t)

;; enable modes
(put 'upcase-region             'disabled nil)
(put 'scroll-left               'disabled nil)
(put 'downcase-region           'disabled nil)
(put 'dired-find-alternate-file 'disabled nil)
(put 'narrow-to-page            'disabled nil)
(put 'narrow-to-region          'disabled nil)
(put 'eval-expression           'disabled nil)
(put 'set-goal-column           'disabled nil)

(prefer-coding-system       'utf-8)
(set-default-coding-systems 'utf-8)
(set-terminal-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)

(defvar uniquify-buffer-name-style) ;; unique buffer names
(defvaralias 'c-basic-offset 'tab-width)

(fset 'yes-or-no-p 'y-or-n-p)

;; region
(add-hook 'before-save-hook 'delete-trailing-whitespace)

(defun cedit/indent-code (offset tabs fc &optional nofill stdi)
  (setq c-basic-offset offset
        tab-width offset
        standard-indent offset
        indent-tabs-mode tabs
        fill-column fc)
  (unless nofill  (turn-on-auto-fill))
  (when stdi      (setq standard-indent stdi)))

(defun cedit/indent-text ()
  (cedit/indent-code 4 nil 120 t))

(defun cedit/sh-indent ()
  (setq sh-basic-offset 8)
  (cedit/indent-code 8 nil 80))

(defun cedit/lisp-indent ()
  (setq lisp-body-indent 2)
  (cedit/indent-code 2 nil 80 t))

(defun cedit/latex ()
       (cedit/indent-code 4 nil 80 t)
       (electric-indent-local-mode -1))

;; hooks
(add-hook 'minibuffer-setup-hook    (lambda () (setq truncate-lines nil)))
(add-hook 'emacs-lisp-mode-hook     'cedit/lisp-indent)
(add-hook 'lisp-mode-hook           'cedit/lisp-indent)
(add-hook 'LaTeX-mode-hook          (lambda () (cedit/indent-latex)))
(add-hook 'latex-mode-hook          (lambda () (cedit/indent-latex)))
(add-hook 'plain-TeX-mode-hook      (lambda () (cedit/indent-latex)))

(add-hook 'java-mode-hook           (lambda () (cedit/indent-code 4 t   100)))
(add-hook 'make-mode-hook           (lambda () (cedit/indent-code 4 t    80)))
(add-hook 'sql-mode-hook            (lambda () (cedit/indent-code 4 nil 120 t)))
(add-hook 'html-mode-hook           (lambda () (cedit/indent-code 4 nil 120 t)))
(add-hook 'python-mode-hook         (lambda () (cedit/indent-code 4 nil  80)
                                               (setq python-indent 4)))
(add-hook 'conf-space-mode-hook     (lambda () (cedit/indent-code 4 nil  80)))
(add-hook 'conf-mode-hook           (lambda () (cedit/indent-code 4 nil  80)))
(add-hook 'conf-xdefaults-mode-hook (lambda () (cedit/indent-code 4 nil  80)))

(add-hook 'sh-mode-hook             (lambda () (cedit/sh-indent)))
(add-hook 'shell-script-mode-hook   (lambda () (cedit/sh-indent)))

(add-hook 'makefile-mode-hook       (lambda () (cedit/indent-code 4 t 80)))
(add-hook 'makefile-gmake-mode-hook (lambda () (cedit/indent-code 4 t 80)))
(add-hook 'mail-mode-hook           (lambda () (cedit/indent-code 4 nil 70 nil 2)
                                               (setq ispell-dictionary "de_AT")
                                               (mail-text)))
(add-hook 'text-mode-hook           (lambda () (cedit/indent-code 2 nil  80 nil 2)))
(add-hook 'org-mode-hook            (lambda () (cedit/indent-code 2 nil 80 t   2)))
;; external modes
(add-hook 'haskell-mode-hook        (lambda () (cedit/indent-code 2 nil 80 t)))


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
            (cedit/indent-code  8 t 80)
            (c-set-style "linux")
            (setq c-label-minimum-indentation 0)
            '(c-offsets-alist
              . ((arglist-close         . c-lineup-arglist-tabs-only)
                 (arglist-cont-nonempty . (c-lineup-gcc-asm-reg
                                           c-lineup-arglist-tabs-only))
                 (arglist-intro         . +)
                 (brace-list-intro      . +)
                 (c-ignore-auto-fill    . '(string))
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
            (cedit/indent-code  4 t 100)
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


(setq auto-mode-alist
      (append auto-mode-alist
              '(("neomutt"       . mail-mode)
                ("mutt"          . mail-mode)
                ("muttrc."       . conf-mode)
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

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; buffer hooks
(add-hook 'minibuffer-exit-hook '(lambda ()
                                   (let ((buffer "*Completions*"))
                                     (and (get-buffer buffer)
                                          (kill-buffer buffer)))))
(defun custom-bury-buffer ()
  (if (or (string-match (buffer-name) "*scratch*")
          (string-match (buffer-name) "reminder.org.gpg"))
      (progn  (message "Not allowed to kill %s, burying instead" (buffer-name))
              (bury-buffer))
    t))

(add-hook 'kill-buffer-query-functions 'custom-bury-buffer)
;; (remove-hook 'kill-buffer-query-functions 'custom-bury-buffer)

;; reuse compilation window even if it is in anoter frame
(add-to-list 'display-buffer-alist
             '("\\*compilaition\\*"
               . (nil (reusable-frames . visible))))
