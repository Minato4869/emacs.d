;; Disable *Completions* Buffer
(add-hook 'minibuffer-exit-hook
          '(lambda ()
             (let ((buffer "*Completions*"))
               (and (get-buffer buffer)
                    (kill-buffer buffer)))))

;; reuse compilation window even if it is in anoter frame
(add-to-list 'display-buffer-alist
             '("\\*compilaition\\*"
               . (nil (reusable-frames . visible))))
