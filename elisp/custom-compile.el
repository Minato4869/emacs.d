;; Don’t ask to save files before compilation, just save them.
(setq compilation-ask-about-save nil)
;; Don’t ask to kill currently running compilation, just kill it.
(setq compilation-always-kill t)

(defun ccompile/colourise-buffer ()
  (toggle-read-only)
  (ansi-color-apply-on-region compilation-filter-start (point))
  (toggle-read-only))

(add-hook
 'compilation-filter-hook
 (lambda ()
   (require 'ansi-color)
   (ccompile/colourise-buffer)))

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

(bind-keys
 ("<f5>"   . ccompile/recompile)
 ("C-<f5>" . compile-parent))
