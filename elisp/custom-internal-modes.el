;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; ido
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

(use-package ido
  :ensure nil
  :defer t )
(bind-keys*
 ("s-d"     . cido/lazy-ido-dired)
 ("C-x C-f" . cido/lazy-ido-find-file)
 ("C-x d"   . cido/lazy-ido-dired)
 ("C-x b"   . cido/lazy-ido-switch-buffer)
 ("C-c b"   . cido/lazy-ido-switch-buffer-other-window))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; ibuffer
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
  (("C-x C-b"   . ibuffer)
   ("s-b"       . ibuffer))
  (:map ibuffer-mode-map
        ("r"   . ibuffer-redisplay)))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; dired
(use-package dired-x
  :ensure nil
  :config
  (progn
    (defun cdired/x-mode-setup ()
      (font-lock-mode t)
      (setq dired-omit-verbose nil)
      (setq-default dired-omit-mode t) ;; Turn on Omit mode.
      (dired-hide-details-mode 1))
    (setq-default dired-omit-files "^\\...+$")
    (add-hook 'dired-mode-hook 'cdired/x-mode-setup)
    (defun cdired/sort ()
      "Sort dired listings with directories first."
      (save-excursion
        (let (buffer-read-only)
          (forward-line 2) ;; beyond dir. header
          (sort-regexp-fields t "^.*$" "[ ]*." (point) (point-max)))
        (set-buffer-modified-p nil)))

    (defadvice dired-readin
        (after dired-after-updating-hook first () activate)
      "Sort dired listings with directories first before adding marks."
      (cdired/sort))
    ))

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

(defun dired-jump-previous-dir ()
  (interactive)
  (setq old-buffer (buffer-name))
  (dired-jump)
  (kill-buffer old-buffer))
;;  (message (concat "Killed Dired buffer: " old-buffer)))

(use-package dired
  :ensure nil
  :bind
  (:map dired-mode-map
        ("C-h"        . dired-omit-mode)
        ("C-<return>" . dired-find-file-other-window)
        ("<right>"    . dired-find-or-view)
        ("<left>"     . dired-jump-previous-dir)
        ("C-d"        . dired-hide-details-mode)
        ("R"          . dired-do-rename)
        ("r"          . revert-buffer)
        ("/"          . dired-isearch-filenames)
        (":"          . execute-extended-command)))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; tex
(use-package tex
  :ensure nil
  :defer t
  :config
  (setq tex-fontify-script nil ;; disables custom fonts in LaTeX buffer display
        font-latex-fontify-sectioning 'color
        font-latex-fontify-script nil
        LaTeX-item-indent -2
        LaTeX-indent-level 4) ;; indents special environments

  (setq-default
   TeX-command-list
   (quote
    (("TeX" "%(PDF)%(tex) %(file-line-error) %`%(extraopts) %S%(PDFout)%(mode)%' %t" TeX-run-TeX nil
      (plain-tex-mode ams-tex-mode texinfo-mode)
      :help "Run plain TeX")
     ("LaTeX" "%`%l%(mode)%' %T" TeX-run-TeX nil
      (latex-mode doctex-mode)
      :help "Run LaTeX")
     ("Biber" "biber %s" TeX-run-Biber nil t :help "Run Biber")
     ("View" "%V" TeX-run-discard-or-function t t :help "Run Viewer")

     ("Spell" "(TeX-ispell-document \"\")"
      TeX-run-function nil t :help "Spell-check the
                document")
     ("Clean" "TeX-clean" TeX-run-function nil t :help "Delete generated intermediate files")
     ("Clean All" "(TeX-clean t)" TeX-run-function nil t :help "Delete generated intermediate and output files")
     ("Other" "" TeX-run-command t t :help "Run an arbitrary command")))
   TeX-view-program-selection
   (quote
    (((output-dvi has-no-display-manager) "dvi2tty")
     ((output-dvi style-pstricks) "dvips and gv")
     (output-dvi "xdvi")
     (output-pdf "xpdf")
     (output-html "xdg-open")))))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; tab bar
(when (daemonp)
  (tab-bar-mode t))
(use-package tab-bar
  :ensure nil
  :config
  (setq tab-bar-close-button-show nil
        tab-bar-new-button-show nil
        tab-bar-tab-hints t
        tabbar-use-images nil)
  (defun tab-bar-close-current-tab ()
    (interactive)
    (when (y-or-n-p "Close current tab? ")
      (tab-bar-close-tab)))
  :bind
  (("M-s <left>"      . tab-bar-switch-to-prev-tab)
   ("M-s <right>"     . tab-bar-switch-to-next-tab)
   ("M-<left>"        . tab-bar-switch-to-prev-tab)
   ("M-<right>"       . tab-bar-switch-to-next-tab)
   ("C-M-<left>"      . tab-bar-switch-to-prev-tab)
   ("C-M-<right>"     . tab-bar-switch-to-next-tab)
   ("M-s M-s"         . tab-bar-switch-to-recent-tab)
   ("M-s s"           . tab-bar-switch-to-tab)
   ("M-s p"           . tab-bar-switch-to-prev-tab)
   ("M-s n"           . tab-bar-switch-to-next-tab)
   ("M-s x"           . tab-bar-close-current-tab)
   ("M-s k"           . tab-bar-close-current-tab)
   ("M-s 0"           . tab-bar-close-tab)
   ("M-s f"           . find-file-other-tab)
   ("M-s 4"           . tab-bar-new-tab)
   ("M-s c"           . tab-bar-new-tab)))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; org
(use-package org
  :defer t
  :ensure nil
  :config
  (progn
    (cedit/indent-conf 2 nil nil)
    (setq-default org-display-custom-times t)
    (setq org-highlight-latex-and-related '(latex script entities)
          indent-rigidly t
          org-src-fontify-natively t
          org-src-tab-acts-natively t
          org-confirm-babel-evaluate nil
          org-edit-preserve-indentation nil
          org-adapt-indentation nil
          org-edit-src-content-indentation 0
          org-todo-keywords
          '((sequence "TODO"     "|" "DONE")
            (sequence "VIABLE" "|" "INVIABLE")
            (sequence "VALID" "|" "INVALID")
            (sequence "BUG" "|" "FIXED" "WONT FIX"))
          org-todo-keyword-faces
          '(("INVIABLE" . "pink")
            ("VIABLE"   . "palegreen")
            ("INVALID"  . "pink")
            ("VALID"    . "palegreen")
            ("BUG"      . "pink")
            ("WONT FIX" . "red")
            ("FIXED"    . "palegreen"))
          org-time-stamp-custom-formats
          '("<%a %e %b (%Y-%m-%d)>" . "<%a %b %e %H:%M  %Y (%Y-%m-%d)>"))
          )
    ))
