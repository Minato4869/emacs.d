(defun cido/lazy-ido-enable ()
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

(defun cido/lazy-ido-switch-buffer ()
  "ibuffer wrapper"
  (interactive)
  (cido/lazy-ido-enable)
  (call-interactively 'ido-switch-buffer))
(defun cido/lazy-ido-switch-buffer-other-window ()
  "ibuffer wrapper"
  (interactive)
  (cido/lazy-ido-enable)
  (call-interactively 'ido-switch-buffer-other-window))
(defun cido/lazy-ido-find-file ()
  "find-file wrapper"
  (interactive)
  (cido/lazy-ido-enable)
  (call-interactively 'ido-find-file))
(defun cido/lazy-ido-dired ()
  "find-file wrapper"
  (interactive)
  (cido/lazy-ido-enable)
  (call-interactively 'ido-dired))

(use-package ido
  :ensure nil
  :bind
  (("s-d"     . cido/lazy-ido-dired)
   ("C-x C-f" . cido/lazy-ido-find-file)
   ("C-x C-d" . cido/lazy-ido-dired)
   ("C-x b"   . cido/lazy-ido-switch-buffer)
   ("C-c b"   . cido/lazy-ido-switch-buffer-other-window)))
