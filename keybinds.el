(defun ale/replace-word ()
  (interactive)
  (let ((replace-string (concat "%s/"
		   (thing-at-point 'word 'no-properties)
		   "//gI")))
    (minibuffer-with-setup-hook
	(lambda ()
	  (backward-char 3))
      (evil-ex replace-string))) )

(use-package general
  :config
  (general-create-definer ale/leader-keys
    :keymaps '(normal insert visual emacs)
    :prefix "SPC"
    :global-prefix "C-SPC"))

;; Keybinds after prefix (space)
(ale/leader-keys
  ;; Search
  "s" '(ale/replace-word :which-key "Find and replace all instances of word under cursor")

  ;; Find File/Recentf
  ";" '(find-file :which-key "find-file")
  "C-;" '(projectile--find-file :which-key "projectile-find-file")
  "," '(consult-recent-file :which-key "recent-file")
  "C-," '(consult-projectile-recentf :which-key "projectile-recent-file")

  ;; Embark
  "C-." '(embark-dwim :which-key "embark at point")
  "." '(embark-act :which-key "embark")

  ;; Buffer
  "b" '(:ignore t :which-key "Buffer")
  "b i" '(ibuffer :which-key "buffer edit")
  "b s" '(consult-buffer :which-key "buffer switch")
  "b k" '(kill-buffer :which-key "buffer kill")

  ;; Projectile
  "p" '(projectile-command-map :which-key "Projectile")
  ;; Some quick rebinds
  "p v" '(dired-jump :which-key "Dired")
  "p I" '(projectile-invalidate-cache :which-key "projectile-invalidate-cache")
  "p i" '(consult-projectile-switch-to-buffer :which-key "consult-projectile-switch-to-buffer")

  ;; Magit
  "g" '(magit-status :which-key "Magit")

  ;; Undo-Tree
  "u" '(undo-tree-visualize :which-key "Undo-Tree")

  ;; Rename
  "l" '(lsp-command-map :which-key "LSP-Mode")

  ;; Windows
  "w" '(evil-window-map :which-key "Windows"))
