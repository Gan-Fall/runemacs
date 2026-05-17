(defun efs/lsp-mode-setup ()
  (setq lsp-headerline-breadcrumb-segments '(path-up-to-project file symbols))
  (lsp-headerline-breadcrumb-mode))

(use-package lsp-mode
  :init
  ;; set prefix for lsp-command-keymap (few alternatives - "C-l", "C-c l")
  (setq lsp-keymap-prefix "C-c l")
  :hook (;; replace XXX-mode with concrete major-mode(e. g. python-mode)
         (ruby-mode . lsp-deferred)
         (ruby-ts-mode . lsp-deferred)
	 ;; Don't forget to install emmet
         (javascript-mode . lsp-deferred)
         (html-mode . lsp-deferred)
         (html-ts-mode . lsp-deferred)
         (css-mode . lsp-deferred)
         (css-ts-mode . lsp-deferred)
         ;; if you want which-key integration
         (lsp-mode . efs/lsp-mode-setup)
         (lsp-mode . lsp-enable-which-key-integration))
  :commands (lsp lsp-deferred))

(use-package lsp-ui
  :hook (lsp-mode . lsp-ui-mode)
  :custom
  (lsp-ui-doc-position 'bottom))

(use-package lsp-treemacs :commands lsp-treemacs-errors-list)
