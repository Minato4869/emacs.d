(use-package ibuffer
  :ensure nil
  :config
  (setq ibuffer-formats
        '((mark modified read-only ;; " "(name 25 25 :left :elide)
                " " (name 30 30 :left :elide)
                " " (size 10 -1 :right)
                " " (mode 15 20 :left :elide)
                " " filename-and-process)
          (mark " " (name 16 -1) " " filename)))
  :bind
  (:map ibuffer-mode-map
        ("s" . isearch-forward)
        ("/" . isearch-forward)
        ("r" . revert-buffer)))
