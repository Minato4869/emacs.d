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
      (delete-and-balance-window))))

;; 2022-01-23 Sun @leahneukirchen
(defun toggle-comment-on-line ()
  "comment or uncomment current line"
  (interactive)
  (comment-or-uncomment-region (line-beginning-position) (line-end-position)))

;; == keybinds =================================================================
(bind-keys
 ("C-c ."   . date)
 ("C-c C-." . tdate)
 ("C-c >"   . ldate)
 ("C-;"     . toggle-comment-on-line)
 ("M-#"     . toggle-case))
