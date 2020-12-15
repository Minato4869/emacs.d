;;; Custom keybinds
;; disabled keybinds
(global-unset-key (kbd "<f2>"))
(global-unset-key (kbd "<insert>"))
(global-unset-key (kbd "<insertchar>"))
(global-unset-key (kbd "C-C"))
(global-unset-key (kbd "<F3>"))
(global-unset-key (kbd "<F4>"))
;; custom region
(defconst custom-region-alist
  `((mark-active
     ,@(let ((m (make-sparse-keymap)))
         (define-key m (kbd "C-w") 'kill-region)
         (define-key m (kbd "M-L") 'downcase-region)
         (define-key m (kbd "M-U") 'upcase-region)
         (define-key m (kbd "M-:") 'eval-region)
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
      (setq arg (if (plusp arg) (1- arg) (1+ arg))))))

(defun scroll-line-down ()
  (interactive)
  (scroll-up 1))
(defun scroll-line-up ()
  (interactive)
  (scroll-down 1))

;; custom keys
(bind-keys
 ("C-c h"     . help)
 ;; editing
 ("C-h"       . backward-delete-char-untabify)
 ("C-z"       . undo)
 ("M-u"       . universal-argument)
 ("C-c 5"     . query-replace)
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
 ("M-g"       . goto-line)
 ("M-p"       . backward-paragraph)
 ("M-n"       . forward-paragraph)
 ;; mark
 ("C-x C-h"   . mark-whole-buffer)
 ("C-x SPC"   . rectangle-mark-mode)
 ("C-x C-SPC" . cua-rectangle-mark-mode)
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
 ("<f12>"     . display-line-numbers-mode)
 ("C-<f12>"   . display-fill-column-indicator-mode)
 ("C-x C-d"   . dired-jump)
 ;; buffer
 ("<C-prior>" . previous-buffer)
 ("<C-next>"  . next-buffer)
 ("<M-prior>" . previous-buffer)
 ("<M-next>"  . next-buffer)
 ("<M-left>"  . previous-buffer)
 ("<M-right>" . next-buffer)
 ("C-x k"     . kill-current-buffer)
 ("C-c r"     . revert-buffer)
 ("<f5>"      . revert-buffer)
 ("C-x b"     . ibuffer)
 ;; windows
 ("M-o"       . other-window)
 ("C-c o"     . other-window)
 ("C-x C-o"   . transpose-windows))

;; mode specific
(bind-keys :map emacs-lisp-mode-map
           ("C-c C-c" . eval-buffer))

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
(bind-keys
 ("\033[1;5A" . ck-tmux/backward-paragraph)
 ("\033[1;5B" . ck-tmux/forward-paragraph)
 ("\033[1;5D" . ck-tmux/backward-word)
 ("\033[1;5C" . ck-tmux/forward-word))

(require 'view)
(require 'man)
(bind-keys :map Man-mode-map
           ("q"      . kill-buffer-and-window)
           ("C-g"    . kill-buffer-and-window)
           ("<up>"   . scroll-line-up)
           ("<down>" . scroll-line-down)
           ("k"      . scroll-line-up)
           ("j"      . scroll-line-down)
           ("/"      . isearch)
           ("g"      . beginning-of-buffer)
           ("G"      . end-of-buffer))

(bind-keys :map view-mode-map
           ("v"      . View-exit)
           ("C-q"    . View-quit)
           ("<left>" . kill-buffer-and-window)
           ("C-g"    . kill-buffer-and-window)
           ("<up>"   . scroll-line-up)
           ("<down>" . scroll-line-down)
           ("k"      . scroll-line-up)
           ("j"      . scroll-line-down)
           ("/"      . isearch)
           ("g"      . beginning-of-buffer)
           ("G"      . end-of-buffer))
