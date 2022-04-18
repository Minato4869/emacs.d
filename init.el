;;; (occur "^;; ===")
(setq gc-cons-threshold 64000000)
(add-hook
 'after-init-hook
 #'(lambda ()
     (setq gc-cons-threshold 800000))) ;; restore after startup

(defun my_daemonp()
  (if (or (daemonp) (display-graphic-p)) t nil))

(defun is_ssh ()
  (if (= (length (getenv "SSH_CONNECTION")) 0) nil t))
(defun is_ttf ()
  (string-match "PfEd" (prin1-to-string (face-attribute 'default :font))))
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
(let ((basedir "~/.emacs.d/"))
  (add-to-list 'load-path (concat basedir "elisp")))

;; custom files

;; === editing =================================================================
;; disable modes
(put 'compose-mail                                  'disabled t)
(put 'mouse-wheel-text-scale                        'disabled t)
(put 'mouse-appearance-menu                         'disabled t)
(put 'kmacro-end-call-mouse                         'disabled t)
(put 'overwrite-mode                                'disabled t)
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

(defun cedit/indent-code (offset tabs fc &optional fill stdi)
  (setq c-basic-offset offset
        tab-width offset
        standard-indent offset
        indent-tabs-mode tabs
        fill-column fc)
  (when fill      (turn-on-auto-fill))
  (when stdi      (setq standard-indent stdi)))

(defun cedit/indent-text ()
  (cedit/indent-code 4 nil 120 t))

(defun cedit/sh-indent ()
  (setq sh-basic-offset 8)
  (cedit/indent-code 8 nil 80))

(defun cedit/lisp-indent ()
  (setq lisp-body-indent 2)
  (cedit/indent-code 2 nil 80))

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

(add-hook 'java-mode-hook           (lambda () (cedit/indent-code 4 t   100 t)))
(add-hook 'make-mode-hook           (lambda () (cedit/indent-code 4 t    80 t)))
(add-hook 'sql-mode-hook            (lambda () (cedit/indent-code 4 nil 120)))
(add-hook 'html-mode-hook           (lambda () (cedit/indent-code 4 nil 120)))
(add-hook 'python-mode-hook         (lambda () (cedit/indent-code 4 nil  80 t)
                                      (setq python-indent 4)))
(add-hook 'conf-space-mode-hook     (lambda () (cedit/indent-code 4 nil  80)))
(add-hook 'conf-mode-hook           (lambda () (cedit/indent-code 4 nil  80)))
(add-hook 'conf-xdefaults-mode-hook (lambda () (cedit/indent-code 4 nil  80)))

(add-hook 'sh-mode-hook             (lambda () (cedit/sh-indent t)))
(add-hook 'shell-script-mode-hook   (lambda () (cedit/sh-indent t)))

(add-hook 'makefile-mode-hook       (lambda () (cedit/indent-code 4 t 80 t)))
(add-hook 'makefile-gmake-mode-hook (lambda () (cedit/indent-code 4 t 80 t)))
(add-hook 'mail-mode-hook           (lambda () (cedit/indent-code 4 nil 72 t 2)
                                      (setq ispell-dictionary "de_AT")
                                      (mail-text)))
(add-hook 'text-mode-hook           (lambda () (cedit/indent-code 2 nil  80 nil 2)))
(add-hook 'org-mode-hook            (lambda () (cedit/indent-code 2 nil 80  nil 2)))
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
  (if (or (string-match "*scratch*"        (buffer-name))
          (string-match "reminder.org.gpg" (buffer-name)))
      (progn (message "Not allowed to kill %s, burying instead" (buffer-name))
             (bury-buffer))
    t))

(remove-hook 'kill-buffer-query-functions 'custom-bury-buffer)
(add-hook 'kill-buffer-query-functions 'custom-bury-buffer)


;; == show matching quotes
(defun show-paren--match-quotes ()
  (let ((ppss (syntax-ppss)))
    ;; In order to distinguish which quote is opening and which is starting,
    ;; check that that point is not within a string (or comment, for that
    ;; matter).  Also ignore escaped quotes.
    (unless (or (nth 8 ppss) (nth 5 ppss))
      (or
       (and (not (bobp))
            (eq 7 (car-safe (syntax-after (1- (point)))))
            (save-excursion
              (let ((end (point))
                    (ppss (syntax-ppss (1- (point)))))
                (when (nth 3 ppss)
                  (let ((beg (nth 8 ppss)))
                    (list beg
                          (1+ beg)
                          (1- end)
                          end))))))
       (and (not (eobp))
            (eq 7 (car-safe (syntax-after (point))))
            (save-excursion
              (let ((beg (point)))
                (condition-case nil
                    (progn
                      (forward-sexp 1)
                      (list beg
                            (1+ beg)
                            (1- (point))
                            (point)))))))))))

(advice-add 'show-paren--default :after-until #'show-paren--match-quotes)

;; === keys ====================================================================
;; disabled keybinds
(dolist (key '("C-9" "C-8" "C-7" "C-6" "C-5" "C-4" "C-3" "C-2" "C-1" "C-0"
               "C-M-9" "C-M-8" "C-M-7" "C-M-6" "C-M-5" "C-M-4" "C-M-3" "C-M-2"
               "C-M-1" "C-M-0" "M-9" "M-8" "M-7" "M-6" "M-5" "M-4" "M-3" "M-2"
               "M-1" "M-0" ;; ^--digit arguments
               "M-k" "<C-mouse-1>" "<C-mouse-3>" "<C-mouse-5>" "<C-mouse-4>"
               "C-z" "C-x C-z" "C-x m" "C--" "C-x DEL"
               "<f11>" "<insert>" "<insertchar>" "<f2>"
               ))
  (global-unset-key (kbd key))) ;; unbind digit arguments


;; custom region keybinds
(defconst custom-region-alist
  `((mark-active
     ,@(let ((m (make-sparse-keymap)))
         (define-key m (kbd "C-w")        'kill-region)
         (define-key m (kbd "C-k")        'kill-region)
         (define-key m (kbd "C-;")        'comment-region)
         m))))
(add-to-list 'emulation-mode-map-alists 'custom-region-alist)

;; custom functions
(defun match-paren (&optional arg)
  "Go to the matching parenthesis character if one is adjacent to point."
  (interactive "^p")
  (cond ((looking-at "\\s(") (forward-sexp arg))
        ((looking-back "\\s)" 1) (backward-sexp arg))
        ((looking-at "\\s)") (forward-char) (backward-sexp arg))
        ((looking-back "\\s(" 1) (backward-char) (forward-sexp arg))))

(defun backward-kill-line (arg)
  "Kill ARG lines backward."
  (interactive "p")
  (if (eq (point) (line-beginning-position))
      (delete-indentation)
    (kill-line (- 1 arg))))


;; zsh like C-a/C-e
(defun beginning-or-prev-line ()
  "Kill ARG lines backward."
  (interactive)
  (if (eq (point) (line-beginning-position))
      (progn
        (previous-line)
        (beginning-of-line))
    (beginning-of-line)))

(defun end-or-next-line ()
  "Kill ARG lines backward."
  (interactive)
  (if (eq (point) (line-end-position))
      (progn
        (next-line)
        (end-of-line))
    (end-of-line)))

(defun transpose-windows (arg)
  "Transpose the buffers shown in two windows."
  (interactive "p")
  (unless (one-window-p)
    (let ((selector (if (>= arg 0) 'next-window 'previous-window)))
      (while (/= arg 0)
        (let ((this-win (window-buffer))
              (next-win (window-buffer (funcall selector))))
          (set-window-buffer (selected-window) next-win)
          (set-window-buffer (funcall selector) this-win)
          (select-window (funcall selector)))
        (setq arg (if (cl-plusp arg) (1- arg) (1+ arg)))
        ;;(other-window -1)
        (message "Transposing windows")))))
(defalias 'tw            'transpose-windows)

(defun my-goto-line ()
  (interactive)
  (unwind-protect
      (progn
        (display-line-numbers-mode 1)
        (goto-line (read-number "Goto line: ")))
    (display-line-numbers-mode -1)))
(defalias 'gl            'my-goto-line)

(defun text-scale-reset ()
  (interactive)
  (text-scale-set 0))

(bind-keys*
 ("C-z"       . universal-argument)
 ("C-c SPC"   . cua-rectangle-mark-mode)
 ("C-x m"     . pop-to-mark-command)
 ("C-x C-m"   . pop-to-mark-command)
 ("M-o"       . other-window)
 ("C-h"       . backward-delete-char-untabify)
 ("C-a"       . beginning-or-prev-line)
 ("C-e"       . end-or-next-line)
 ("M-g"       . my-goto-line))

;; custom keys
(bind-keys
 ("C-c h"     . help)
 ;; editing
 ("M-%"       . query-replace-regexp)
 ("C-c 5"     . query-replace)
 ("C-M-5"     . query-replace)
 ("M-k"       . kill-whole-line) ;; was M-K
 ("C-w"       . backward-kill-word)
 ("M-W"       . backward-kill-sexp)
 ("M-u"       . upcase-dwim)
 ("M-l"       . downcase-dwim)
 ("M-SPC"     . cycle-spacing)
 ("C-c C-SPC" . delete-horizontal-space)
 ;; custom function binds
 ("C-5"       . match-paren)
 ("C-u"       . backward-kill-line)
 ("C-x z"     . (lambda () ;; "Suspend frame inside of a terminal instance of Emacs."
                  (interactive)
                  (if (display-graphic-p)
                      (message "Suspend frame is disabled for X11 frames of emacs")
                    (suspend-frame))))
 ;; movement
 ("M-p"       . backward-paragraph)
 ("M-n"       . forward-paragraph)
 ("<M-up>"    . backward-paragraph)
 ("<M-down>"  . forward-paragraph)
 ;; mark
 ("C-x C-h"   . mark-whole-buffer)
 ;; misc
 ("<f9>"      . font-lock-mode)
 ("<f10>"     . menu-bar-mode)
 ("<f11>"     . whitespace-mode)
 ("<f12>"     . display-fill-column-indicator-mode)
 ("C-<f12>"   . display-line-numbers-mode)
 ;; buffer
 ("<M-prior>" . previous-buffer)
 ("<M-next>"  . next-buffer)
 ("C-x k"     . kill-current-buffer)
 ("C-x C-k"   . kill-buffer)
 ("C-c r"     . revert-buffer)
 ("C-x C-b"   . buffer-menu)
 ;; windows
 ("M-1"       . delete-other-windows)
 ("M-2"       . split-window-below)
 ("M-3"       . split-window-right)
 ("M-4"       . make-frame-command)
 ("M-0"       . delete-window)
 ("C-x 4"     . make-frame-command)
 ("C-0"       . balance-windows)
 ("C--"       . shrink-window)
 ("C-="       . enlarge-window)
 ("C-x C--"   . negative-argument)
 ("C-c o"     . transpose-windows)
 ("C-x t"     . transpose-lines)
 ;; misc
 ("C-c 4"     . ispell-change-dictionary)
 )

;; mode specific
(dolist (mode '(lisp-mode-map emacs-lisp-mode-map lisp-interaction-mode-map))
  (bind-keys :map mode
             ("C-c C-c" .
              (lambda ()
                (interactive)
                (if (region-active-p)
                    (progn
                      (eval-region (region-beginning) (region-end))
                      (message "Evaluated current region"))
                  (progn
                    (eval-buffer)
                    (message "Evaluated current buffer")))))))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; x11
(when (my_daemonp)
  ;; custom functions
  (defun yank-primary ()
    "Yank primary selection."
    (interactive)
    (insert (gui-get-primary-selection)))
  (defun kill-ring-save-primary ()
    (interactive)
    (deactivate-mark)
    (gui-set-selection
     'PRIMARY
     (replace-regexp-in-string "[\s\n]" "" (buffer-substring
                                            (region-beginning) (region-end)))))
  (bind-keys
   ("C-M-y"           . yank-primary)
   ("C-M-w"           . kill-ring-save-primary)
   ("<insert>"        . yank-primary)
   ;; window transposing
   ("s-o"             . transpose-windows)
   ;; buffers
   ("s-b"   . buffer-menu)
   ("s--"   . text-scale-decrease)
   ("s-="   . text-scale-increase)
   ("s-0"   . text-scale-reset)))

;; == mode maps

(bind-keys
 :map isearch-mode-map
 ("C-o" . (lambda ()
            (interactive)
            (let ((case-fold-search isearch-case-fold-search))
              (occur (if isearch-regexp isearch-string (regexp-quote isearch-string)))))))

;; === functions ===============================================================
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; date
(defun date (&optional ftype)
  (interactive)
  (setq format "%Y-%m-%d %a"
        downcase nil)
  (cond
   ((string= ftype "time")
    (setq format (concat format " %H:%M")))
   ((string= ftype "long")
    (setq format "%a, %d%b%Y %H:%M (%Y-%m-%d)"
          downcase t)))
  (cond
   ((equal major-mode 'org-mode)
    (setq format (concat "<" format ">")))
   ((equal major-mode 'sh-mode)
    (setq format (concat "## " format)))
   ((equal major-mode 'c-mode)
    (setq format (concat "/* " format " */")))
   ((equal major-mode 'haskell-mode)
    (setq format (concat "-- " format)))
   ((or (equal major-mode 'emacs-lisp-mode)
        (equal major-mode 'lisp-interaction-mode))
    (setq format (concat ";; " format)))
   ((string-match (buffer-name) "Ledger")
    (setq format (concat ";" format)))
   )
  (setq format (format-time-string format))
  (when (eq downcase t)
    (setq format (downcase format)))
  (insert format))



(defun tdate () (interactive) (date "time"))
(defun ldate () (interactive) (date "long"))
(defalias 'ymd   'date)
(defalias 'datet 'tdate)
(defun _calendar-week ()
  (shell-command-to-string "~/bin/week"))
(defun week ()
  (interactive)
  (if (use-region-p)
      (let* ((beg (region-beginning))
             (end (region-end))
             (wn  (buffer-substring-no-properties beg end)))
        (kill-region beg end)
        (insert
         (concat "* "
                 (shell-command-to-string
                  (format "week %s" (shell-quote-argument wn))))))
    (let ((wn (shell-quote-argument (read-string "Enter week number or date: "))))
      (insert
       (concat "* "
               (shell-command-to-string (format "week %s" wn)))))))

(defalias 'kw 'week)
(defalias 'cw 'week)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; compile
;; Don’t ask to save files before compilation, just save them.
(setq compilation-ask-about-save nil
      compilation-always-kill t
      compilation-scroll-output 'first-error)
;; Don’t ask to kill currently running compilation, just kill it.
(defun ccompile/colorize ()
  (toggle-read-only)
  (ansi-color-apply-on-region compilation-filter-start (point))
  (toggle-read-only))

(defun ccompile/recompile ()
  "Interrupt current compilation and recompile"
  (interactive)
  (ignore-errors (kill-compilation))
  (recompile))

(defun compile-parent (command)
  (interactive
   (let* ((make-directory
           (locate-dominating-file default-directory "Makefile"))
          (command (concat "make -k -C "
                           (shell-quote-argument make-directory) " ")))
     (list (compilation-read-command command))))
  (compile command))
(add-hook
 'compilation-filter-hook
 (lambda ()
   (require 'ansi-color)
   (ccompile/colorize)))

(bind-keys
 ("<f5>"     . compile-parent)
 ("<f6>"     . ccompile/recompile)
 ("C-<f5>"   . compile))
(defalias 'Make 'compile-parent)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; misc
(defun arrayify (start end quote)
  "Turn strings on newlines into a QUOTEd, comma-separated one-liner."
  (interactive "r\nMQuote: ")
  (let ((insertion
         (mapconcat
          (lambda (x) (format "%s%s%s" quote x quote))
          (split-string (buffer-substring start end)) ", ")))
    (delete-region start end)
    (insert insertion)))

(defun desktop-restore-session ()
  (interactive)
  (find-file "~/.local/emacs/.emacs.desktop")
  (desktop-revert))

;; packages
(defun my-package-install-refresh-contents (&rest args)
  (package-refresh-contents)
  (advice-remove 'package-install 'my-package-install-refresh-contents))
(advice-add 'package-install :before 'my-package-install-refresh-contents)


(defun reset_emacs ()
  (interactive)
  (setq default-frame-alist
        `((width  . 80) (height . 48)))
  (load "~/.emacs.d/init.el"))
(defalias 'reset-emacs 'reset_emacs)

(defun new-scratch ()
  "create a new scratch buffer to work in. (could be *scratch* - *scratchX*)"
  (interactive)
  (let ((n 0)
        bufname)
    (while (progn
             (setq bufname (concat "*scratch"
                                   (if (= n 0) "" (int-to-string n))
                                   "*"))
             (setq n (1+ n))
             (get-buffer bufname)))
    (switch-to-buffer (get-buffer-create bufname))
    (if (= n 1) initial-major-mode)))

(defalias 'ns 'new-scratch)
(defalias 'mkscratch 'new-scratch)


;; == Window Resize
(defun resize-frame (&optional width height)
  (interactive)
  (if (or width height)
      (progn
        (set-frame-width (selected-frame) width)
        (set-frame-height (selected-frame) height))
    (progn
      (set-frame-width (selected-frame) 80)
      (set-frame-height (selected-frame) 48))))

;; <2021-12-31 Fri> @leahneukirchen
(defun toggle-case ()
  (interactive)
  (let ((char (following-char)))
    (if (eq char (upcase char))
        (insert-char (downcase char) 1 t)
      (insert-char (upcase char) 1 t)))
  (delete-char 1 nil)
  (backward-char))

;;;;
(defun kill-buffer-and-window ()
  "If a buffer is within its own window, kill both"
  (interactive)
  (if (one-window-p)
      (progn
        (kill-current-buffer)
        (tab-bar-close-tab))
    (progn
      (kill-current-buffer)
      (delete-window)
      (balance-windows))))

;; 2022-01-23 Sun @leahneukirchen
(defun toggle-comment-on-line ()
  "comment or uncomment current line"
  (interactive)
  (comment-or-uncomment-region (line-beginning-position) (line-end-position)))

(bind-keys
 ("C-c ."   . date)
 ("C-c C-." . tdate)
 ("C-c >"   . ldate)
 ("C-;"     . toggle-comment-on-line)
 ("M-#"     . toggle-case))

;; === internal modes ==========================================================
;; == ido
(use-package ido
  :ensure nil
  :defer t
  :config
  (defun cido/lazy-ido-enable ()
    "since ido is loaded with Emacs, use-package cannot defer"
    (ido-mode t)
    (setq
     ido-enable-flex-matching t
     ido-auto-merge-work-directories-length -1
     ido-default-buffer-method 'selected-window
     ido-default-file-method 'selected-window
     ido-everywhere t)
    (if (require 'ido-sort-mtime nil t)
        (ido-sort-mtime-mode t)))
  (defun cido/lazy-ido-switch-buffer ()
    "ibuffer wrapper"
    (interactive)
    (cido/lazy-ido-enable)
    (call-interactively 'ido-switch-buffer))
  (defun cido/lazy-ido-switch-buffer-other-window ()
    "ibuffer wrapper"
    (interactive)
    (cido/lazy-ido-enable)
    (call-interactively 'ido-switch-buffer-other-window))
  (defun cido/lazy-ido-find-file ()
    "find-file wrapper"
    (interactive)
    (cido/lazy-ido-enable)
    (call-interactively 'ido-find-file))
  (defun cido/lazy-ido-dired ()
    "find-file wrapper"
    (interactive)
    (cido/lazy-ido-enable)
    (call-interactively 'ido-dired))
  :bind*
  (("C-x C-f" . cido/lazy-ido-find-file)
   ("C-x d"   . cido/lazy-ido-dired)
   ("C-x b"   . cido/lazy-ido-switch-buffer)
   ("C-c b"   . cido/lazy-ido-switch-buffer-other-window)))

;; == dired
(use-package dired-x
  :if (my_daemonp)
  :ensure nil
  :defer nil
  :config
  (setq-default dired-omit-files "^\\...+$"
                dired-isearch-filenames t)
  (if (or (string-equal system-type "gnu/linux")
          (file-regular-p "/usr/local/share/gls"))
      (setq dired-listing-switches
            "-laFH --group-directories-first")
    (setq dired-listing-switches "-laFH"))
  (setq dired-omit-verbose nil
        dired-omit-mode t
        dired-auto-revert-buffer t)

  (defun cdired/x-mode-setup ()
    (font-lock-mode t)
    (dired-hide-details-mode 1))
  (add-hook 'dired-mode-hook 'cdired/x-mode-setup)
  :bind
  (("C-x C-d" . dired-jump)
   ("s-d" . dired-jump))
  (:map dired-mode-map
        ("C-h"        . dired-omit-mode)
        ("C-d"        . dired-hide-details-mode)))

(use-package dired
  :ensure nil
  :defer nil
  :init
  :config
  (defun dired-jump-previous-dir ()
    (interactive)
    (setq old-buffer (buffer-name))
    (dired-jump)
    (kill-buffer old-buffer))
  (defun dired-view-file-other-window ()
    (if (one-window-p)
        (split-window-horizontally)
      (split-window-vertically))
    (other-window 1)
    (dired-view-file))

  (defun dired-find-or-view ()
    "A `dired-find-file' which only works on directories."
    (interactive)
    (let ((find-file-run-dired t)
          (file (dired-get-file-for-visit)))
      (if (file-directory-p file)
          (find-file file)
        (dired-view-file-other-window))))

  (defun dired-quit-and-kill-window ()
    (if (one-window-p)
        (quit-window)
      (progn
        (quit-window)
        (delete-window))))
  :bind
  (:map dired-mode-map
        ("v"          . dired-find-file-other-window)
        ("q"          . dired-quit-and-kill-window)
        ("C-h"        . dired-omit-mode)
        ("<right>"    . dired-find-or-view)
        ("<left>"     . dired-jump-previous-dir)
        ("C-d"        . dired-hide-details-mode)
        ("r"          . revert-buffer)
        ("/"          . occur)))

;; == tex
(use-package tex
  :ensure nil
  :defer t
  :config
  (setq tex-fontify-script nil ;; disables custom fonts in LaTeX buffer display
        tex-dvi-view-command "pdf.viewer"
        font-latex-fontify-sectioning 'color
        font-latex-fontify-script nil
        LaTeX-item-indent -2
        LaTeX-indent-level 4 ;; indents special environments
        TeX-engine 'default) ;; xetex to switch to xelatex
  )
;;  (setq TeX-view-program-selection
;;        (quote
;;    (((output-dvi has-no-display-manager) "dvi2tty")
;;     ((output-dvi style-pstricks) "dvips and gv")
;;     (output-dvi "xdvi")
;;     (output-pdf "xpdf")
;;     (output-html "xdg-open")))))

;; == org
(use-package org
  :ensure nil
  :defer t
  :init
  (add-hook 'org-mode-hook
            (lambda ()
              (electric-indent-local-mode -1)
              (font-lock-mode t)))
  :config
  (progn
    (setq org-highlight-latex-and-related '(latex script entities)
          indent-rigidly t
          org-src-fontify-natively t
          org-src-tab-acts-natively t
          org-confirm-babel-evaluate nil
          org-src-preserve-indentation t
          org-adapt-indentation nil
          org-src-content-indentation 0
          org-startup-folded t
          org-log-done 'time)
    (setq org-todo-keywords
          '((sequence "TODO" "INPROGRESS" "|" "DONE"  "CANCELLED")
            (sequence "VIABLE" "|" "INVIABLE")
            (sequence "VALID"  "|" "INVALID")
            (sequence "BUG"    "|" "FIXED" "WONT FIX")
            (sequence "DELETED" "UNKNOWN"))
          org-todo-keyword-faces
          '(("INVIABLE"   . "pink")
            ("VIABLE"     . "palegreen")
            ("INVALID"    . "pink")
            ("CANCELLED"  . "#565252") ;;"grey50")
            ("INPROGRESS" . "#FFAF00") ;; was "goldenrod1")
            ("NEXT"       . "#FFAF00")
            ("VALID"      . "palegreen")
            ("BUG"        . "pink")
            ("WONT FIX"   . "red")
            ("DELETED"    . "red")
            ("UNKNOWN"    . "goldenrod1")
            ("FIXED"      . "palegreen")))
    (setq org-capture-templates
          '(("t" "Todo"         entry (file corg/reminder)    "* TODO %t %?\n")
            ("r" "Reminder"     entry (file corg/reminder)    "* TODO %t %?\n")
            ("p" "Plan"         entry (file corg/reminder)    "* TODO %t %?\n")
            ("n" "Notes"        entry (file corg/notes)       "* %T\n%?\n")
            ("l" "Local notes"  entry (file corg/notes-local) "* %T\n%?\n")
            ("m" "Misc notes"   entry (file corg/notes)       "* %T\n%?\n")
            ("t" "til notes"    entry (file corg/til)         "* %T\n%?\n")
            ("u" "uni notes"    entry (file corg/uni)         "* %T\n%?\n"))))
  (defalias 'ca     'org-capture)
  (defalias 'oagenda 'org-agenda)
  (defun agenda()
    (interactive)
    (org-agenda "n"))
  :bind
  (:map org-mode-map
        ("C-c e" . org-latex-export-to-pdf)
        ("C-c <right>" . org-metaright)
        ("C-c <left>"  . org-metaleft)
        ("C-c C-."     . org-time-stamp)))

;; == man
(use-package man
  :ensure nil
  :defer t
  :config
  (setq Man-width 70)
  :bind
  (:map Man-mode-map
        ("C-q"    . kill-buffer-and-window)))

;; == view
(use-package view
  :ensure nil
  :defer t
  :config
  (defun View-quit-and-kill ()
    (interactive)
    (View-quit)
    (delete-window))
  :bind
  (:map view-mode-map
        ("C-q"    . View-quit)
        ("C-f"    . View-scroll-line-forward)
        ("C-b"    . View-scroll-line-backward)
        ("s"      . View-scroll-line-forward)
        ("w"      . View-scroll-line-backward)
        ("g"      . beginning-of-buffer)
        ("G"      . end-of-buffer)))

;;(use-package eww
;;  :ensure nil
;;  :defer t
;;  :config
;;  (setq
;;   shr-use-fonts nil ;; No special fonts
;;   shr-use-colors t   ;; enable colours
;;   shr-color-visible-luminance-min 70
;;   shr-indentation 2  ;; Left-side margin
;;   shr-width 80)     ;; Fold text to 80 columns
;;  :bind
;;  (:map eww-mode-map
;;        ("C-j"    . View-scroll-line-forward)
;;        ("C-k"    . View-scroll-line-backward)
;;        ))


;;; == buffer-menu
(use-package buffer-menu
  :ensure nil
  :defer nil
  :bind
  (:map ibuffer-mode-map
        ("r"   . ibuffer-redisplay)))

;; == yaml
(use-package yaml-mode
  :ensure nil
  :defer nil)
(defalias 'yml 'yaml-mode)
(require 'yaml-mode)

;; == narrow inderect
(use-package narrow-indirect
  :ensure nil
  :defer nil
  :config
  (require 'narrow-indirect)
  (defun ni-narrow-to-region ()
    (interactive)
    (ni-narrow-to-region-indirect-other-window)
    (delete-window -1))
  (defun ni-narrow-to-page ()
    (interactive)
    (ni-narrow-to-page-indirect-other-window)
    (delete-window -1))
  (defun ni-narrow-to-defun ()
    (interactive)
    (ni-narrow-to-defun-indirect-other-window)
    (delete-window -1))
  (bind-keys
   ("C-x n n" . ni-narrow-to-region)
   ("C-x n p" . ni-narrow-to-page)
   ("C-x n d" . ni-narrow-to-defun)))



;; === external modes ==========================================================
;;; external packages
;; == elscreen
(use-package elscreen
  :ensure t
  :defer  nil
  :config
  (setq-default elscreen-prefix-key "\M-s")

  (custom-set-variables
   '(elscreen-tab-display-kill-screen nil)
   '(elscreen-display-tab t)
   '(elscreen-display-screen-number t))
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
        ("x"       . (lambda ()
                       (interactive)
                       (if (one-window-p) (elscreen-kill) (delete-window))))
        ("M-k"     . (lambda ()
                       (interactive)
                       (when (y-or-n-p "Kill current buffer and close screen? ")
                         (kill-current-buffer)
                         (elscreen-kill))))
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
  (setq yas-snippet-dirs '("~/.emacs.d/snippets"))
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
(use-package mu4e
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
  (add-to-list 'load-path "/usr/share/emacs/site-lisp/mu4e")
  (defalias 'mail 'mu4e)
  (defalias 'mu   'mu4e)
  (when (and (my_daemonp)
             (file-directory-p "/usr/share/emacs/site-lisp/mu4e"))
    (load-library "mu4e")))

;; ==ripgrep
(use-package rg
  :ensure t
  :defer t)
(defalias 'ag 'rg)

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

;; === terminal ================================================================

(defun cterm/parse-tramp-path (path)
  (with-temp-buffer
    (insert path)
    (goto-char (point-min))
    (if (condition-case nil
            (re-search-forward "^/\\(?:\\([^:@]+\\):\\)?\\(?:\\([^:@]+\\)@\\)?\\([^:@]+\\):\\([^:@]+\\)?")
          (error nil))
        (cl-loop for i from 1 to 4
                 collect (match-string i)))))

(defun cterm/run-term (term &optional dir)
  (let ((default-directory (or dir default-directory))
        (path  (nth 3 (cterm/parse-tramp-path default-directory)))
        (host  (nth 2 (cterm/parse-tramp-path default-directory)))
        (user  (nth 1 (cterm/parse-tramp-path default-directory)))
        (proto (nth 0 (cterm/parse-tramp-path default-directory))))
    (if (and (equal proto "ssh") path)
        (if  (equal (length user) 0)
            (progn
              (message
               "Edit ~/.ssh/config or use tramp via <user>@<host>")
              (call-process term nil 0))
          (call-process term nil 0 term "-g" "80x24" "-e" "ssh" "-t" "-l"
                        user host (format "cd %s; exec $SHELL" path)))
      (call-process term nil 0 term "-g" "80x24"))))

(defun cterm/run-local-term (term)
  (let ((default-directory default-directory))
    (start-process term nil term)))

(defun run-term ()
  (interactive)  (cterm/run-term "~/bin/rxvt"))
(defun run-local-term ()
  (interactive)  (cterm/run-local-term "~/bin/rxvt"))
(defun run-beamer-term ()
  (interactive)  (cterm/run-term "~/bin/beamer"))

(bind-keys*
 ("C-c <return>"   . run-term)
 ("C-c RET"        . run-term)
 ("C-c <C-return>" . run-beamer-term)
 ("C-x C-<return>" . run-local-term))

(defalias 'bterm     'beamer-term)
(defalias 'open-term 'run-term)

;; === frame ===================================================================
(defun is_tmux ()
	(if (= (length (getenv "TMUX")) 0) nil t))

(defun set-tmux-keys ()
	(let ((map (copy-keymap xterm-function-map)))
		(set-keymap-parent map (keymap-parent input-decode-map))
		(set-keymap-parent input-decode-map  xterm-function-map)))

(defun my/after-make-frame (frame)
	(with-selected-frame frame
		(when (daemonp)
			(elscreen-start)
			(Journal)
			(elscreen-create)
			)))
(remove-hook 'after-make-frame-functions 'my/after-make-frame t)
(add-hook    'after-make-frame-functions 'my/after-make-frame)

(when (my_daemonp)
	(defun my/after-delete-frame (frame)
		(with-selected-frame frame
			(when (is_ssh)
				(setenv "SSH_CONNECTION" ""))))

	(remove-hook 'after-delete-frame-functions 'my/after-delete-frame t)
	(add-hook    'after-delete-frame-functions 'my/after-delete-frame))

(when (or (display-graphic-p) (daemonp))
	(unless (file-regular-p "~/git/dotfiles/x11/Xresources")
		(scroll-bar-mode -1)
		(tool-bar-mode -1)))

(display-time-mode t)
;;(display-battery-mode t)
(when (or (not (display-graphic-p)) (daemonp))
  (defadvice terminal-init-screen
		  ;; The advice is named `tmux', and is run before `terminal-init-screen' runs.
		  (before tmux activate)
	  ;; Docstring.  This describes the advice and is made available inside emacs;
	  ;; for example when doing C-h f terminal-init-screen RET
	  "Apply xterm keymap, allowing use of keys passed through tmux."
	  ;; This is the elisp code that is run before `terminal-init-screen'.
	  (set-tmux-keys))
  )

(defun reset-frame ()
  (interactive)
  (when (display-graphic-p)
	  (set-frame-height (selected-frame) 57)
	  (set-frame-width  (selected-frame) 80)))

;; === aliases =================================================================
;;; global aliases of default functions
;; modesp

(defalias 'af            'auto-fill-mode)
(defalias 'cf            'conf-mode)
(defalias 'fontify       'font-lock-fontify-buffer)
(defalias 'hs            'haskell-mode)
(defalias 'gws           'global-whitespace-mode)
(defalias 'ws            'whitespace-mode)
(defalias 'mb            'menu-bar-mode)
(defalias 'sh            'shell-script-mode)
(defalias 'li            'lisp-interaction-mode)
(defalias 'el            'emacs-lisp-mode)
(defalias 'org           'org-mode)
(defalias 'txt           'text-mode)
(defalias 'ppt           'puppet-mode)
(defalias 'fm            'fundamental-mode)
(defalias 'oc            'occur)
(defalias 'win           'shell)
(defalias 'tex           'plain-tex-mode)
(defalias 'latex         'latex-mode)
(defalias 'xt            'xterm-mouse-mode)
(defalias 'ap            'apropos)
(defalias 'qc            'quick-calc)
(defalias 'dir           'dired-jump)
(defalias 'linum         'display-line-numbers-mode)
(defalias 'tr            'toggle-truncate-lines)
(defalias 'fci           'display-fill-column-indicator-mode)
(defalias 'win-undo      'winner-undo)
(defalias 'win-redo      'winner-redo)
(defalias 'wundo         'winner-undo)
(defalias 'wredo         'winner-redo)
(defalias 'b             'balance-windows)
(defalias 'conf          'conf-mode)
(defalias 'ro            'read-only-mode)
(defalias 'rw            'read-only-mode)
(defalias 'vi            'visual-line-mode)

;; === daemonp
(when (my_daemonp)
  (setq confirm-kill-emacs 'yes-or-no-p)
  (when (daemonp)
    ;; === desktop save ============================================================
    (setq desktop-path '("~/.local/")
          desktop-dirname "~/.local/"
          desktop-base-file-name "emacs-desktop")
    (desktop-save-mode 1)
    (add-hook 'desktop-after-read-hook
              '(lambda ()
                 (setq desktop-dirname-tmp desktop-dirname)
                 (desktop-remove)
                 (setq desktop-dirname desktop-dirname-tmp)))
    (defun saved-session ()
      (file-exists-p (concat desktop-dirname "/" desktop-base-file-name)))
    (defun session-restore ()
      "Restore a saved emacs session."
      (interactive)
      (if (saved-session)
          (desktop-read)
        (message "No desktop found.")))

    (defun session-save ()
      "Save an emacs session."
      (interactive)
      (if (saved-session)
          (if (y-or-n-p "Overwrite existing desktop? ")
              (desktop-save-in-desktop-dir)
            (message "Session not saved."))
        (desktop-save-in-desktop-dir)))

    (add-hook 'after-init-hook
              '(lambda ()
                 (if (saved-session)
                     (if (y-or-n-p "Restore desktop? ")
                         (session-restore)))))

    (defalias 'save-session    'session-save)
    (defalias 'restore-session 'session-restore)

    ;; === emacsclient =============================================================
    (keychain-refresh-environment)
    (defun ask-before-closing ()
      (interactive)
      (if (display-graphic-p)
          (if (y-or-n-p (format "Really exit Emacs?"))
              (progn
                (save-some-buffers)
                (delete-frame))
            (message "Quit"))
        (delete-frame)))
    (global-set-key (kbd "C-x C-c") 'ask-before-closing)

    (defun my-update-env (fn)
      "https://emacs.stackexchange.com/a/6107
      fix background/foreground colors for emacsclient within terminals
      emacs.stackexchange.com/questions/41/start-two-separate-emacs-daemons-for-console-and-gui"
      (let ((str
             (with-temp-buffer
               (insert-file-contents fn)
               (buffer-string))) lst)
        (setq lst (split-string str "\000"))
        (while lst
          (setq cur (car lst))
          (when (string-match "^\\(.*?\\)=\\(.*\\)" cur)
            (setq var (match-string 1 cur))
            (setq value (match-string 2 cur))
            (setenv var value))
          (setq lst (cdr lst)))))
    ;; === fonts ==================================================================
    (set-face-attribute 'variable-pitch nil :font "Sans-Serif-14")
    (setq dpi (string-to-number (shell-command-to-string "~/bin/dpi")))
    (defun ttf ()
      (interactive)
      (let* ((ttfh (cond ((= dpi 109) 79)
                         ((= dpi 125) 69)
                         ((= dpi 131) 75)
                         ((= dpi 157) 64) ;; was 74
                         (t           70)))
             (xfth       (/ ttfh 10.0))
             (family     "Deja Vu Sans Mono")
             (myfont     (concat family "-" (number-to-string xfth))))
        (custom-set-faces
         `(default ((t (:inherit default :height ,ttfh :width normal :foundry "PfEd" :family ,family)))))
        (setq default-frame-alist `((font . ,myfont))
              initial-frame-alist default-frame-alist)
        (set-frame-font myfont nil t)
        (set-foreground-color "#FFFFFF")))

    (defun pcf (&optional arg)
      (interactive)
      (let ((myfont
             (cond
              ((or (string= arg "9x16"))
               "-uw-ttyp0-medium-r-normal--16-150-75-75-c-80-iso10646-1")
              ((or t (string= arg "6x13"))
               "-gl-fixed-medium-r-semicondensed--13-120-75-75-c-60-iso10646-1"))))
        (set-face-attribute 'default t :font myfont)
        (setq default-frame-alist `((font . ,myfont))
              initial-frame-alist default-frame-alist)
        (set-frame-font myfont nil t))
      (set-foreground-color "#E5E5E5"))

    (defun 6x13 () (interactive) (pcf "6x13"))
    (defun 9x16 () (interactive) (pcf "9x16"))
    (defun default-font ()
      (interactive)
      (cond
       ((or (= dpi 109) (file-regular-p "~/.ttf") (ttf)))
       ((or (file-regular-p "~/.hf")
            (>= dpi 157))
        (9x16))
       (t                         (6x13))))

    (defalias 'df          'default-font)
    (defalias 'reset-fonts 'default-font)
    (defalias 'menlo       'ttf)
    (defalias 'meslo       'ttf)

    (default-font)
    ))

(let ((ln "~/.emacs.local.el")
      (pl "~/.emacs.personal.el"))
  (when (file-regular-p pl) (load-file pl))
  (when (file-regular-p ln) (load-file ln)))

(setq backup-by-copying t   ; don't clobber symlinks
      version-control t     ; use versioned backups
      delete-old-versions t
      kept-new-versions 12
      kept-old-versions 6)

(let ((backupdir "~/.local/emacs/backup/")
      (autosavedir "~/.local/emacs/autosave/"))
  (mkdir backupdir t)
  (mkdir autosavedir t)
  (setq backup-directory-alist `(("." . ,backupdir))
        auto-save-file-name-transforms `((".*" ,autosavedir t))))

;; === theme/colours ===========================================================
(add-to-list 'custom-theme-load-path "~/.emacs.d/themes")
(defvar theme/light nil
  "Variable theme used to toggle theme")
(defun theme/set-colours (&optional mode)
  (let* ((light (string= mode "light"))
         (dark (string= mode "dark"))
         (default-term (cond ((is_ssh)  '(:background "color-235"      :foreground "unspecified-fg"))
                             ((daemonp) '(:background "color-236"      :foreground "color-254"))
                             (t         '(:background "unspecified-bg" :foreground "unspecified-fg"))))
         (white          (if (is_ttf)    "#ffffff" "#e5e5e5"))
         (default-bg     (cond (dark     "#000000")
                               (light    "#ffffff")
                               (t        "#333333")))
         (default-fg     (cond (light    "#000000")
                               (t        white)))
         ;; (mode-line-term '(:background "color-235" :foreground "color-250")))
         (mode-line-buffer-id     (if (is_ssh) "#B680B1" nil))
         (fringe         (if (string= mode "light") "#f2f2f2" "#1a1a1a"))

         )
     (custom-set-faces
      `(default ((((type tty))  ,default-term)
                 (t             (:background ,default-bg :foreground ,default-fg))))
      `(mode-line ((t (:foreground ,white :background "#292929" ))))
      `(mode-line-buffer-id ((t (:bold t))))
      `(fringe  ((t (:background ,fringe :inherit default))))
      `(region   ((t (:foreground ,white :background "#114488" :extend t)))))
     (when (is_ssh)
       (custom-set-faces
        `(mode-line-buffer-id ((t (:inherit mode-line-buffer-id :foreground "B680BB1" :bold t))))
        `(mode-line ((((type  tty)) (:background "#373333"  :foreground "#838383" :bold t))))))
     ))
(if (and (display-graphic-p) (not (daemonp)))
    (theme/set-colours "light")
(theme/set-colours))

(defun theme/font-lock (&optional)
  (interactive)
  (if font-lock-mode
      (progn (global-font-lock-mode 0)
             (unless theme/light
               (theme/set-colours)))
    (progn (global-font-lock-mode t)
           (unless theme/light
             (theme/set-colours "dark")))))
(defalias 'fl 'theme/font-lock)
(defun toggle-light-theme ()
  (interactive)
  (if theme/light
      (progn
        (setq frame-background-mode 'dark
              theme/light nil)
        (if font-lock-mode
            (theme/set-colours "dark")
          (theme/set-colours)))
    (progn (setq theme/light t)
           (setq frame-background-mode 'light)
           (theme/set-colours "light"))))
;;(invert-face 'default)
(bind-keys
 ("<f2>" . toggle-light-theme)
 ("C-<f2>" . theme/font-lock))
(let* ((default-term (cond ((is_ssh)  '(:background "color-235"      :foreground "unspecified-fg"))
                           ((daemonp) '(:background "color-236"      :foreground "color-254"))
                           (t         '(:background "unspecified-bg" :foreground "unspecified-fg"))))
       (mode-line-inactive-term (if (is_ssh) '(:background "#292424"  :foreground "#847f54" :bold t)
                                  '(:background "color-239" :foreground "color-252")))
       (default-dark-fg         (if (is_ttf)       "#e5e5e5" "#bebebe")))

(custom-set-faces
 `(cursor                              ((t            (:background "#00ff00" :foreground "#000000"))))
 `(border                              ((t            (:foreground "#0000ff"))))
 `(minibuffer-prompt                   ((t (:inherit default :bold t))))
 `(mode-line-inactive                 ((((type  tty)) ,mode-line-inactive-term)
                                       (t             (:background "#4D4D4D" :foreground "#CCCCCC"
                                                                   :box (:line-width -1 :color "#666666" :style nil)))))

 `(hl-line                            ((t (:inherit fringe :extend t))))

 `(font-lock-regexp-grouping-backslash ((t (:inherit default :bold t))))
 `(font-lock-regexp-grouping-construct ((t (:inherit default :bold t))))
 `(font-lock-warning-face              ((t (:foreground "#FF0000" :bold t))))

 `(ido-subdir                          ((t (:foreground "#A1C659"))))
 `(ido-only-match                      ((t (:foreground "#FFCC33"))))
 `(ido-fist-match                      ((t (:inherit default :bold t :underline t))))
 `(ido-incomplete-regexp               ((t (:inherit default))))
 `(ido-indicator                       ((t (:inherit default))))

 `(italic                              ((t (:slant italic :underline nil))))

 `(completions-common-part             ((t (:foreground "#add8e6"))))

 `(isearch-fail                        ((t (:background "#8B0000" :foreground "#E5E5E5"))))
 `(isearch                             ((t (:background "#000000" :foreground "#1E90FF" :bold t))))

 `(shadow                              ((t (:foreground "#aaaaaa"))))

 `(org-level-1                         ((t (:foreground "#A1A1A1" :bold t))))
 `(org-level-2                         ((t (:foreground "#929292"))))
 `(org-level-3                         ((t (:foreground "#838383" :bold t))))
 `(org-level-4                         ((t (:foreground "#757575" t))))
 `(org-level-5                         ((t (:foreground "#8b8fc6"))))
 `(org-level-6                         ((t (:foreground "#bd845f"))))
 `(org-level-7                         ((t (:foreground "#71a46c"))))
 `(org-level-8                         ((t (:foreground "#71a19f"))))

 `(org-date                            ((t (:foreground "#2C78BF"))))
 `(org-todo                            ((t (:foreground "#D70000" :bold t))))
 `(org-done                            ((t (:foreground "#228b22" :bold t))))
 `(org-special-keyword                 ((t (:foreground "#729FCF"))))
 `(org-priority                        ((t (:foreground "#729FCF"))))
 `(org-headline-done                   ((t (:foreground "#FFA07A"))))
 `(org-meta-line                       ((t (:inherit default :bold t))))
 `(org-time-grid                       ((t (:foreground "#EEDD82"))))
 `(org-agenda-clocking                 ((t (:inherit default :background "#4A708B" :extend t))))
 `(org-agenda-structure                ((t (:foreground "#87CEFA"))))
 `(org-agenda-date                     ((t (:inherit org-agenda-structure))))
 `(org-agenda-date-today               ((t (:inherit org-agenda-date :bold t :underline t))))
 `(org-agenda-date-weekend             ((t (:inherit org-agenda-date :bold t))))
 `(org-block-begin-line                ((t (:inherit default)))) ;; was inherit org-meta-line
 `(org-block-end-line                  ((t (:inherit org-block-begin-line))))
 `(org-block                           ((t (:inherit default :extend t))))
 `(org-latex-and-related               ((t (:foreground "#DEB887"))))
 `(org-table                           ((t (:foreground "#87CEFA"))))
 `(org-drawers                         ((t (:foreground "#87cefa"))))

 `(tex-verbatim                        ((t (:foreground "#DEB887"))))
 `(tex-math                            ((t (:inherit tex-verbatim))))

 `(dired-header                     ((t (:foreground  "#98fb98"))))
 `(dired-directory                  ((t (:foreground  "#87CEFA"))))
 `(dired-symlin                     ((t (:foreground  "#1e90ff"))))

 `(buffer-menu-buffer               ((t (:inherit default))))

 `(Man-overstrike                   ((t (:inherit default :bold t)))) ;; was ff0000 for dark
 `(Man-underline                    ((t (:foreground "#4286F4" :underline nil ;; was 00ff00 for dark
                                                     :bold t))))

 `(error                            ((t (:foreground "#ff0000" :bold t))))

 `(show-paren-match                 ((t (:foregroubd "#ffffff" :background "#4f94cd"))))
 `(show-paren-mismatch              ((t (:foreground "#ffffff" :background "#a020f0"))))

 `(escape-glyph                     ((t (:foreground "#00ffff" :bold t))))

 `(magit-diff-header                   ((t (:inherit diff-header))))
 `(magit-diff-context-highlight        ((t (:inherit diff-context))))
 `(magit-diff-removed-highlight        ((t (:inherit diff-removed))))
 `(magit-diff-refine-removed-highlight ((t (:inherit diff-refine-removed))))
 `(magit-diff-added-highlight          ((t (:inherit diff-added))))

 `(mu4e-header-highlight-face       ((t (:background "#AF8700" :foreground "#000000" :bold nil))))
 `(mu4e-unread-face                 ((t (:foreground "#0087FF" :bold nil))))
 `(mu4e-replied-face                ((t (:foreground "#4286F4" :bold t))))
 `(mu4e-header-face                 ((t (:foreground "#888888"))))
 `(mu4e-header-key-face             ((t (:inherit mu4e-header-face))))

 `(eshell-ls-directory              ((t (:inherit dired-directory))))
 `(eshell-ls-symlink                ((t (:inherit dired-symlink))))

 `(header-line                         ((t (:inherit mode-line :box (:line-width -1 :style released-button)))))
 `(elscreen-tab-background-face     ((t (:inherit header-line))))
 `(elscreen-tab-control-face        ((t (:inherit elscreen-tab-background-face))))
 `(elscreen-tab-other-screen-face   ((t (:inherit elscreen-tab-background-face))))
 `(elscreen-tab-current-screen-face ((((type tty)) (:inherit mode-line-inactive))
                                     (t (:foreground "#e5e5e5" :background "#666666"))))

 `(highlight                        ((t (:inherit default :background "#556b2f"))))
 ))
(global-font-lock-mode 0)
(global-eldoc-mode 0)
(add-hook 'diff-mode-hook    'turn-on-font-lock)
(add-hook 'dired-mode-hook   'turn-on-font-lock)
(add-hook 'magit-mode-hook   'turn-on-font-lock)
(add-hook 'Man-mode-hook   'turn-on-font-lock)
(add-hook 'org-mode-hook     'turn-on-font-lock)
(add-hook 'mail-mode-hook    'turn-on-font-lock)
(add-hook 'Man-mode-hook     'turn-on-font-lock)
(add-hook 'eshell-mode-hook  'turn-on-font-lock)
(add-hook 'ibuffer-mode-hook 'turn-on-font-lock)

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
 '(frame-title-format (if (daemonp) '("" "emacsclient@" system-name " - %b")
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
 '(xterm-mouse-mode nil)
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
 '(browse-url-generic-program "chrome.incognito")
 )
