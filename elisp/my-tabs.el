(tab-bar-mode t)
t(setq tab-bar-tab-hints t
       tab-bar-close-button-show nil
       tab-bar-new-button-show nil
      )
(custom-set-faces
 '(tab-bar-tab          ((t (:foreground "#e5e5e5" :background "#666666"))))
 '(tab-bar              ((t (:inherit header-line))))
 '(tab-bar-tab-inactive ((t (:inherit header-line))))

 )
(bind-key "M-<left>"  'tab-bar-switch-to-prev-tab)
(bind-key "M-<right>" 'tab-bar-switch-to-next-tab)
