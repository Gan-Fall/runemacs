(use-package undo-tree
  :custom
  (undo-tree-enable-undo-in-region t)
  (undo-tree-history-directory-alist '(("." . (concat user-emacs-directory "undotree"))))
  ;; Pt 1
  (undo-tree-auto-save-history nil)
  :config
  ;; Pt 2
  ;; These two parts prevent undotree from saving in buffers that aren't prog-mode
  (add-hook 'prog-mode-hook
	    (lambda ()
	      (setq-local undo-tree-auto-save-history 't))))
(global-undo-tree-mode 1)
