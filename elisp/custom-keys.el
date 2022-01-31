;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; custom keybinds

;; disabled keybinds
;;(global-unset-key (kbd "<f1>"))
;;(global-unset-key (kbd "<f2>"))
(global-unset-key (kbd "<f11>"))
(global-unset-key (kbd "<insert>"))
(global-unset-key (kbd "<insertchar>"))
(global-unset-key (kbd "C-z"))
(dolist (key '("C-9" "C-8" "C-7" "C-6" "C-5" "C-4" "C-3" "C-2" "C-1" "C-0"
               "C-M-9" "C-M-8" "C-M-7" "C-M-6" "C-M-5" "C-M-4" "C-M-3" "C-M-2"
               "C-M-1" "C-M-0" "M-9" "M-8" "M-7" "M-6" "M-5" "M-4" "M-3" "M-2" "M-1" "M-0"))
  (global-unset-key (kbd key))) ;; unbind digit arguments
(global-unset-key (kbd "M-k"))
(global-unset-key (kbd "<C-mouse-1>"))
(global-unset-key (kbd "<C-mouse-3>"))
(global-unset-key (kbd "<C-mouse-5>"))
(global-unset-key (kbd "<C-mouse-4>"))
(global-unset-key (kbd "C-z"))
(global-unset-key (kbd "C-x C-z"))
(global-unset-key (kbd "C-x m"))
(global-unset-key (kbd "C--"))
(global-unset-key (kbd "C-x DEL111111111"))

;; custom region
(defconst custom-region-alist
  `((mark-active
     ,@(let ((m (make-sparse-keymap)))
         (define-key m (kbd "C-w")        'kill-region)
         (define-key m (kbd "C-k")        'kill-region)
         (define-key m (kbd "C-;")        'comment-region)
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
 ("C-c SPC"   . cua-rectangle-mark-mode)
 ("C-x m"     . pop-to-mark-command)
 ("C-x C-m"   . pop-to-mark-command)
 ("M-o"       . other-window)
 ("C-h"       . backward-delete-char-untabify))

;; custom keys
(bind-keys
 ("C-a"       . beginning-or-prev-line)
 ("C-e"       . end-or-next-line)
 ("M-g"       . my-goto-line)
 ("C-c h"     . help)
 ;; editing
 ("C-c 5"     . query-replace-regexp)
 ("C-M-5"     . query-replace-regexp)
 ("M-K"       . kill-whole-line)
 ("C-w"       . backward-kill-word)
 ("M-W"       . backward-kill-sexp)
 ("M-u"       . upcase-dwim)
 ("M-l"       . downcase-dwim)
 ("M-SPC"     . cycle-spacing)
 ("C-c C-SPC" . delete-horizontal-space)
 ;; custom function binds
 ("C-5"       . match-paren)
 ("C-u"       . backward-kill-line)
 ("C-x z"     . custom-suspend-frame)
 ;; movement
 ("M-p"       . backward-paragraph)
 ("M-n"       . forward-paragraph)
 ("<M-up>"    . backward-paragraph)
 ("<M-down>"  . forward-paragraph)
 ;; mark
 ("C-x C-h"   . mark-whole-buffer)
 ;; misc
 ("<f9>"      . font-lock-mode)
 ("<f10>"     . menu-bar-mode)
 ("<f11>"     . whitespace-mode)
 ("<f12>"     . display-fill-column-indicator-mode)
 ;; buffer
 ("<M-prior>" . previous-buffer)
 ("<M-next>"  . next-buffer)
 ("C-x k"     . kill-current-buffer)
 ("C-x C-k"   . kill-buffer)
 ("C-c r"     . revert-buffer)
 ("C-x C-b"   . buffer-menu)
 ;; windows
 ("M-1"       . delete-other-windows)
 ("M-2"       . split-window-below)
 ("M-3"       . split-window-right)
 ("M-4"       . make-frame-command)
 ("C-x 4"     . make-frame-command)
 ("C-0"       . balance-windows)
 ("C--"       . shrink-window)
 ("C-="       . enlarge-window)
 ("C-x C--"   . negative-argument)
 ("C-c o"     . transpose-windows)
 ("C-x t"     . transpose-lines))

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

(dolist (mode '(lisp-mode-map emacs-lisp-mode-map lisp-interaction-mode-map))
  (bind-keys :map mode
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
   ;; window transposing
   ("s-o"             . transpose-windows)
   ;; buffers
   ("s-b"   . buffer-menu)
   ("s--"   . text-scale-decrease)
   ("s-="   . text-scale-increase)
   ("s-0"   . text-scale-reset)
  ))

;; == mode maps

(bind-keys
 :map isearch-mode-map
 ("C-o" . (lambda ()
            (interactive)
            (let ((case-fold-search isearch-case-fold-search))
              (occur (if isearch-regexp isearch-string (regexp-quote isearch-string)))))))
