;;; Custom keybinds
;; disabled keybinds
(global-unset-key (kbd "<f2>"))
(global-unset-key (kbd "<insert>"))
(global-unset-key (kbd "<insertchar>"))
(global-unset-key (kbd "C-C"))
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

(defun my-match-paren (&optional arg)
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
;; custom keys
(bind-keys
 ("C-c h"       . help)
 ;; editing
 ("C-h"         . backward-delete-char-untabify)
 ("C-z"         . undo)
 ("M-u"         . universal-argument)
 ("C-c 5"       . query-replace)
 ("M-k"         . kill-whole-line)
 ("C-w"         . backward-kill-word)
 ("M-W"         . backward-kill-sexp)
 ("M-U"         . upcase-word)
 ("M-L"         . downcase-word)
 ;; custom function binds
 ("C-x C-0"     . delete-and-balance-window)
 ("C-5"         . my-match-paren)
 ("C-x C-k"     . kill-buffer-and-window)
 ("C-u"         . backward-kill-line)
 ("C-x z"       . custom-suspend-frame)
 ("C-x C-z"     . repeat)
 ;; movement
 ("M-g"         . goto-line)
 ("M-p"         . backward-paragraph)
 ("M-n"         . forward-paragraph)
 ;; mark
 ("C-x C-h"     . mark-whole-buffer)
 ("C-x SPC"     . rectangle-mark-mode)
 ("C-x C-SPC"   . cua-rectangle-mark-mode)
 ("C-x C-m"     . pop-global-mark)
 ("C-x m"       . exchange-point-and-mark)
 ;; misc
 ("<f9>"        . font-lock-mode)
 ("C-<f9>"      . global-font-lock-mode)
 ("C-<f10>"     . menu-bar-mode)
 ("<f11>"       . whitespace-mode)
 ("C-<f11>"     . font-lock-mode)
 ("<f12>"       . display-line-numbers-mode)
 ;; buffer
 ("<M-left>"    . previous-buffer)
 ("<M-right>"   . next-buffer)
 ("C-x k"       . kill-current-buffer)
 ("C-c r"       . revert-buffer)
 ("C-x b"       . ibuffer)
 ;; windows
 ("M-o"         . other-window))

;; mode specific
(bind-keys :map emacs-lisp-mode-map
           ("C-c C-c" . eval-buffer))

(unless (and (daemonp) (display-graphic-p))
  (bind-keys
   ("M-O a" . backward-paragraph)
   ("M-O b" . forward-paragraph)
   ("M-O d" . backward-word)
   ("M-O c" . forward-word)))
