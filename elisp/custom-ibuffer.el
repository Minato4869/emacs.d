(setq ibuffer-formats
      '((mark modified read-only " "
              ;;              (name 25 25 :left :elide)
              (name 30 30 :left :elide)
              " "
              (size 10 -1 :right)
              " "
              (mode 15 20 :left :elide)
              " " filename-and-process)
        (mark " "
              (name 16 -1)
              " " filename)))

(defun my-ibuffer-hook ()
  "custom ibuffer mode hook"
  (define-key ibuffer-mode-map (kbd "s") 'isearch-forward)
  (define-key ibuffer-mode-map (kbd "/") 'isearch-forward)
  (define-key ibuffer-mode-map (kbd "r") 'revert-buffer))

(add-hook 'ibuffer-mode-hooks 'my-ibuffer-hook)
