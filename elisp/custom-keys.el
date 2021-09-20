;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; custom keybinds

;; disabled keybinds
;;(global-unset-key (kbd "<f1>"))
;;(global-unset-key (kbd "<f2>"))
(global-unset-key (kbd "<insert>"))
(global-unset-key (kbd "<insertchar>"))
(global-unset-key (kbd "M-l"))
(global-unset-key (kbd "C-z"))
(global-unset-key (kbd "C-_"))
(global-unset-key (kbd "<C-up>"))
(global-unset-key (kbd "<C-down>"))

;; custom region
(defconst custom-region-alist
  `((mark-active
     ,@(let ((m (make-sparse-keymap)))
         (define-key m (kbd "C-w")        'kill-region)
         (define-key m (kbd "C-M-/")      'indent-region)
         (define-key m (kbd "M-|")        'shell-command-on-region)
         m))))
(add-to-list 'emulation-mode-map-alists 'custom-region-alist)

;; custom functions
(defun match-paren (&optional arg)
  "Go to the matching parenthesis character if one is adjacent to point."
  (interactive "^p")
  (cond ((looking-at "\\s(") (forward-sexp arg))
        ((looking-back "\\s)" 1) (backward-sexp arg))
        ((looking-at "\\s)") (forward-char) (backward-sexp arg))
        ((looking-back "\\s(" 1) (backward-char) (forward-sexp arg))))

(defun delete-and-balance-window ()
  (interactive)
  (delete-window)
  (balance-windows))
(defun kill-buffer-and-window ()
  "If a buffer is within its own window, kill both"
  (interactive)
  (if (one-window-p)
      (progn
        (kill-current-buffer)
        (tab-bar-close-tab))
    (progn
      (kill-current-buffer)
      (delete-and-balance-window))))

(defun backward-kill-line (arg)
  "Kill ARG lines backward."
  (interactive "p")
  (if (eq (point) (line-beginning-position))
      (delete-indentation)
    (kill-line (- 1 arg))))


;; zsh like C-a/C-e
(defun beginning-or-prev-line ()
  "Kill ARG lines backward."
  (interactive)
  (if (eq (point) (line-beginning-position))
      (progn
        (previous-line)
        (beginning-of-line))
    (beginning-of-line)))

(defun end-or-next-line ()
  "Kill ARG lines backward."
  (interactive)
  (if (eq (point) (line-end-position))
      (progn
        (next-line)
        (end-of-line))
    (end-of-line)))

(defun custom-suspend-frame ()
  "Suspend frame inside of a terminal instance of Emacs."
  (interactive)
  (if (display-graphic-p)
      (message "Suspend frame is disabled for X11 frames of emacs")
    (suspend-frame)))

(defun transpose-windows (arg)
  "Transpose the buffers shown in two windows."
  (interactive "p")
  (unless (one-window-p)
    (let ((selector (if (>= arg 0) 'next-window 'previous-window)))
      (while (/= arg 0)
        (let ((this-win (window-buffer))
              (next-win (window-buffer (funcall selector))))
          (set-window-buffer (selected-window) next-win)
          (set-window-buffer (funcall selector) this-win)
          (select-window (funcall selector)))
        (setq arg (if (cl-plusp arg) (1- arg) (1+ arg)))
        (other-window -1)
        (message "Transposing windows")))))

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

(defun text-scale-reset ()
  (interactive)
  (text-scale-set 0))

(bind-keys*
 ("C-z"       . undo)
 ("M-u"       . universal-argument)
 ("C-x C-SPC" . rectangle-mark-mode)
 ("C-c SPC"   . cua-rectangle-mark-mode)
 ("C-x C-@"   . rectangle-mark-mode)
 ("M-o"       . other-window))
;; custom keys
(bind-keys
 ("C-h"       . backward-delete-char-untabify)
 ("C-a"       . beginning-or-prev-line)
 ("C-e"       . end-or-next-line)
 ("M-g"       . my-goto-line)
 ("C-c h"     . help)
 ("C-c C-k"   . kill-buffer-and-window)
 ;; editing
 ("C-x 5"     . query-replace-regexp)
 ("C-x C-5"   . query-replace-regexp)
 ("C-c 5"     . query-replace)
 ("M-k"       . kill-whole-line)
 ("C-w"       . backward-kill-word)
 ("M-W"       . backward-kill-sexp)
 ("M-U"       . upcase-dwim)
 ("M-L"       . downcase-dwim)
 ;; custom function binds
 ("C-x C-0"   . delete-and-balance-window)
 ("C-c 0"     . balance-windows)
 ("C-5"       . match-paren)
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
 ;; misc
 ("<f9>"      . font-lock-mode)
 ("C-<f9>"    . font-lock-fontify-buffer)
 ("C-<f10>"   . menu-bar-mode)
 ("<f11>"     . whitespace-mode)
 ("<f12>"     . display-fill-column-indicator-mode)
 ("C-<f12>"   . display-line-numbers-mode)
 ("C-c 1"     . shell-command)
 ("C-c 7"     . async-shell-command)
 ;; buffer
 ("<C-prior>" . previous-buffer)
 ("<C-next>"  . next-buffer)
 ("<M-prior>" . previous-buffer)
 ("<M-next>"  . next-buffer)
 ("C-x k"     . kill-current-buffer)
 ("C-x C-k"   . kill-buffer)
 ("C-c r"     . revert-buffer)
 ;; windows
 ("C-x C-o"   . transpose-windows)
 ("C-c t"     . transpose-windows)
 ("C-x t"     . transpose-lines))
;; mode specific
(defun my-eval-region-or-buffer ()
  (interactive)
  (if (region-active-p)
      (progn
        (eval-region (region-beginning) (region-end))
        (message "Evaluated current buffer"))
    (progn
      (eval-buffer)
      (message "Evaluated current buffer"))))

(dolist (m (list lisp-mode-map emacs-lisp-mode-map lisp-interaction-mode-map))
  (bind-keys :map m
           ("C-c C-c" . my-eval-region-or-buffer)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; x11
(when (or (daemonp) (display-graphic-p))
  ;; custom functions

;;; copy and paste
  (defun yank-primary ()
    "Yank primary selection."
    (interactive)
    (insert (gui-get-primary-selection)))

  (defun cf/resize-frame (&optional width height)
    (set-frame-width (selected-frame) width)
    (set-frame-height (selected-frame) height))

  (bind-keys
   ("C-M-v"           . yank-primary)
   ("<insert>"        . yank-primary)
   ("s-5"             . query-replace-regexp)
   ;; windows
   ("s-2"             . split-window-below)
   ("s-3"             . split-window-right)
   ("s-4"             . make-frame-command)
   ("C-x 4"           . make-frame-command)
   ("C-x M-o"         . other-frame)
   ;; buffers
   ("s-r"             . revert-buffer)
   ;; text scale
   ("C-0"             . text-scale-reset)
   ("C--"             . text-scale-decrease)
   ("C-="             . text-scale-increase)
   ;; custom functions
   ("C-c o"           . other-frame)
   ;; window transposing
   ("s-o"             . transpose-windows)
   ;; window resizing
   ;;("C-1"     . (lambda () (interactive) (cf/resize-frame 80  25)))
   ;;("C-2"     . (lambda () (interactive) (cf/resize-frame 80  w/height)))
   ;;("C-3"     . (lambda () (interactive) (cf/resize-frame 100 w/height)))
   ;;("C-4"     . (lambda () (interactive) (cf/resize-frame 120 w/height)))
   ;;("C-6"     . (lambda () (interactive) (cf/resize-frame 180 w/height))))
  ))

(defun set-tmux-keys ()
  (interactive)
  (unless (display-graphic-p)
    (let ((map (copy-keymap xterm-function-map)))
      (set-keymap-parent map (keymap-parent input-decode-map))
      (set-keymap-parent input-decode-map map))))
(when (getenv "TMUX")
  (set-tmux-keys))
