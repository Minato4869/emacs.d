(use-package swiper
  :ensure nil
  :bind
  (("C-c s" . swiper))
  :config
  (progn
    (ivy-mode 0)
    (setq ivy-use-virtual-buffers t)
    (setq enable-recursive-minibuffers t)
   ))
