(use-package rainbow-delimiters
  :hook (emacs-lisp-mode scheme-mode lisp-mode))

; Alternate way to achieve this
;(dolist (mode '(emacs-lisp-mode-hook
;		scheme-mode-hook
;		lisp-mode-hook))
;  (add-hook mode #'rainbow-delimiters-mode))
;(add-hook 'prog-mode-hook #'rainbow-delimiters-mode)
