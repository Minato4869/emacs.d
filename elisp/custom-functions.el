;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; yas
(defun yas-force-update ()
  (interactive)
  (yas-recompile-all)
  (yas-reload-all))
(defalias 'yas 'yas-force-update)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; date
(defun ymd ()
  (interactive)
  (insert (format-time-string "%Y-%m-%d")))

(defun date ()
  (interactive)
  (insert (format-time-string "%a %e %b (%Y-%m-%d)")))
(defun ldate ()
  (interactive)
  (insert (format-time-string "%a %b %e %H:%M  %Y (%Y-%m-%d)")))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; notes

(defun load-note (file)
  (find-file (concat "~/" file))
  (auto-revert-mode)
  (org-mode)
  (end-of-buffer))
(defun rem ()
  (interactive)
  (load-note ".personal/notes/reminder/reminder.org")
  (outline-show-all))
(defun arem () (interactive) (load-note ".personal/notes/reminder/reminder.archive.org"))
(defun n ()    (interactive) (load-note "notes.org"))
(defun nlc ()  (interactive) (load-note ".local/notes.local.org"))
(defun plan ()
  (interactive)
  (load-note ".personal/notes/plan/plan.org")
  (outline-show-all))
(defun uni ()  (interactive) (load-note ".local/uni_notes.org"))
(defun til ()  (interactive) (load-note ".local/til_notes.org"))
(defalias 'p 'plan)
(defalias 'pl 'plan)
(defalias 'rema 'arem)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; ag
(require 'compile)

(define-compilation-mode ag-mode "Ag"
  "Ag results compilation mode")

(defun ag/find-file ()
  (interactive)
  (let ((filename (buffer-substring (line-beginning-position) (line-end-position))))
    (if (not (string-match "^[^:numeric:]+\:" filename))
        (find-file-at-point (concat default-directory filename))
      (message "Current line does not contain a filename"))))

(defun ag/kill-buffer ()
  (interactive)
  (let
      (kill-buffer-query-functions)
    (kill-buffer)))
(bind-keys :map ag-mode-map
           ("<return>" . ag/find-file)
           ("f"        . ag/find-file)
           ("p"        . backkward-paragraph)
           ("n"        . forward-paragraph)
           ("k"        . ag/kill-buffer))


(defun ag/search-string (string)
  (progn
    (setq string (prin1-to-string string)) ;; escape special chars
    (set (make-local-variable 'command-string)
         (concat "ag -Q -S " string))
    (compilation-start command-string #'ag-mode)))

(defun ag ()
  (interactive)
  (let (input)
    (if (use-region-p)
        (setq input (buffer-substring-no-properties (region-beginning) (region-end)))
      (setq input (read-string "ag: ")))
    (ag/search-string input)))

(bind-key* "C-c C-s" 'ag)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; compile
;; Don’t ask to save files before compilation, just save them.
(setq compilation-ask-about-save nil
      compilation-always-kill t)
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
 ("<f6>"     . ccompile/recompile)
 ("C-c <f6>" . compile-parent)
 ("C-<f6>"   . compile)
 ("C-c m"    . compile)
 ("C-c C-m"  . ccompile/recompile))
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
