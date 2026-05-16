(use-package evil
  :init
  (setq evil-want-C-u-scroll t)
  ; (setq evil-want-C-i-jump nil) ; Remove vim C-i in edit mode functionality
  ; (setq evil-want-C-u-delete t) ; Whether C-u should delete back to indent in insert mode.

  ;; For Evil-Collection
  (setq evil-want-integration t) ;; This is optional since it's already set to t by default.
  (setq evil-want-keybinding nil)


  :config
  (evil-set-undo-system 'undo-tree)
  (evil-mode 1)

  ;; Make screen re-center after scroll-up, scroll-down, or search
  (defun my/evil-scroll-down ()
    (interactive)
    (evil-scroll-down nil)
    (evil-scroll-line-to-center nil))
  (defun my/evil-scroll-up ()
    (interactive)
    (evil-scroll-up nil)
    (evil-scroll-line-to-center nil))
  (defun my/evil-search-next ()
    (interactive)
    (evil-search-next)
    (evil-scroll-line-to-center nil))
  (defun my/evil-search-previous ()
    (interactive)
    (evil-search-previous)
    (evil-scroll-line-to-center nil))
  ;; Swap highlighted text and text below it
  (defun my/evil-move-line-down ()
    (interactive)
    (evil-ex-execute "'<,'>m '>+1")
    (evil-indent-line (point-at-bol) (point-at-eol))
    (evil-visual-line))
  ;; Swap highlighted text and text above it
  (defun my/evil-move-line-up ()
    (interactive)
    (evil-ex-execute "'<,'>m '<-2")
    (evil-indent-line (point-at-bol) (point-at-eol))
    (evil-visual-line))
  ;; Append line below to current one
  (defun my/evil-append-next-line ()
    (interactive)
    ;;122 is ASCII for 'z'
    (evil-set-marker 122)
    (evil-join (point-at-bol) (point-at-eol 1))
    (evil-goto-mark 122))

  (evil-define-key '(normal visual) 'global (kbd "C-d") 'my/evil-scroll-down)
  (evil-define-key '(normal visual) 'global (kbd "C-u") 'my/evil-scroll-up)
  (evil-define-key '(normal visual) 'global (kbd "n") 'my/evil-search-next)
  (evil-define-key '(normal visual) 'global (kbd "N") 'my/evil-search-previous)
  (evil-define-key 'visual 'global (kbd "K") 'my/evil-move-line-up)
  (evil-define-key 'visual 'global (kbd "J") 'my/evil-move-line-down)
  (evil-define-key 'normal 'global (kbd "J") 'my/evil-append-next-line)

  ;; Set return in normal state to do default action on object
  ;(evil-define-key 'normal 'global (kbd "RET") 'embark-dwim)

  ;Alternate method
  ;(define-key evil-normal-state-map (kbd "C-d") #'my/evil-scroll-down)
  ;(define-key evil-normal-state-map (kbd "C-u") #'my/evil-scroll-up)

  ;; Disabled for now as I like jumping with relative numbers between folds.
  ; J and K will go to the next "wrapped" line (i.e. the same line but wrapped because it is too long)
  ;(evil-global-set-key 'motion "j" 'evil-next-visual-line)
  ;(evil-global-set-key 'motion "k" 'evil-previous-visual-line)

  ; Make Control-g work like Control-c
  (define-key evil-insert-state-map (kbd "C-g") 'evil-normal-state)
  (evil-set-initial-state 'messages-buffer-mode 'normal)
  (evil-set-initial-state 'dashboard-mode 'normal))

;; Remember on certain buffers you might want to start on emacs mode instead of evil mode. If you find any add them here.



(use-package evil-collection
  :after evil
  :ensure t
  :config
  (evil-collection-init))

(use-package evil-surround
  :after evil
  :ensure t
  :config
  (dolist (mode '(html-mode-hook))
    (add-hook mode #'turn-on-surround-mode))
  )
