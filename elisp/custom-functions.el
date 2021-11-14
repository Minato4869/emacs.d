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

(defun _calendar-week ()
  (shell-command-to-string "~/bin/week"))
(defun calendar-week ()
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

(bind-keys
 ("C-c ." . date)
 ("C-c C-." . date-time)
 ("C-c >" . date-time))
(defalias 'kw 'calendar-week)
(defalias 'cw 'calendar-week)
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
