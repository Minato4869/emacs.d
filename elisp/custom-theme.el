(defvar custom-themes-index)
(setq custom-themes '(gl-dark naysayer xcode-dark default-dark
                              custom-tango-dark monochrome acme))
(setq custom-themes-index 0)
(if (or (display-graphic-p) (daemonp))
    (setq ls-directory         "#4286F4"
          ls-executable        "#cc0000"
          ls-symlink           "#75507B"
          trailing-ws          "#FFB6B0"
          man-red              "#EF2929"
          man-green            "#8AE234"
          ws-darkgray          "#444444")
  (setq ls-directory           "brightblue"
        ls-executable          "red"
        ls-symlink             "magenta"
        trailing-ws            "maroon"
        man-red                "brightred"
        man-green              "brightgreen"
        ws-darkgray            "color-238"))

(defun disable-all-themes ()
  "Disable all themes."
  (interactive)
  (dolist (i custom-enabled-themes)
    (disable-theme i)))

(defun custom-cycle-theme ()
  (interactive)
;;  (disable-theme (nth custom-themes-index custom-themes))
  (disable-all-themes)
  (setq custom-themes-index (% (1+ custom-themes-index) (length custom-themes)))
  (custom-try-load-theme (nth custom-themes-index custom-themes)))

(defun custom-default-theme ()
  (interactive)
  (disable-all-themes)
  (custom-try-load-theme (nth 0 custom-themes))
  (setq custom-theme-index 0)
  (progn (message "Default theme")))

(defun custom-disable-theme ()
  (interactive)
  ;;(disable-theme (nth custom-themes-index custom-themes))
  (disable-all-themes)
  (setq custom-themes-index (- (length custom-themes) 1))
  (progn (message "Disabled custom theme")))


(defun custom-try-load-theme (theme)
  (unless (ignore-errors (load-theme theme :no-confirm))
      (progn (message "Currently enabled theme: '%s'" theme)
        (mapc #'disable-theme (remove theme custom-enabled-themes)))
    (message "Unable to find theme file for '%s'" theme)))

(defun presentation-mode ()
  (interactive)
  (disable-all-themes)
  (load-theme 'default-light t)
  (presentation-font)
  (setq custom-theme-index 1)
  (when (daemonp)
    (setq custom-theme-index 0))
  (message "Enabled presentation mode"))

(defun reset-themes ()
  (interactive)
  (disable-all-themes)
  (custom-try-load-theme (nth custom-themes-index custom-themes))
  (if (< (display-pixel-width) 1600)
       (medium-font)
     (large-font))
  (message "Enabled default mode"))

(bind-keys
 ("<f2>"   . custom-cycle-theme)
 ("C-<f2>" . custom-default-theme)
 ("S-<f2>" .custom-disable-theme))

(when (> (length custom-enabled-themes) 1)
      (disable-all-themes))

(cond
 ((and (display-graphic-p) (not (daemonp)))
  (progn
    (load-theme 'naysayer t)
    (setq custom-themes-index 1)))
 (t (load-theme 'gl-dark t)))

(custom-set-faces
 `(Man-overstrike               ((t (:foreground ,man-red :bold t))))
 `(Man-underline                ((t (:foreground ,man-green :underline nil :bold t))))
 `(diff-added                   ((t (:foreground "green"))))
 `(diff-header                  ((t (nil))))
 `(diff-removed                 ((t (:foreground "red"))))
 `(dired-directory              ((t (:foreground ,ls-directory ))))
 `(dired-symlink                ((t (:foreground ,ls-symlink))))
 `(eshell-ls-archive            ((t (:inherit foreground))))
 `(eshell-ls-backup             ((t (:inherit foreground))))
 `(eshell-ls-clutter            ((t (:inherit foreground))))
 `(eshell-ls-directory          ((t (:foreground ,ls-directory))))
 `(eshell-ls-executable         ((t (:foreground ,ls-executable))))
 `(eshell-ls-symlink            ((t (:foreground ,ls-symlink))))
 `(font-latex-sectioning-0-face ((t (:inherit font-lock-variable-name-face))))
 `(font-latex-sectioning-1-face ((t (:inherit font-latex-sectioning-0-face))))
 `(font-latex-sectioning-2-face ((t (:inherit font-latex-sectioning-1-face))))
 `(font-latex-sectioning-3-face ((t (:inherit font-latex-sectioning-2-face))))
 `(font-latex-sectioning-4-face ((t (:inherit font-latex-sectioning-3-face))))
 `(font-latex-sectioning-5-face ((t (:inherit font-latex-sectioning-4-face))))
 `(hl-line                      ((t (:extend t))))
 `(ido-first-match              ((t (:inherit foreground :bold t :underline t))))
 `(ido-incomplete-regexp        ((t (:inherit foreground))))
 `(ido-indicator                ((t (:inherit foreground))))
 `(line-number                  ((t (:inherit foreground :bold t))))
 `(minibuffer-prompt            ((t (:inherit foreground :bold t))))
 `(mouse                        ((t (:foreground "white" :background "black"))))
 `(region                       ((t (:extend t))))
 `(trailing-whitespace          ((t (:background ,trailing-ws))))
 `(variable-pitch               ((t (:font "Sans-Serif-14"))))
 `(whitespace-space             ((t (:foreground ,ws-darkgray :inherit background))))
 `(whitespace-tab               ((t (:foreground ,ws-darkgray :inherit background))))
 `(whitespace-empty             ((t (:foreground "firebrick" :inherit  background))))
 `(whitespace-trailing          ((t (:foreground ,trailing-ws :inherit background))))
 `(whitespace-line              ((t (:inherit foreground)))))
;; `(show-paren-match            ((t (:inherit :foreground  :background ,sp-match-bg)))))
