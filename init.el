 ;;; (occur "^;; ===")
(setq gc-cons-threshold 64000000)
(add-hook
 'after-init-hook
 #'(lambda ()
     (setq gc-cons-threshold 800000))) ;; restore after startup
(setq gnutls-algorithm-priority "NORMAL:-VERS-TLS1.3")
(defun my_daemonp()
  (if (or (daemonp) (display-graphic-p)) t nil))
(defun is_ssh ()
  (if (= (length (getenv "SSH_CONNECTION")) 0) nil t))

(defun is_ttf ()
  (string-match "PfEd" (prin1-to-string (face-attribute 'default :font))))

(let ((basedir "~/.emacs.d/"))
  (add-to-list 'load-path (concat basedir "elisp"))
  (add-to-list 'custom-theme-load-path (concat basedir "themes")))

;;; v-- @leahneukirchen
(defmacro require-soft (name &rest body)
  `(if (require ,name nil t)
       (progn ,@body)
     (message "Could not load \"%s\", skipping..." ,name)))
(define-minor-mode my-keys-mode
  "Global minor mode for my custom key bindings

This ensures no major mode overrides the keybindings, while still
making them easy to toggle.  Also, all defined keybindings can be listed here:

\\{my-keys-mode-map}"
  :init-value t
  :keymap (make-sparse-keymap))
(defun bind-key (key def)
  (define-key my-keys-mode-map (kbd key) def))

(global-set-key (kbd "<f1>") 'my-keys-mode)

(when (my_daemonp)
  (package-initialize)
  (add-to-list 'package-archives
               '("melpa" . "https://melpa.org/packages/") t))

;; === editing =================================================================
;; disable modes
(dolist (function '(compose-mail
                    mouse-wheel-text-scale
                    mouse-appearance-menu
                    kmacro-end-call-mouse
                    overwrite-mode
                    org-archive-set-tag
                    org-archive-subtree
                    org-archive-subtree-default
                    org-archive-subtree-default-with-confirmation
                    org-archive-to-archive-sibling))
  (put function 'disabled t))
;; enable modes
(dolist (function '(upcase-region
                    scroll-left
                    downcase-region
                    dired-find-alternate-file
                    narrow-to-page
                    narrow-to-region
                    eval-expression
                    set-goal-column))
  (put function 'disabled nil))

(prefer-coding-system       'utf-8)
(set-default-coding-systems 'utf-8)
(set-terminal-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)

(defvar uniquify-buffer-name-style) ;; unique buffer names
(fset 'yes-or-no-p 'y-or-n-p)

(add-hook 'before-save-hook 'delete-trailing-whitespace)

(defun cedit/indent (offset tabs fc &optional fill stdi)
  (setq tab-width offset
        standard-indent offset
        indent-tabs-mode tabs
        fill-column fc)
  (when fill (turn-on-auto-fill))
  (when stdi (setq standard-indent stdi)))

(defun cedit/indent-text ()
  (cedit/indent 4 nil 120 t))

(defun cedit/sh-indent ()
  (setq sh-basic-offset 8)
  (cedit/indent 8 nil 80))

(defun cedit/lisp-indent ()
  (setq lisp-body-indent 2)
  (cedit/indent 2 nil 80))

(defun cedit/latex ()
  (cedit/indent 4 nil 80 t)
  (electric-indent-local-mode -1))

;; hooks
(add-hook 'minibuffer-setup-hook    (lambda () (setq truncate-lines nil)))
(add-hook 'emacs-lisp-mode-hook     'cedit/lisp-indent)
(add-hook 'lisp-mode-hook           'cedit/lisp-indent)
(add-hook 'latex-mode-hook          (lambda () (cedit/latex)))
(add-hook 'tex-mode-hook            (lambda () (cedit/latex)))

(add-hook 'java-mode-hook           (lambda () (cedit/indent 4 t   100 t)))
(add-hook 'sql-mode-hook            (lambda () (cedit/indent 4 nil 120)))
(add-hook 'html-mode-hook           (lambda () (cedit/indent 4 nil 120)))
(add-hook 'python-mode-hook         (lambda () (cedit/indent 4 nil  80 t)
                                      (setq python-indent 4)))
(add-hook 'conf-space-mode-hook     (lambda () (cedit/indent 4 nil  80)))
(add-hook 'conf-xdefaults-mode-hook (lambda () (cedit/indent 4 nil  80)))

(add-hook 'sh-mode-hook             (lambda () (cedit/sh-indent t)))

(add-hook 'makefile-mode-hook       (lambda () (cedit/indent 4 t 80 t)))
(add-hook 'makefile-gmake-mode-hook (lambda () (cedit/indent 4 t 80 t)))
(add-hook 'mail-mode-hook           (lambda () (cedit/indent 4 nil 72 t 2)
                                      (setq ispell-dictionary "de_AT")
                                      (mail-text)))
(add-hook 'text-mode-hook           (lambda () (cedit/indent 2 nil  80 nil 2)))
(add-hook 'org-mode-hook            (lambda () (cedit/indent 2 nil 80  nil 2)))
;; external modes
(add-hook 'haskell-mode-hook        (lambda () (cedit/indent 2 nil 80 t)))

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
         (steps (floor offset tab-width)))
    (* (max steps 1)
       tab-width)))

(add-hook 'c-mode-hook
          (lambda ()
            (cedit/indent 8 t 80)
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
            (cedit/indent 4 t 100)
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
                (".shrc"         . shell-script-mode)
                (".shenv"        . shell-script-mode)
                ("\\.pp\\"       .  puppet-mode)
                ("\\.xpm\\'"     . text-mode)
                (".Xdefaults'"   . conf-xdefaults-mode)
                (".Xresources'"  . conf-xdefaults-mode)
                ("\\gnus\\'"     . emacs-lisp-mode)
                ("\\emacs\\'"    . emacs-lisp-mode)
                ("Makefile"      . makefile-gmake-mode))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; buffer hooks
(add-hook 'minibuffer-exit-hook '(lambda ()
                                   (let ((buffer "*Completions*"))
                                     (and (get-buffer buffer)
                                          (kill-buffer buffer)))))
(defun custom-bury-buffer ()
  (if (string-match "*scratch*\\|reminder.org.gpg\\|Journal.org.gpg" (buffer-name))
      (progn
        (message "Not allowed to kill %s, burying instead" (buffer-name))
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
                    (list beg (1+ beg) (1- end) end))))))
       (and (not (eobp))
            (eq 7 (car-safe (syntax-after (point))))
            (save-excursion
              (let ((beg (point)))
                (condition-case nil
                    (progn
                      (forward-sexp 1)
                      (list beg (1+ beg) (1- (point)) (point)))))))))))

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

(defun text-scale-reset ()
  (interactive)
  (text-scale-set 0))

(bind-key "C-z"     'universal-argument)
(bind-key "C-c SPC" 'cua-rectangle-mark-mode)
(bind-key "C-x m"   'pop-to-mark-command)
(bind-key "C-x C-m" 'pop-to-mark-command)
(bind-key "M-o"     'other-window)
(bind-key "C-h"     'backward-delete-char-untabify)
(bind-key "C-a"     'beginning-or-prev-line)
(bind-key "C-e"     'end-or-next-line)
(bind-key "M-g"     '(lambda ()
                       (interactive)
                       (unwind-protect
                           (progn
                             (display-line-numbers-mode 1)
                             (goto-line (read-number "Goto line: ")))
                         (display-line-numbers-mode -1))))
;; custom keys
(bind-key "C-c h"     'help)
;; editing
(bind-key "M-%"       'query-replace-regexp)
(bind-key "C-c 5"     'query-replace)
(bind-key "C-M-5"     'query-replace)
(bind-key "M-k"       'kill-whole-line) ;; was M-K
(bind-key "C-w"       'backward-kill-word)
(bind-key "M-W"       'backward-kill-sexp)
(bind-key "M-u"       'upcase-dwim)
(bind-key "M-l"       'downcase-dwim)
(bind-key "M-SPC"     'cycle-spacing)
(bind-key "C-c C-SPC" 'delete-horizontal-space)
;; custom function binds
(bind-key "C-5"       'match-paren)
(bind-key "C-u"       'backward-kill-line)
(bind-key "C-x z"     '(lambda () ;; "Suspend frame inside of a terminal instance of Emacs."
                         (interactive)
                         (if (display-graphic-p)
                             (message "Suspend frame is disabled for X11 frames of emacs")
                           (suspend-frame))))
;; movement
(bind-key "M-p"       'backward-paragraph)
(bind-key "M-n"       'forward-paragraph)
(bind-key "<M-up>"    'backward-paragraph)
(bind-key "<M-down>"  'forward-paragraph)
;; mark
(bind-key "C-x C-h"   'mark-whole-buffer)
;; buffer
(bind-key "<M-prior>" 'previous-buffer)
(bind-key "<M-next>"  'next-buffer)
(bind-key "C-x k"     'kill-current-buffer)
(bind-key "C-x C-k"   'kill-buffer)
(bind-key "C-c r"     'revert-buffer)
(bind-key "C-x C-b"   'ibuffer) ;; was buffer-menu
;; windows
(bind-key "M-1"       'delete-other-windows)
(bind-key "M-2"       'split-window-below)
(bind-key "M-3"       'split-window-right)
(bind-key "M-4"       'make-frame-command)
(bind-key "M-0"       'delete-window)
(bind-key "C-x 4"     'make-frame-command)
(bind-key "C-0"       'balance-windows)
(bind-key "C-x C--"   'negative-argument)
(bind-key "C-c o"     'transpose-windows)
;;(bind-key "C-x t"     'transpose-lines)
;; misc
(bind-key "C-c 4"     'ispell-change-dictionary)
(bind-key "C-0"       'text-scale-reset)
(bind-key "C-="       'text-scale-increase)
(bind-key "C--"       'text-scale-decrease)
(bind-key "<f11>"     'global-display-fill-column-indicator-mode)
(bind-key "<f12>"     'global-display-fill-column-indicator-mode)

;; mode specific
(defun my-eval-buffer ()
  (interactive)
  (if (region-active-p)
      (progn
        (eval-region (region-beginning) (region-end))
        (message "Evaluated current region"))
    (progn
      (eval-buffer)
      (message "Evaluated current buffer"))))

(define-key emacs-lisp-mode-map (kbd "C-c C-c") 'my-eval-buffer)
(define-key lisp-interaction-mode-map (kbd "C-c C-c") 'my-eval-buffer)


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
  (bind-key "C-M-y"           'yank-primary)
  (bind-key "C-M-w"           'kill-ring-save-primary)
  (bind-key "<insert>"        'yank-primary)
  ;; window transposing
  (bind-key "s-o"             'transpose-windows)
  ;; buffers
  (bind-key "s-b"   'ibuffer)) ;; was buffer-menu

;; == mode maps
(define-key isearch-mode-map (kbd "C-o")
  (lambda ()
    (interactive)
    (let ((case-fold-search isearch-case-fold-search))
      (occur (if isearch-regexp isearch-string (regexp-quote isearch-string))))))

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
    (setq format (concat ";; " format))))
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

  (let* ((wn (if (use-region-p)
                 (progn
                   (buffer-substring-no-properties beg end)
                   (kill-region region-beginning region-end))
               (shell-quote-argument (read-string "Enter week number or date: "))))
         (insert (shell-command-to-string (format "week %s" (shell-quote-argument wn)))))))

(defalias 'kw 'week)
(defalias 'cw 'week)

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
             (setq bufname
                   (concat "*scratch" (if (= n 0) "" (int-to-string n)) "*"))
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

(global-set-key (kbd "C-c .")   'date)
(global-set-key (kbd "C-c C-.") 'tdate)
(global-set-key (kbd "C-c >")   'ldate)
(bind-key "C-;"     'toggle-comment-on-line)
(bind-key "M-#"     'toggle-case)

;; === internal modes ==========================================================
;; == ido

(require-soft 'ido
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
              (bind-key "C-x C-f" 'cido/lazy-ido-find-file)
              (bind-key "C-x d"   'cido/lazy-ido-dired)
              (bind-key "C-x b"   'cido/lazy-ido-switch-buffer)
              (bind-key "C-c b"   'cido/lazy-ido-switch-buffer-other-window))

;; ;; == dired
(require-soft 'dired-x
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
              (bind-key "C-x C-d" 'dired-jump)
              (bind-key "s-d"     'dired-jump)
              (define-key dired-mode-map "\C-h" 'dired-omit-mode)
              (define-key dired-mode-map "\C-d" 'dired-hide-details-mode))

(require-soft 'dired
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
                (dired-view-file)))
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
(define-key dired-mode-map (kbd "v")        'dired-find-file-other-window)
(define-key dired-mode-map (kbd "q")        'dired-quit-and-kill-window)
(define-key dired-mode-map (kbd "C-h")     'dired-omit-mode)
(define-key dired-mode-map (kbd "<right>")  'dired-find-or-view)
(define-key dired-mode-map (kbd "<left>")   'dired-jump-previous-dir)
(define-key dired-mode-map (kbd "C-d")     'dired-hide-details-mode)
(define-key dired-mode-map (kbd "r")        'revert-buffer)
(define-key dired-mode-map (kbd "/")        'occur)

;; == tex
(require-soft 'tex-mode
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
(require-soft 'org
              (add-hook 'org-mode-hook
                        (lambda ()
                          (electric-indent-local-mode -1)
                          (font-lock-mode t)))
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
                      org-log-done 'time
                      org-todo-keywords
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
                        ("FIXED"      . "palegreen"))
                      org-capture-templates
                      '(("t" "Todo"         entry (file corg/reminder)    "* TODO %t %?\n")
                        ("r" "Reminder"     entry (file corg/reminder)    "* TODO %t %?\n")
                        ("p" "Plan"         entry (file corg/reminder)    "* TODO %t %?\n")
                        ("n" "Notes"        entry (file corg/notes)       "* %T\n%?\n")
                        ("l" "Local notes"  entry (file corg/notes-local) "* %T\n%?\n")
                        ("m" "Misc notes"   entry (file corg/notes)       "* %T\n%?\n")
                        ("t" "til notes"    entry (file corg/til)         "* %T\n%?\n")
                        ("u" "uni notes"    entry (file corg/uni)         "* %T\n%?\n"))))

              (define-key org-mode-map (kbd "C-c e")       'org-latex-export-to-pdf)
              (define-key org-mode-map (kbd "C-c <right>") 'org-metaright)
              (define-key org-mode-map (kbd "C-c <left>")  'org-metaleft)
              (define-key org-mode-map (kbd "C-c C-.")     'org-time-stamp)
              (define-key org-mode-map (kbd "C-c 1")       'org-time-stamp-inactive))

;; == man
(require-soft 'man
              (setq Man-width 70)
              (define-key Man-mode-map (kbd "C-q") 'kill-buffer-and-window))

;; == yaml
(require-soft 'yaml-mode)
(defalias 'yml 'yaml-mode)

;; == narrow indirect
(require-soft 'narrow-indirect
              (setq ni-narrowed-buf-name-max 15)
              (bind-key (kbd "C-x n i") 'ni-narrow-to-region-indirect-other-window))

;; == grep (replace ripgrep)
(require-soft 'grep
              (grep-apply-setting
               'grep-find-command
               '("rg --no-heading --with-filename '' --glob='' " . 34))
              (defalias 'rg 'grep-find)
              (defalias 'ag 'grep-find))

;; 2022-05-25 Wed
;;; == ibuffer
(require-soft
 'ibuffer
 (setq ibuffer-formats
       '((mark modified read-only ;; " "(name 25 25 :left :elide)
               " " (name 30 30 :left :elide)
               " " (size 10 -1 :right)
               " " (mode 15 20 :left :elide)
               " " filename-and-process)
         (mark " " (name 16 -1) " " filename)))
 (defalias 'ib 'ibuffer)
 (define-key  ibuffer-mode-map (kbd "r") 'ibuffer-redisplay))

(require-soft
 'eww
 (setq
  shr-use-fonts nil ;; No special fonts
  shr-use-colors nil   ;; enable colours
  shr-color-visible-luminance-min 70
  shr-indentation 2  ;; Left-side margin
  shr-width 80)     ;; Fold text to 80 columns
 (define-key eww-mode-map (kbd "C-j") 'View-scroll-line-forward)
 (define-key eww-mode-map (kbd "C-k") 'View-scroll-line-backward))

;; == tab-bar
(require-soft
 'tab-bar
 (when (my_daemonp)
   (tab-bar-mode t))
 (setq  tab-bar-close-button-show nil
        tab-bar-mode t
        tab-bar-new-button-show nil
        tab-bar-new-tab-choice "*scratch*"
        tab-bar-new-tab-to 'rightmost
        tab-bar-tab-hints t
        )
 (custom-set-faces
  '(tab-bar-tab          ((t (:foreground "#e5e5e5" :background "#666666"))))
  '(tab-bar              ((t (:inherit header-line))))
  '(tab-bar-tab-inactive ((t (:inherit header-line)))))
 (bind-key "M-<left>"  'tab-bar-switch-to-prev-tab)
 (bind-key "M-<right>" 'tab-bar-switch-to-next-tab)
 (define-key key-translation-map (kbd "M-s") (kbd "C-x t"))  ; translate 'C-h' to DEL
 (define-key tab-prefix-map (kbd "c") 'tab-bar-new-tab)
 (define-key tab-prefix-map "n" 'tab-duplicate)
 (define-key tab-prefix-map "N" 'tab-new-to)
 (define-key tab-prefix-map "2" 'tab-new)
 (define-key tab-prefix-map "1" 'tab-close-other)
 (define-key tab-prefix-map (kbd "x") (lambda ()
                                        (interactive)
                                        (if (one-window-p)
                                            (tab-close)
                                          (delete-window))))
 (define-key tab-prefix-map (kbd "M-k") (lambda ()
                                          (interactive)
                                          (when (y-or-n-p (kbd "Kill current buffer and close screen? (kbd ")
                                                          (tab-close)
                                                          (kill-current-buffer)))))
 (define-key tab-prefix-map "u" 'tab-undo)
 (define-key tab-prefix-map "p" 'tab-next)
 (define-key tab-prefix-map "n" 'tab-previous)
 (define-key tab-prefix-map "s" 'tab-move)
 (define-key tab-prefix-map (kbd "M-s") 'tab-bar-switch-to-recent-tab)
 (define-key tab-prefix-map "g" 'tab-bar-select-tab)
 (define-key tab-prefix-map (kbd "M-<left>") (lambda()
                                               (interactive)
                                               (tab-move -1)))
 (define-key tab-prefix-map (kbd "M-<right>") (lambda()
                                                (interactive)
                                                (tab-move 1)))
 (define-key tab-prefix-map "G" 'tab-group)
 (define-key tab-prefix-map "4" 'tab-rename)
 (define-key tab-prefix-map "b" 'switch-to-buffer-other-tab)
 (define-key tab-prefix-map "f" 'find-file-other-tab)
 (define-key tab-prefix-map "\C-f" 'find-file-other-tab)
 (define-key tab-prefix-map "\C-r" 'find-file-read-only-other-tab)
 (define-key tab-prefix-map "t" 'tab-bar-mode)
 (define-key tab-prefix-map (kbd "h")      'split-window-horizontally)
 (define-key tab-prefix-map (kbd "v")      'split-window-veritcally)
 )

;; === external modes ==========================================================
;;; external packages
;; == yas
(require-soft 'yasnippet
              (setq yas-snippet-dirs '("~/.emacs.d/snippets")
                    yas-prompt-functions '(yas-ido-prompt
                                           yas-completing-prompt
                                           yas-no-prompt))
              (defun yas-force-update ()
                (interactive)
                (yas-recompile-all)
                (yas-reload-all))
              (yas-global-mode 1)
              (defalias 'yas 'yas-force-update))

;; == diminish
(require-soft 'diminish   ;; hide/"diminish" always enabled modes
              (diminish 'subword-mode) ;; iterate over camelCase
              (diminish 'yas-minor-mode)
              ;;  (diminish 'auto-fill-function)
              (diminish 'eldoc-mode))

;; == packages without config
;;(use-package auctex               :ensure t :defer t :pin gnu)
(require-soft 'go-mode)
(require-soft 'puppet-mode)
(require-soft 'haskell-mode)

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

(bind-key "C-c <return>"   'run-term)
(bind-key "C-c RET"        'run-term)
(bind-key "C-c <C-return>" 'run-beamer-term)
(bind-key "C-x C-<return>" 'run-local-term)

(defalias 'bterm     'beamer-term)
(defalias 'open-term 'run-term)

;; === frame ===================================================================
(defun is_tmux ()
	(if (= (length (getenv "TMUX")) 0) nil t))

(defun set-tmux-keys ()
	(let ((map (copy-keymap xterm-function-map)))
		(set-keymap-parent map (keymap-parent input-decode-map))
		(set-keymap-parent input-decode-map  xterm-function-map)))

(when (or (display-graphic-p) (daemonp))
	(unless (file-regular-p "~/git/dotfiles/x11/Xresources")
		(scroll-bar-mode -1)
		(tool-bar-mode -1)))

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
	  (set-frame-width  (selected-frame) 80)
    (setq default-frame-alist '((width . 80) (height . 57))
          initial-frame-alist default-frame-alist)))

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
(defalias 'gfl           'global-font-lock-mode)
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
(defalias 'lin           'display-line-numbers-mode)
(defalias 'ln            'display-line-numbers-mode)
(defalias 'tr            'toggle-truncate-lines)
(defalias 'fci           'display-fill-column-indicator-mode)
(defalias 'win-undo      'winner-undo)
(defalias 'win-redo      'winner-redo)
(defalias 'wundo         'winner-undo)
(defalias 'wredo         'winner-redo)
(defalias 'bw            'balance-windows)
(defalias 'conf          'conf-mode)
(defalias 'ro            'read-only-mode)
(defalias 'rw            'read-only-mode)
(defalias 'vi            'visual-line-mode)
(defalias 'flc           'font-lock-mode)

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
    )
  ;; === fonts ==================================================================
  (set-face-attribute 'variable-pitch nil :font "Sans-Serif-14")
  (setq dpi (string-to-number (shell-command-to-string "~/bin/dpi")))
  (defun ttf (&optional huge)
    (interactive)
    (let* ((ttfh (cond (huge        73)
                       ((= dpi 109) 79)
                       ((= dpi 125) 69)
                       ((= dpi 131) 75)
                       ((= dpi 138) 83) ;; was 88
                       ((= dpi 157) 63) ;; was 73
                       ((= dpi 190) 59)
                       (t           70)))
           (xfth       (/ ttfh 10.0))
           (family     "Deja Vu Sans Mono")
           (myfont     (concat family "-" (number-to-string xfth))))
      (custom-set-faces
       `(default ((t (:inherit default :height ,ttfh :width normal :foundry "PfEd" :family ,family)))))
      (setq default-frame-alist `((font . ,myfont))
            initial-frame-alist default-frame-alist)
      (set-frame-font myfont nil t))
    (set-foreground-color "#FFFFFF"))

  (defun pcf (&optional arg)
    (interactive)
    (let ((myfont
           (cond
            ((or (string= arg "9x18"))
             "-uw-ttyp0-medium-r-normal--18-170-75-75-c-90-iso10646-1")
            ((or (string= arg "9x16"))
             "-uw-ttyp0-medium-r-normal--16-150-75-75-c-80-iso10646-1")
            ((or t (string= arg "6x13"))
             "-gl-fixed-medium-r-semicondensed--13-120-75-75-c-60-iso10646-1"))))
      (set-face-attribute 'default t :font myfont)
      (setq default-frame-alist `((font . ,myfont))
            initial-frame-alist default-frame-alist)
      (set-frame-font myfont nil t)
      (set-foreground-color "#E5E5E5")))

  (defun 6x13 () (interactive) (pcf "6x13"))
  (defun 9x16 () (interactive) (pcf "9x16"))
  (defun 9x18 () (interactive) (pcf "9x18"))
  (defun default-font ()
    (interactive)
    (cond
     ((or (= dpi 109)
          (file-regular-p "~/.ttf") (ttf)))
     ((or (file-regular-p "~/.hf")
          (>= dpi 157))
      (9x16))
     (t                         (6x13))))

  (defalias 'df          'default-font)
  (defalias 'reset-fonts 'default-font)
  (defalias 'menlo       'ttf)
  (defalias 'meslo       'ttf)

  ;;(default-font)
  )

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
(setq theme/white (if (is_ttf) "#ffffff" "#e5e5e5"))
(defun theme/set-colours ()
  (frame-set-background-mode (selected-frame))
  (let* ((default-term
           (cond ((is_ssh)  '(:background "color-235"      :foreground "unspecified-fg"))
                 (t          '(:background "color-236"      :foreground "color-254")))))
    (custom-set-faces
     `(default ((((type tty))                        ,default-term)
                (((class color) (background light))  (:background "white"   :foreground "black"))
                (t                                   (:background "#333333" :foreground ,theme/white))))
     `(fringe  ((((class color) (background light))  (:background "#f2f2f2" :inherit default))
                (t                                   (:background "#1A1A1A" :inherit default))))
     )
    ))
(setq frame-background-mode 'dark)
(theme/set-colours)

(defun theme/turn-off-font-lock ()
	(font-lock-mode 0)
  (buffer-face-mode 0))

(defun theme/turn-on-font-lock ()
  (font-lock-mode 1)
  (if (display-graphic-p)
      (if (is_ttf)
          (buffer-face-set :background "black" :foreground "#e5e5e5")
        (buffer-face-set :background "black" :foreground "grey"))
    (buffer-face-set :background "color-16")))

(defun theme/font-lock ()
  (interactive)
  (if (my_daemonp)
      (if font-lock-mode
          (theme/turn-off-font-lock)
        (theme/turn-on-font-lock))
    (if font-lock-mode
        (font-lock-mode 0)
      (turn-on-font-lock))))

(defun theme/light ()
  (interactive)
  (if (eq frame-background-mode t)
      (progn
        (setq frame-background-mode 'light)
        (theme/set-colours))
    (progn
      (setq frame-background-mode t)
      (theme/set-colours))))

(if (my_daemonp)
    (defalias 'fl 'theme/font-lock)
  (defalias 'fl 'font-lock-mode))

(bind-key "<f2>"   'theme/font-lock)
(bind-key "C-<f2>" 'theme/light)
(bind-key "M-<f2>" 'theme/gl-dark)

(custom-set-faces
 `(region                              ((t (:foreground ,theme/white :background "#114488" :extend t))))
 `(cursor                              ((t            (:background "#00ff00" :foreground "#000000"))))
 `(border                              ((t            (:foreground "#0000ff"))))
 `(minibuffer-prompt                   ((t (:inherit default :bold t))))
 `(mode-line                           ((t (:inherit default :background "#292929"))))
 `(mode-line-buffer-id                 ((((type tty)) (:bold nil))))
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
 `(org-headline-done                   ((t (:foreground "#FFA07A" :bold nil))))
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

 `(Man-overstrike                   ((t (:inherit default :bold t))))
 `(Man-underline                    ((t (:foreground "#4286F4" :underline nil :bold t))))

 `(error                            ((t (:foreground "#ff0000" :bold t))))

 `(show-paren-match                 ((t (:foregroubd "#ffffff" :background "#4f94cd"))))
 `(show-paren-mismatch              ((t (:foreground "#ffffff" :background "#a020f0"))))

 `(escape-glyph                     ((t (:foreground "#00ffff" :bold t))))

 `(header-line                      ((t (:foreground "#E5E5E5" :background "#292929" :box (:line-width -1 :style released-button)))))
 `(elscreen-tab-background-face     ((t (:inherit header-line))))
 `(elscreen-tab-control-face        ((t (:inherit elscreen-tab-background-face))))
 `(elscreen-tab-other-screen-face   ((t (:inherit elscreen-tab-background-face))))
 `(elscreen-tab-current-screen-face ((((type tty)) (:inherit mode-line-inactive))
                                     (t (:foreground "#e5e5e5" :background "#666666"))))

 `(highlight                        ((t (:inherit default :background "#556b2f"))))

 `(smerge-base                     ((t (:background "#ffffaa" :foreground "#000000" :extend t))))
 `(smerge-lower                    ((t (:background "#ddffdd" :foreground "#000000" :extend t))))
 `(smerge-markers                  ((t (:background "#d9d9d9" :foreground "#000000" :extend t))))
 `(smerge-refined-added            ((t (:background "#aaffaa" :foreground "#000000" :extend t))))
 `(smerge-refined-removed          ((t (:background "#ffbbbb" :foreground "#000000" :extend t))))
 `(smerge-upper                    ((t (:background "#ffdddd" :foreground "#000000" :extend t))))
 )

(if (daemonp)
    (theme/set-colours)
  (if (is_ssh)
      (custom-set-faces
       `(mode-line-buffer-id ((t (:inherit mode-line-buffer-id :foreground "#B680BB" :bold t))))
       `(mode-line-inactive  ((t (:foreground "#847f54" :background "#292424" :weight normal))))
       `(mode-line           ((t (:background "#373333"  :foreground "#838383" :bold t)))))))

(global-font-lock-mode 0)
(global-eldoc-mode 0)
(add-hook 'puppet-mode-hook  'theme/turn-on-font-lock)
(add-hook 'diff-mode-hook    'turn-on-font-lock)
(add-hook 'ibuffer-hook      'turn-on-font-lock)
(add-hook 'dired-mode-hook   'turn-on-font-lock)
(add-hook 'org-mode-hook     'turn-on-font-lock)
(add-hook 'mail-mode-hook    'turn-on-font-lock)
(add-hook 'Man-mode-hook     'turn-on-font-lock)
(add-hook 'ibuffer-mode-hook 'turn-on-font-lock)
(add-hook 'css-mode-hook     'turn-on-font-lock)

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
 '(display-time-mode nil)
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
 '(line-move-visual t)
 '(epg-gpg-home-directory "~/.gnupg")
 '(indent-tabs-mode t)
 '(sh-basic-offset 8)
 '(tab-width 8)
 '(c-default-style '((awk-mode  . "awk")  (other     . "linux")))
 '(backward-delete-char-untabify-method 'hungry)
 '(ispell-dictionary "en_GB")
 '(frame-title-format  (if (daemonp)
                           '(multiple-frames "emacsclient - %b" ("emacsclient" "@" system-name " - " "%b"))
                         '(multiple-frames "%b" ("emacs" "@" system-name " - " "%b"))))
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
 '(mouse-yank-at-point t)
 '(savehist-mode 1)
 '(transient-mark-mode t)
 '(delete-selection-mode t)
 '(global-subword-mode 1) ; iterate through CamelCase words
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
 '(package-selected-packages
   '(elscreen yasnippet diminish go-mode haskell-mode))
 ;; 2022-05-23 Mon emacs 28.1
 '(mouse-wheel-scroll-amount '(5 ((shift) . 1)))
 '(use-short-answers t )
 '(revert-buffer-quick-short-answers use-short-answers)
 '(dired-kill-when-opening-new-dired-buffer t)
 )
