;; custom-keys.el
(defun ck-tmux/check-term ()
  (when (or (not (equal "" (getenv "TMUX")))
            (and (daemonp) (not (display-graphic-p))))
    t))
(defun ck-tmux/backward-paragraph()
  (interactive)
    (when (ck-tmux/check-term)
      (backward-paragraph-word)))
(defun ck-tmux/forward-paragraph()
  (interactive)
  (when (ck-tmux/check-term)
    (forward-paragraph)))
(defun ck-tmux/backward-word()
  (interactive)
  (when (ck-tmux/check-term)
    (backward-word)))
(defun ck-tmux/forward-word()
  (interactive)
  (when (ck-tmux/check-term)
    (forward-word)))
(bind-keys*
 ("\033[1;5A" . ck-tmux/backward-paragraph)
 ("\033[1;5B" . ck-tmux/forward-paragraph)
 ("\033[1;5D" . ck-tmux/backward-word)
 ("\033[1;5C" . ck-tmux/forward-word))
;; init.el
(set-window-scroll-bars (minibuffer-window) nil nil)
;; backup-autosave.el
(setq backup-directory-alist '(("" . "~/.emacs.d/backup")))
(setq auto-save-file-name-transforms '((".*" "~/.emacs.d/autosave/" t)))

 auto save buffers on focus loss
(defun save-all ()
  (interactive)
  (save-some-buffers t))
  (add-hook 'focus-out-hook 'save-all)

;; custom-compile.el
(defun ccompile/colourise-buffer ()
  (toggle-read-only)
  (ansi-color-apply-on-region compilation-filter-start (point))
  (toggle-read-only))

(add-hook
 'compilation-filter-hook
 (lambda ()
   (require 'ansi-color)
   (ccompile/colourise-buffer)))
