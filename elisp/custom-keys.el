;;; Custom keybinds

;; disabled keybinds
(global-unset-key (kbd "<f2>"))
(global-unset-key (kbd "<insert>"))
(global-unset-key (kbd "<insertchar>"))
;;(global-unset-key (kbd "C-x z")
(global-unset-key (kbd "C-C"))

(bind-key* "C-z"   'undo)
(bind-key  "C-h"   'backward-delete-char-untabify)

(bind-key "C-c h" 'help)
(bind-key* "M-g"   'goto-line)

(bind-key* "M-p"   'backward-paragraph)
(bind-key* "M-n"   'forward-paragraph)

(bind-key* "C-x b" 'ibuffer)

(bind-key* "C-x C-h"   'mark-whole-buffer)

(bind-key* "C-x C-SPC" 'cua-rectangle-mark-mode)
(bind-key* "C-x SPC"   'rectangle-mark-mode)
(bind-key* "C-x C-@"   'rectangle-mark-mode)

(bind-key* "C-c C-m"   'pop-global-mark)

(bind-key* "C-c m"     'exchange-point-and-mark)
(bind-key* "C-x C-m"   'exchange-point-and-mark)

(bind-key* "C-<f10>" 'menu-bar-mode)
(bind-key* "<f11>"   'whitespace-mode)
(bind-key* "C-<f11>" 'font-lock-mode)
(bind-key* "<f12>"   'display-line-numbers-mode)

(bind-key* "<C-prior>" 'previous-buffer)
(bind-key* "<C-next>" 'next-buffer)

(bind-key* "C-c k" 'kill-buffer)
(bind-key* "C-x k" 'kill-current-buffer)

(bind-key* "<F5>"    'revert-buffer)
(bind-key* "C-c r" 'revert-buffer)


(defun delete-and-balance-window ()
  (interactive)
  (delete-window)
  (balance-windows))
(bind-key* "C-x C-0" 'delete-and-balance-window)

(defun my-match-paren (&optional arg)
  "Go to the matching parenthesis character if one is adjacent to point."
  (interactive "^p")
  (cond ((looking-at "\\s(") (forward-sexp arg))
        ((looking-back "\\s)" 1) (backward-sexp arg))
        ((looking-at "\\s)") (forward-char) (backward-sexp arg))
        ((looking-back "\\s(" 1) (backward-char) (forward-sexp arg))))
(bind-key* "C-5" 'my-match-paren)
(bind-key* "C-\\" 'my-match-paren)
(bind-key* "C-]" 'my-match-paren)

(defun kill-buffer-and-window ()
  (interactive)
  (if (one-window-p)
      (kill-current-buffer)
    (progn
      (kill-current-buffer)
      (delete-and-balance-window))))
(bind-key* "C-x C-k" 'kill-buffer-and-window)

(bind-key* "M-o"   'other-window)
(bind-key* "C-c 0" 'balance-windows)

(bind-key* "C-c [" 'shrink-window-horizontally)
(bind-key* "C-c ]" 'enlarge-window-horizontally)
(bind-key* "C-c :" 'shrink-window)
(bind-key* "C-c '" 'enlarge-window)
(bind-key* "C-c C-[" 'shrink-window-horizontally)
(bind-key* "C-c C-]" 'enlarge-window-horizontally)
(bind-key* "C-c C-:" 'shrink-window)
(bind-key* "C-c C-'" 'enlarge-window)

;; editing
(bind-key* "M-u"     'universal-argument)
(bind-key* "C-c 5"   'query-replace)
(bind-key* "C-c C-5" 'query-replace-regexp)
;; deletion
(bind-key* "M-k" 'kill-whole-line)

(defconst custom-region-alist
  `((mark-active
     ,@(let ((m (make-sparse-keymap)))
         (define-key m (kbd "C-w") 'kill-region)
         (define-key m (kbd "M-L") 'downcase-region)
         (define-key m (kbd "M-U") 'upcase-region)
         (define-key m (kbd "M-:") 'eval-region)
         m))))
(add-to-list 'emulation-mode-map-alists 'custom-region-alist)
(bind-key* "C-w" 'backward-kill-word)
(bind-key* "M-W" 'backward-kill-sexp)

(defun backward-kill-line (arg)
  "Kill ARG lines backward."
  (interactive "p")
  (if (eq (point) (line-beginning-position))
      (delete-indentation)
    (kill-line (- 1 arg))))
(bind-key* "C-u" 'backward-kill-line)
;; case
(bind-key* "M-U" 'upcase-word)
(bind-key* "M-L" 'downcase-word)

;; mode specific
(add-hook 'emacs-lisp-mode-hook
          (lambda()
            (local-set-key (kbd "C-c C-c") 'eval-buffer)))

;; copy and paste
(defun yank-primary ()
  (interactive)
  (insert
   (gui-get-primary-selection)))
(bind-key* "C-M-v" 'yank-primary)

(defun copy-primary ()
  (interactive)
  (deactivate-mark)
  (gui-set-selection
   'PRIMARY
   (buffer-substring (region-beginning) (region-end))))
(bind-key* "C-M-c" 'copy-primary)

(defun custom-suspend-frame ()
  (interactive)
  (if (display-graphic-p)
      (message "Suspend frame is disabled for X11 frames of emacs")
    (suspend-frame)))

(bind-key "C-x z" 'custom-suspend-frame)
(bind-key "C-x C-z" 'repeat)
(unless (and (daemonp) (display-graphic-p))
  (bind-key  "M-O a"   'backward-paragraph)
  (bind-key  "M-O b"   'forward-paragraph)
  (bind-key  "M-O d"   'backward-word)
  (bind-key  "M-O c"   'forward-word))
