(defun custom-lazy-ido-enable ()
  "since ido is loaded with Emacs, use-package cannot defer"
  (ido-mode t)
  (setq
   ido-enable-flex-matching t
   ido-auto-merge-work-directories-length -1
   ido-default-buffer-method 'selected-window
   ido-default-file-method 'selected-window
   ido-everywhere t)
  (if (require 'ido-sort-mtime nil t)
      (ido-sort-mtime-mode t)))
(defun custom-lazy-ido-switch-buffer ()
  "ibuffer wrapper"
  (interactive)
  (custom-lazy-ido-enable)
  (call-interactively 'ido-switch-buffer))
(defun custom-lazy-ido-find-file ()
  "find-file wrapper"
  (interactive)
  (custom-lazy-ido-enable)
  (call-interactively 'ido-find-file))
(defun custom-lazy-ido-dired ()
  "find-file wrapper"
  (interactive)
  (custom-lazy-ido-enable)
  (call-interactively 'ido-dired))

(use-package ido
  :bind
  (("C-x C-f" . custom-lazy-ido-find-file)
   ("s-d"     . custom-lazy-ido-dired)
   ("C-x C-d" . custom-lazy-ido-dired)
   ("C-x C-b" . custom-lazy-ido-switch-buffer)))
