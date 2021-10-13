;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; date
(defun date ()
  (interactive)
  (insert (format-time-string "<%Y-%m-%d %a>")))
(defalias 'ymd 'date)

(defun date-time ()
  (interactive)
  (insert (format-time-string "<%Y-%m-%d %a>")))

(defun ldate ()
  (interactive)
  (insert (format-time-string "<%a %e %b (%Y-%m-%d)>")))
(defun ldate.1 ()
  (interactive)
  (insert (format-time-string "<%a %b %e %H:%M  %Y (%Y-%m-%d)>")))

(bind-keys
 ("C-c ." . date)
 ("C-c C-." . date-time))

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
