;; == ido
(use-package ido
  :ensure nil
  :defer t
  :config
  (defun cido/lazy-ido-enable ()
    "since ido is loaded with Emacs, use-package cannot defer"
    (ido-mode t)
    (setq
     ido-enable-flex-matching t
     ido-auto-merge-work-directories-length -1
     ido-default-buffer-method 'selected-window
     ido-default-file-method 'selected-window
     ido-everywhere t)
    (if (require 'ido-sort-mtime nil t)
        (ido-sort-mtime-mode t)))
  (defun cido/lazy-ido-switch-buffer ()
    "ibuffer wrapper"
    (interactive)
    (cido/lazy-ido-enable)
    (call-interactively 'ido-switch-buffer))
  (defun cido/lazy-ido-switch-buffer-other-window ()
    "ibuffer wrapper"
    (interactive)
    (cido/lazy-ido-enable)
    (call-interactively 'ido-switch-buffer-other-window))
  (defun cido/lazy-ido-find-file ()
    "find-file wrapper"
    (interactive)
    (cido/lazy-ido-enable)
    (call-interactively 'ido-find-file))
  (defun cido/lazy-ido-dired ()
    "find-file wrapper"
    (interactive)
    (cido/lazy-ido-enable)
    (call-interactively 'ido-dired))
  :bind*
  (("C-x C-f" . cido/lazy-ido-find-file)
   ("C-x d"   . cido/lazy-ido-dired)
   ("C-x b"   . cido/lazy-ido-switch-buffer)
   ("C-c b"   . cido/lazy-ido-switch-buffer-other-window)))

;; == ibuffer
(use-package ibuffer
  :ensure nil
  :defer nil
  :config
  (setq ibuffer-formats
        '((mark modified read-only ;; " "(name 25 25 :left :elide)
                " " (name 30 30 :left :elide)
                " " (size 10 -1 :right)
                " " (mode 15 20 :left :elide)
                " " filename-and-process)
          (mark " " (name 16 -1) " " filename)))
  (defalias 'ib 'ibuffer)
  :bind
  (("C-x C-b"   . ibuffer)
   ("C-c b"     . ibuffer-other-window)
   ("s-b"       . ibuffer))
  (:map ibuffer-mode-map
        ("r"   . ibuffer-redisplay)))

;; == dired
(use-package dired-x
  :ensure nil
  :defer nil
  :config
  (setq-default dired-omit-files "^\\...+$")
  (when (or (string-equal system-type "gnu/linux")
            (file-regular-p "/usr/local/share/gls"))
    (setq dired-listing-switches
          "-laH --group-directories-first"))
  (setq dired-omit-verbose nil
        dired-omit-mode t)

  (defun cdired/x-mode-setup ()
    (font-lock-mode t)
    (dired-hide-details-mode 1))
  (add-hook 'dired-mode-hook 'cdired/x-mode-setup)
  :bind
  (:map dired-mode-map
        ("C-h"        . dired-omit-mode)
        ("C-d"        . dired-hide-details-mode))
  )

(use-package dired
  :ensure nil
  :defer nil
  :config
  (defun dired-jump-previous-dir ()
    (interactive)
    (setq old-buffer (buffer-name))
    (dired-jump)
    (kill-buffer old-buffer))
  (defun dired-view-file-other-window ()
    (if (one-window-p)
        (split-window-horizontally)
      (split-window-vertically))
    (other-window 1)
    (dired-view-file))

  (defun dired-find-or-view ()
    "A `dired-find-file' which only works on directories."
    (interactive)
    (let ((find-file-run-dired t)
          (file (dired-get-file-for-visit)))
      (if (file-directory-p file)
          (find-file file)
        (dired-view-file-other-window))))

  :bind*
  (("C-x C-d" . dired-jump))
  (:map dired-mode-map
        ("C-<return>" . dired-find-file-other-window)
        ("C-<right>"  . dired-find-file-other-window)
        ("C-h"        . dired-omit-mode)
        ("<right>"    . dired-find-or-view)
        ("<left>"     . dired-jump-previous-dir)
        ("C-d"        . dired-hide-details-mode)
        ("r"          . revert-buffer)
        ("/"          . occur)))

;; == tex
(use-package tex
  :ensure nil
  :defer t
  :config
  (setq tex-fontify-script nil ;; disables custom fonts in LaTeX buffer display
        font-latex-fontify-sectioning 'color
        font-latex-fontify-script nil
        LaTeX-item-indent -2
        LaTeX-indent-level 4) ;; indents special environments
  (setq TeX-engine 'default) ;; switch to xelatex
;;  (setq-default
;;   TeX-command-list
;;   (quote
;;    (("TeX" "%(PDF)%(tex) %(file-line-error) %`%(extraopts) %S%(PDFout)%(mode)%' %t" TeX-run-TeX nil
;;      (plain-tex-mode ams-tex-mode texinfo-mode)
;;      :help "Run plain TeX")
;;     ("LaTeX" "%`%l%(mode)%' %T" TeX-run-TeX nil
;;      (latex-mode doctex-mode)
;;      :help "Run LaTeX")
;;     ("Biber" "biber %s" TeX-run-Biber nil t :help "Run Biber")
;;     ("View" "%V" TeX-run-discard-or-function t t :help "Run Viewer")
;;
;;     ("Spell" "(TeX-ispell-document \"\")"
;;      TeX-run-function nil t :help "Spell-check the
;;                document")
;;     ("Clean" "TeX-clean" TeX-run-function nil t :help "Delete generated intermediate files")
;;     ("Clean All" "(TeX-clean t)" TeX-run-function nil t :help "Delete generated intermediate and output files")
;;     ("Other" "" TeX-run-command t t :help "Run an arbitrary command")))
  (setq TeX-view-program-selection
        (quote
    (((output-dvi has-no-display-manager) "dvi2tty")
     ((output-dvi style-pstricks) "dvips and gv")
     (output-dvi "xdvi")
     (output-pdf "xpdf")
     (output-html "xdg-open")))))
;; == org
(use-package org
  :ensure nil
  :defer nil
  :init
  (add-hook 'org-mode-hook (lambda () (electric-indent-local-mode -1)))
  :config
  (progn
    (cedit/indent-conf 2 nil nil)
    (setq org-highlight-latex-and-related '(latex script entities)
          indent-rigidly t
          org-src-fontify-natively t
          org-src-tab-acts-natively t
          org-confirm-babel-evaluate nil
          org-src-preserve-indentation t
          org-adapt-indentation nil
          org-src-content-indentation 0
          org-startup-folded t)
    (setq org-todo-keywords
          '((sequence "TODO" "|" "DONE" "INPROGRESS" "CANCELLED")
            (sequence "VIABLE" "|" "INVIABLE")
            (sequence "VALID"  "|" "INVALID")
            (sequence "BUG"    "|" "FIXED" "WONT FIX"))
          org-todo-keyword-faces
          '(("INVIABLE"   . "pink")
            ("VIABLE"     . "palegreen")
            ("INVALID"    . "pink")
            ("CANCELLED"  . "#565252") ;;"grey50")
            ("INPROGRESS" . "goldenrod1")
            ("VALID"      . "palegreen")
            ("BUG"        . "pink")
            ("WONT FIX"   . "red")
            ("FIXED"      . "palegreen")))
    (setq org-capture-templates
          '(("t" "Todo"         entry (file corg/reminder)    "* TODO %t %?\n")
            ("r" "Reminder"     entry (file corg/reminder)    "* TODO %t %?\n")
            ("p" "Plan"         entry (file corg/reminder)    "* TODO %t %?\n")
            ("n" "Notes"        entry (file corg/notes)       "* %T\n%?\n")
            ("l" "Local notes"  entry (file corg/notes-local) "* %T\n%?\n")
            ("m" "Misc notes"   entry (file corg/notes)       "* %T\n%?\n")
            ("t" "til notes"    entry (file corg/til)         "* %T\n%?\n")
            ("u" "uni notes"    entry (file corg/uni)         "* %T\n%?\n"))))
  (defalias 'ca     'org-capture)
  (defalias 'agenda 'org-agenda)

  :bind
  (:map org-mode-map
        ("C-c <right>" . org-metaright)
        ("C-c <left>"  . org-metaleft)
        ("C-c C-."     . org-time-stamp)))

;; == man
(use-package man
  :ensure nil
  :defer t
  :config
  (setenv "MANWIDTH" "70")
  :bind
  (:map Man-mode-map
        ("C-q"    . kill-buffer-and-window)))

;; == view
(use-package view
  :ensure nil
  :defer t
  :config
  (defun View-quit-and-kill ()
    (interactive)
    (View-quit)
    (delete-window))
  :bind
  (:map view-mode-map
        ("q"      . View-quit-and-kill)
        ("C-q"    . View-quit)
        ("C-f"    . scroll-line-up)
        ("C-b"    . scroll-line-down)
        ("g"      . beginning-of-buffer)
        ("G"      . end-of-buffer)))
