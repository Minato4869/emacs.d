;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; date
(defun ymd ()
  (interactive)
  (insert (format-time-string "<%Y-%m-%d %a>")))
(defalias 'date 'ymd)
(defun ldate ()
  (interactive)
  (insert (format-time-string "<%a %e %b (%Y-%m-%d)>")))
(defun ldate.1 ()
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

;;; resize window

(defun cf/resize-frame (&optional width height)
  (set-frame-width (selected-frame) width)
  (set-frame-height (selected-frame) height))

(defun resize-frame-80x25 ()
  (interactive)
  (cf/resize-frame 80 25))

(defun resize-frame-80x57 ()
  (interactive)
  (cf/resize-frame 80 57))

(defun resize-frame-115x57 ()
  (interactive)
  (cf/resize-frame 115 57))
(defun resize-frame-160x57 ()
  (interactive)
  (cf/resize-frame 160 57))

(defun resize-frame-180x57 ()
  (interactive)
  (cf/resize-frame 180 57))

(bind-keys
 ("s-1"     . resize-frame-80x25)
 ("C-1"     . resize-frame-80x57)
 ("C-2"     . resize-frame-115x57)
 ("C-3"     . resize-frame-160x57)
 ("C-4"     . resize-frame-180x57))
