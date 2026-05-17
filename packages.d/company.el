(use-package company
  :after lsp-mode
  :hook (lsp-mode . company-mode))


(use-package company-box
  :hook (company-mode . company-box-mode))
