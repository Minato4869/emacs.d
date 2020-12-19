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
;;(set-window-scroll-bars (minibuffer-window) nil nil)
