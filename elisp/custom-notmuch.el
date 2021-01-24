(use-package notmuch
  :defer t
	:ensure nil
  :config
	(xterm-mouse-mode -1)
	(setq notmuch-search-oldest-first nil))
