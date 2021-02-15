;; Custom keybinds
;; disabled keybinds
(global-unset-key (kbd "<f2>"))
(global-unset-key (kbd "<insert>"))
(global-unset-key (kbd "<insertchar>"))
(global-unset-key (kbd "C-C"))
(global-unset-key (kbd "<F3>"))
(global-unset-key (kbd "<F4>"))
(global-unset-key (kbd "<f3>"))
(global-unset-key (kbd "<f4>"))
(global-unset-key (kbd "M-l"))
;; custom region
(defconst custom-region-alist
  `((mark-active
     ,@(let ((m (make-sparse-keymap)))
         (define-key m (kbd "C-w")        'kill-region)
         (define-key m (kbd "<S-delete>") 'kill-region)
         (define-key m (kbd "M-L")        'downcase-region)
         (define-key m (kbd "C-x C-l")    'downcase-region)
         (define-key m (kbd "M-U")        'upcase-region)
         (define-key m (kbd "C-x C-u")    'upcase-region)
         (define-key m (kbd "C-M-/")      'indent-region)
         (define-key m (kbd "M-|")        'shell-command-on-region)
         (define-key m (kbd "M-:")        'eval-region)
         m))))
(add-to-list 'emulation-mode-map-alists 'custom-region-alist)

;; custom functions
(defun delete-and-balance-window ()
  "Balance remaining windows on deletion."
  (interactive)
  (delete-window)
  (balance-windows))

(defun match-paren (&optional arg)
  "Go to the matching parenthesis character if one is adjacent to point."
  (interactive "^p")
  (cond ((looking-at "\\s(") (forward-sexp arg))
        ((looking-back "\\s)" 1) (backward-sexp arg))
        ((looking-at "\\s)") (forward-char) (backward-sexp arg))
        ((looking-back "\\s(" 1) (backward-char) (forward-sexp arg))))

(defun kill-buffer-and-window ()
  "If a buffer is within its own window, kill both"
  (interactive)
  (if (one-window-p)
      (kill-current-buffer)
    (progn
      (kill-current-buffer)
      (delete-and-balance-window))))

(defun backward-kill-line (arg)
  "Kill ARG lines backward."
  (interactive "p")
  (if (eq (point) (line-beginning-position))
      (delete-indentation)
    (kill-line (- 1 arg))))

(defun custom-suspend-frame ()
  "Suspend frame inside of a terminal instance of Emacs."
  (interactive)
  (if (display-graphic-p)
      (message "Suspend frame is disabled for X11 frames of emacs")
    (suspend-frame)))

(defun transpose-windows (arg)
  "Transpose the buffers shown in two windows."
  (interactive "p")
  (let ((selector (if (>= arg 0) 'next-window 'previous-window)))
    (while (/= arg 0)
      (let ((this-win (window-buffer))
            (next-win (window-buffer (funcall selector))))
        (set-window-buffer (selected-window) next-win)
        (set-window-buffer (funcall selector) this-win)
        (select-window (funcall selector)))
      (setq arg (if (cl-plusp arg) (1- arg) (1+ arg)))
      (message "Transposing windows"))))

(defun scroll-line-down ()
  (interactive)
  (scroll-up 1))
(defun scroll-line-up ()
  (interactive)
  (scroll-down 1))

(defun backward-other-window ()
  (interactive)
  (other-window -1))

(defun my-goto-line ()
  (interactive)
  (unwind-protect
      (progn
        (display-line-numbers-mode 1)
        (goto-line (read-number "Goto line: ")))
    (display-line-numbers-mode -1)))

(bind-keys*
  ("C-z"       . undo)
  ("M-u"       . universal-argument)
  ("C-x SPC"   . rectangle-mark-mode)
  ("C-x C-SPC" . rectangle-mark-mode)
  ("C-c SPC"   . cua-rectangle-mark-mode))
;; custom keys
(bind-keys
 ("C-h"       . backward-delete-char-untabify)
 ("M-g"       . my-goto-line)
 ("C-c h"     . help)
 ;; editing
 ("C-x 5"     . query-replace)
 ("C-c 5"     . query-replace-regexp)
 ("M-k"       . kill-whole-line)
 ("C-w"       . backward-kill-word)
 ("M-W"       . backward-kill-sexp)
 ("M-U"       . upcase-word)
 ("M-L"       . downcase-word)
 ;; custom function binds
 ("C-x C-0"   . delete-and-balance-window)
 ("C-c 0"     . balance-windows)
 ("C-5"       . match-paren)
 ("C-x C-k"   . kill-buffer-and-window)
 ("C-u"       . backward-kill-line)
 ("C-x z"     . custom-suspend-frame)
 ("C-x C-z"   . repeat)
 ;; movement
 ("M-p"       . backward-paragraph)
 ("M-n"       . forward-paragraph)
 ("<M-up>"    . backward-paragraph)
 ("<M-down>"  . forward-paragraph)
 ;; mark
 ("C-x C-h"   . mark-whole-buffer)
 ("C-x C-@"   . rectangle-mark-mode)
 ("M-m"       . pop-global-mark)
 ("C-x m"     . exchange-point-and-mark)
 ;; misc
 ("C-<f3>"    . kmacro-start-macro-or-insert-counter)
 ("C-<f4>"    . kmacro-end-or-call-macro)
 ("<f9>"      . font-lock-mode)
 ("C-<f9>"    . global-font-lock-mode)
 ("C-<f10>"   . menu-bar-mode)
 ("<f11>"     . whitespace-mode)
 ("C-<f11>"   . font-lock-mode)
 ("<f12>"     . display-fill-column-indicator-mode)
 ("C-<f12>"   . display-line-numbers-mode)
 ("C-x C-d"   . dired-jump)
 ("C-c v"     . scroll-other-window)
 ("C-c C-v"   . scroll-other-window-down)
 ;; buffer
 ("<C-prior>" . previous-buffer)
 ("<C-next>"  . next-buffer)
 ("<M-prior>" . previous-buffer)
 ("<M-next>"  . next-buffer)
 ("C-x k"     . kill-current-buffer)
 ("C-c r"     . revert-buffer)
 ("<f5>"      . revert-buffer)
 ("C-x C-b"   . ibuffer)
 ;; windows
 ("M-o"       . other-window)
 ("C-c t"     . transpose-windows)
 ("C-x t"     . transpose-lines)
 ;; misc
 ("C-c C-f"     . find-file-at-point))
;; mode specific
(defun custom-eval-buffer ()
  (interactive)
  (eval-buffer)
  (message "Evaluated current buffer"))
(bind-keys :map emacs-lisp-mode-map
           ("C-c C-c" . custom-eval-buffer))
;; man pages
(require 'man)
(bind-keys :map Man-mode-map
           ("q"      . kill-buffer-and-window)
           ("<up>"   . scroll-line-up)
           ("<down>" . scroll-line-down)
           ("k"      . scroll-line-up)
           ("j"      . scroll-line-down)
           ("/"      . isearch-forward)
           ("g"      . beginning-of-buffer)
           ("G"      . end-of-buffer))
;; view mode
(require 'view)
(bind-keys :map view-mode-map
           ("v"      . View-exit)
           ("C-q"    . View-quit)
           ("q"      . kill-buffer-and-window)
           ("<left>" . kill-buffer-and-window)
           ("C-g"    . kill-buffer-and-window)
           ("s-1"    . kill-buffer-and-window)
           ("s-0"    . kill-buffer-and-window)
           ("<up>"   . scroll-line-up)
           ("<down>" . scroll-line-down)
           ("k"      . scroll-line-up)
           ("j"      . scroll-line-down)
           ("/"      . isearch-forward)
           ("g"      . beginning-of-buffer)
           ("G"      . end-of-buffer))
;; non x11 tui only
(when (not (or (display-graphic-p) (daemonp)))
  (bind-keys*
   ("C-M-i"      . other-window)))

(use-package ace-window
  :ensure nil
  :bind
  (("C-x C-o" . ace-window)))
