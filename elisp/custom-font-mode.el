(set-face-attribute 'variable-pitch nil :font "Sans-Serif-14")
(setq  cfont/size   "6.5"
       ;;       cfont/ttf    "Meslo LG S:antialias=true:regular:pixelsize="
       cfont/ttf    "Meslo LG S:antialias=true:regular:size="
       cfont/6x13   "-misc-fixed-medium-r-semicondensed--13-120-75-75-c-60-iso10646-1"
       cfont/9x16   "-uw-ttyp0-medium-r-normal--16-150-75-75-c-80-iso10646-1"
       cfont/default cfont/9x16
       cfont/small   cfont/6x13)

(unless (file-directory-p "~/.fonts/Meslo-Font")
  (setq cfont/ttf    "DejaVu Sans Mono:regular:pixelsize="))

(if (< (display-pixel-height) 1080)
    (setq cfont/default cfont/6x13
          cfont/default       cfont/6x13
          cfont/size          "12"))

(defun cfont/set-font (&optional myfont)
    (set-face-attribute 'default t :font myfont)
    (setq default-frame-alist `((font . ,myfont)))
    (set-frame-font myfont nil t))

(defun default-font ()
  (interactive)
  (cfont/set-font cfont/default))
(defun small-font ()
  (interactive)
  (cfont/set-font cfont/small))


(defun 6x13 ()        (interactive) (cfont/set-font cfont/6x13))
(defun 9x16 ()        (interactive) (cfont/set-font cfont/9x16))
;;(defun ttf-font ()    (interactive) (cfont/set-font (concat cfont/ttf cfont/size)))
(defun ttf ()
  (interactive)
  (cond
   ((< (display-pixel-height) 1080)
    (custom-set-faces
     '(default ((t (:inherit default :height 79 :width normal
                             :foundry "PfEd" :family "Meslo LG S")))))))) ;; x230

(defun medium-font () (interactive) (cfont/set-font cfont/9x16))
(defun presentation-font ()
  (interactive)
  (cfont/set-font (concat cfont/ttf 25)))

(defun reset-fonts ()
  (interactive)
  (load-file "~/.emacs.d/elisp/custom-font-mode.el")
  (mesage "resetting fonts"))

(bind-keys
 ("<f7>"     . default-small-font)
 ("<f8>"     . default-font)
 ("M-<f8>"   . ttf-font)
 ("M-S-<f8>" . presentation-font))

(defalias 'df     'default-font)
(defalias 'dfs    'default-small-font)
;;(defalias 'ttf    'ttf-font)
(defalias 'menlo  'ttf)
(defalias 'small  'small-font)
(defalias 'medium 'medium-font)


'(default ((t (:inherit nil :extend nil :stipple nil :background "#000000" :foreground "#BEBEBE" :inverse-video nil :box nil :strike-through nil :overline nil :underline nil :slant normal :weight normal :height 79 :width normal :foundry "PfEd" :family "Meslo LG S")))) ;; x230
'(default ((t (:inherit nil :extend nil :stipple nil :background "#000000" :foreground "#BEBEBE" :inverse-video nil :box nil :strike-through nil :overline nil :underline nil :slant normal :weight normal :height 86 :width semi-condensed :foundry "Misc" :family "Fixed"))))
'(default ((t (:inherit nil :extend nil :stipple nil :background "#000000" :foreground "#BEBEBE" :inverse-video nil :box nil :strike-through nil :overline nil :underline nil :slant normal :weight normal :height 106 :width normal :foundry "UW" :family "Ttyp0"))))
