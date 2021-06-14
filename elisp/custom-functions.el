;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; date
(defun ymd ()
  (interactive)
  (insert (format-time-string "<%Y-%m-%d>")))

(defun date ()
  (interactive)
  (insert (format-time-string "<%a %e %b (%Y-%m-%d)>")))
(defun ldate ()
  (interactive)
  (insert (format-time-string "<%a %b %e %H:%M  %Y (%Y-%m-%d)>")))

(defun time ()
  (interactive)
  (insert (format-time-string "<%H:%M>")))

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
 ("C-<f6>"   . compile))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; desktop save
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

(defun reset-emacs ()
  (interactive)
  (setq default-frame-alist
        `((width  . 80) (height . 48)))
  (load "~/.emacs.d/init.el"))

;; notes
(defun load-note (file &optional p_prefix)
  (if (string= "" p_prefix)
      (find-file (concat "~/" file))
    (find-file (concat p_prefix file)))
  (auto-revert-mode)
  (org-mode)
  (end-of-buffer))
