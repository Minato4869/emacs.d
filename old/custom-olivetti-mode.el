(setq-default olivetti-body-width 90)

(defun custom-olivetti-mode ()
  (interactive)
  (when (or (daemonp) (display-graphic-p))
    (if (bound-and-true-p olivetti-mode)
        (set-fringe-mode nil)
      (set-fringe-mode 0)))
  (if (bound-and-true-p olivetti-mode)
        (olivetti-mode -1)
    (olivetti-mode t)))
(bind-key* "C-<f12>" 'custom-olivetti-mode)
