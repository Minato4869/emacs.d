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
;;; copy and paste
(defun yank-primary ()
  "Yank primary selection."
  (interactive)
  (insert
   (gui-get-primary-selection)))

(defun copy-primary ()
  "Copy primary selection."
  (interactive)
  (deactivate-mark)
  (gui-set-selection
   'PRIMARY
   (buffer-substring (region-beginning) (region-end))))

(defun custom-suspend-frame ()
  "Suspend frame inside of a terminal instance of Emacs."
  (interactive)
  (if (display-graphic-p)
      (message "Suspend frame is disabled for X11 frames of emacs")
    (suspend-frame)))
;; custom keys
(bind-keys
 ("C-c h"   . help)
 ;; editing
 ("C-h"     . backward-delete-char-untabify)
 ("C-z"       . undo)
 ("M-u"       . universal-argument)
 ("C-c 5"     . query-replace)
 ("C-c C-5"   . query-replace-regexp)
 ("M-k"       . kill-whole-line)
 ("C-w"       . backward-kill-word)
 ("M-W"       . backward-kill-sexp)
 ("M-U"       . upcase-word)
 ("M-L"       . downcase-word)
 ("C-x m"     . exchange-point-and-mark)
 ;; custom function binds
 ("C-x C-0" . delete-and-balance-window)
 ("C-5"     . my-match-paren)
 ("C-\\"    . my-match-paren)
 ("C-]"     . my-match-paren)
 ("C-x C-k" . kill-buffer-and-window)
 ("C-u"     . backward-kill-line)
 ("C-x z"   . custom-suspend-frame)
 ("C-M-c"   . copy-primary)
 ("C-M-v"   . yank-primary)
 ("C-x C-z" . repeat)
 ;; movement
 ("M-g"       . goto-line)
 ("M-p"       . backward-paragraph)
 ("M-n"       . forward-paragraph)
 ;; mark
 ("C-x C-h"   . mark-whole-buffer)
 ("C-x C-SPC" . cua-rectangle-mark-mode)
 ("C-x SPC"   . rectangle-mark-mode)
 ("C-x C-@"   . rectangle-mark-mode)
 ("C-c C-m"   . pop-global-mark)
 ("C-c m"     . exchange-point-and-mark)
 ("C-x C-m"   . exchange-point-and-mark)
 ;; misc
 ("C-<f10>"   . menu-bar-mode)
 ("<f11>"     . whitespace-mode)
 ("C-<f11>"   . font-lock-mode)
 ("<f12>"     . display-line-numbers-mode)
 ;; buffer
 ("<M-left>"  . previous-buffer)
 ("<M-right>" . next-buffer)
 ("<C-prior>" . previous-buffer)
 ("<C-next>"  . next-buffer)
 ("C-c k"     . kill-buffer)
 ("C-x k"     . kill-current-buffer)
 ("<F5>"      . revert-buffer)
 ("C-c r"     . revert-buffer)
 ("C-x b"     . ibuffer)
 ("C-c b"     . switch-to-buffer)
 ;; windows
 ("M-o"      . other-window)
 ("C-c 0"    . balance-windows)
 ("C-c ["    . shrink-window-horizontally)
 ("C-c ]"    . enlarge-window-horizontally)
 ("C-c :"    . shrink-window)
 ("C-c '"    . enlarge-window)
 ("C-c C-["  . shrink-window-horizontally)
 ("C-c C-]"  . enlarge-window-horizontally)
 ("C-c C-:"  . shrink-window)
 ("C-c C-'"  . enlarge-window))

;; mode specific
(bind-keys :map emacs-lisp-mode-map
           ("C-c C-c" . eval-buffer))

(unless (and (daemonp) (display-graphic-p))
  (bind-keys
   ("M-O a" . backward-paragraph)
   ("M-O b" . forward-paragraph)
   ("M-O d" . backward-word)
   ("M-O c" . forward-word)))
