;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; custom keybinds

;; disabled keybinds
;;(global-unset-key (kbd "<f1>"))
;;(global-unset-key (kbd "<f2>"))
(global-unset-key (kbd "<insert>"))
(global-unset-key (kbd "<insertchar>"))
(global-unset-key (kbd "C-z"))
(global-unset-key (kbd "M-k"))
(global-unset-key (kbd "M-1"))
(global-unset-key (kbd "M-4"))
(global-unset-key (kbd "M-0"))
(global-unset-key (kbd "<C-up>"))
(global-unset-key (kbd "<C-down>"))
(global-unset-key (kbd "<C-mouse-1>"))
(global-unset-key (kbd "<C-mouse-3>"))
(global-unset-key (kbd "<C-mouse-5>"))
(global-unset-key (kbd "<C-mouse-4>"))
;; custom region
(defconst custom-region-alist
  `((mark-active
     ,@(let ((m (make-sparse-keymap)))
         (define-key m (kbd "C-w")        'kill-region)
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

(defalias 'tw            'transpose-windows)


(defun my-goto-line ()
  (interactive)
  (unwind-protect
      (progn
        (display-line-numbers-mode 1)
        (goto-line (read-number "Goto line: ")))
    (display-line-numbers-mode -1)))
(defalias 'gl            'my-goto-line)
(defun text-scale-reset ()
  (interactive)
  (text-scale-set 0))

(bind-keys*
 ("C-z"       . universal-argument)
 ("C-x C-SPC" . rectangle-mark-mode)
 ("C-c SPC"   . cua-rectangle-mark-mode)
 ("C-x C-@"   . rectangle-mark-mode)
 ("C-x m"     . pop-to-mark-command)
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
 ("C-M-5"     . query-replace-regexp)
 ("C-c 5"     . query-replace-regexp)
 ("M-K"       . kill-whole-line)
 ("C-w"       . backward-kill-word)
 ("M-W"       . backward-kill-sexp)
 ("M-u"       . upcase-dwim)
 ("M-U"       . upcase-dwim)
 ("M-L"       . downcase-dwim)
 ("M-SPC"     . cycle-spacing)
 ;; custom function binds
 ("C-x C-0"   . delete-and-balance-window)
 ("C-c 0"     . balance-windows)
 ("M-5"       . match-paren)
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
 ;; buffer
 ("<C-prior>" . previous-buffer)
 ("<C-next>"  . next-buffer)
 ("<M-prior>" . previous-buffer)
 ("<M-next>"  . next-buffer)
 ("C-x k"     . kill-current-buffer)
 ("C-x C-k"   . kill-buffer)
 ("C-c r"     . revert-buffer)
 ;; windows
;; ("M-1"       . delete-other-windows)
 ("M-2"       . split-window-below)
 ("M-3"       . split-window-right)
;; ("M-4"       . make-frame-command)
 ("M-0"       . delete-window)
 ("C-x 4"     . make-frame-command)
 ("C-c C-o"   . transpose-windows)
 ("C-x t"     . transpose-lines)
 ("C-c t"     . transpose-windows))

 ;; mode specific
(defun my-eval-region-or-buffer ()
  (interactive)
  (if (region-active-p)
      (progn
        (eval-region (region-beginning) (region-end))
        (message "Evaluated current region"))
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

 (defun yank-primary ()
   "Yank primary selection."
   (interactive)
   (insert (gui-get-primary-selection)))
(defun kill-ring-save-primary ()
  (interactive)
  (deactivate-mark)
  (gui-set-selection
   'PRIMARY
   (replace-regexp-in-string "[\s\n]" "" (buffer-substring
                                          (region-beginning) (region-end)))))
  (bind-keys
   ("C-M-y"           . yank-primary)
   ("C-M-w"           . kill-ring-save-primary)
   ("<insert>"        . yank-primary)
   ;; text scale
   ("C-0"             . text-scale-reset)
   ("C--"             . text-scale-decrease)
   ("C-="             . text-scale-increase)
   ;; window transposing
   ("s-o"             . transpose-windows)
  ))
