;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets. It is optional.
;; (setq user-full-name "John Doe"
;;       user-mail-address "john@doe.com")

;; Doom exposes five (optional) variables for controlling fonts in Doom:
;;
;; - `doom-font' -- the primary font to use
;; - `doom-variable-pitch-font' -- a non-monospace font (where applicable)
;; - `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;; - `doom-symbol-font' -- for symbols
;; - `doom-serif-font' -- for the `fixed-pitch-serif' face
;;
;; See 'C-h v doom-font' for documentation and more examples of what they
;; accept. For example:
;;
;;(setq doom-font (font-spec :family "Fira Code" :size 12 :weight 'semi-light)
;;      doom-variable-pitch-font (font-spec :family "Fira Sans" :size 13))
;;
;; If you or Emacs can't find your font, use 'M-x describe-font' to look them
;; up, `M-x eval-region' to execute elisp code, and 'M-x doom/reload-font' to
;; refresh your font settings. If Emacs still can't find your font, it likely
;; wasn't installed correctly. Font issues are rarely Doom issues!
(setq doom-font (font-spec :family "FiraCode Nerd Font Mono" :size 23 :weight 'semi-light)
      doom-symbol-font (font-spec :family "Symbols Nerd Font Mono")
      doom-variable-pitch-font (font-spec :family "Iosevka Aile" :size 23))

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-theme 'doom-dracula)

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type 'relative)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory (file-truename "~/Documents/org"))
(setq org-roam-directory (file-truename "~/Documents/org/roam"))


;; Whenever you reconfigure a package, make sure to wrap your config in an
;; `with-eval-after-load' block, otherwise Doom's defaults may override your
;; settings. E.g.
;;
;;   (with-eval-after-load 'PACKAGE
;;     (setq x y))
;;
;; The exceptions to this rule:
;;
;;   - Setting file/directory variables (like `org-directory')
;;   - Setting variables which explicitly tell you to set them before their
;;     package is loaded (see 'C-h v VARIABLE' to look them up).
;;   - Setting doom variables (which start with 'doom-' or '+').
;;
;; Here are some additional functions/macros that will help you configure Doom.
;;
;; - `load!' for loading external *.el files relative to this one
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c c k').
;; This will open documentation for it, including demos of how they are used.
;; Alternatively, use `C-h o' to look up a symbol (functions, variables, faces,
;; etc).
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.

;; In case I'm using a non-POSIX shell
(setq shell-file-name (executable-find "bash"))

;; Fill Column
(set-fill-column 80)
(add-hook 'prog-mode-hook 'display-fill-column-indicator-mode)
(dolist (mode '(prog-mode-hook
  		org-mode-hook))
  (add-hook mode 'display-fill-column-indicator-mode))

;;-----------------------------Keybinds---------------------------------------

; Leader key
(setq doom-leader-alt-key "C-SPC")
(setq doom-localleader-alt-key "C-SPC m")

;; Make company select with return or C-l now that M-SPC is not available
(map! :after company
      :map company-active-map
      "RET" #'company-complete-selection
      "C-l" #'company-complete-selection)

;; Doom simply gives too many quite excellent options, and I get choice
;; paralysis. I want to learn package by package so I will add keybinds
;; as needed.
;; TODO Embark
;; TODO Consult
;; TODO Projectile
;; TODO Perspective
(setq original-doom-leader-map doom-leader-map) ; Save original leader map for reference.

;; Some bind remaps I would make to default doom keymaps
;; (map! :map doom-leader-map
;;       ";" #'embark-act
;;       "C-;" #'embark-dwim
;;       ":" #'eval-expression
;;       "!" #'shell-command
;;       "," #'recentf-open-files
;;       "<" #'projectile-recentf
;;       ">" #'projectile-find-file
;;       "s" #'ale/replace-word)

;; (setq ale/kill-buffer-map
;;       (make-sparse-keymap))

;; (map! :map ale/kill-buffer-map
;;       "a" #'doom/kill-all-buffers
;;       "o" #'doom/kill-other-buffers
;;       "k" #'kill-current-buffer
;;       "s" #'kill-buffer
;;       "p" #'projectile-kill-buffers)

;; (map! :map doom-leader-buffer-map
;;       "k" ale/kill-buffer-map
;;       "B" #'+vertico/switch-workspace-buffer
;;       "b" #'switch-to-buffer)
;;       "S" #'+vertico/switch-workspace-buffer ;; Unbinds basic-save-buffer
;;       "s" #'switch-to-buffer) ;;Unbinds evil-write-all

;; (map! :map doom-leader-project-map
;;       "v" #'dired-jump
;;       "V" #'dired-jump-other-window
;;       "," #'projectile-recentf
;;       ";" #'projectile-switch-to-buffer
;;       "i" #'projectile-ibuffer ;; Unbinds projectile-invalidate-cache
;;       "s" doom-leader-search-map) ;; Unbinds projectile-save-project-buffers

(defun ale/replace-word ()
  (interactive)
  (let ((replace-string (concat "%s/"
		   (thing-at-point 'word 'no-properties)
		   "//gI")))
    (minibuffer-with-setup-hook
	(lambda ()
	  (backward-char 3))
      (evil-ex replace-string))) )

;; Create keymaps
(dolist (keymap '(ale/doom-leader-map
                  ale/kill-buffer-map
                  ale/buffer-map
                  ale/projectile-map
                  ale/magit-map))
  (set keymap (make-sparse-keymap)))

;; Bind keymaps
(map! :leader
      ";" #'embark-act
      "C-;" #'embark-dwim
      ":" #'pp-eval-expression
      "!" #'shell-command
      "," #'recentf-open-files
      "." #'find-file
      "<" #'projectile-recentf
      ">" #'projectile-find-file
      "s" #'ale/replace-word
      "x" #'ale/evil-add-executable-flag
      "h" help-map
      "w" evil-window-map
      "b" #'consult-buffer ;;TODO Figure out how to use perspective eventually
      "p" ale/projectile-map
      "g" ale/magit-map)

(map! :leader
      :after lsp-mode
      "f" #'lsp-format-buffer
      "r" #'lsp-rename)

(map! :map ale/projectile-map
      "b" #'projectile-switch-to-buffer
      "p" #'projectile-switch-project
      "v" #'dired-jump
      "V" #'dired-jump-other-window
      "s" #'+default/search-project
      "S" #'+default/search-project-for-symbol-at-point)

(map! :map ale/magit-map
      "s" #'magit-status
      "g" #'magit-status)

;; Evil
;; I set evil up to be as close to my Neovim setup as possible.
;; Besides the few commands I add below, I just want it to act as close
;; to vanilla as possible.
(evil-define-command ale/recenter-after-command-wrapper (command &rest args)
  "Wrap an evil command so that evil-scroll-line-to-center is called after.
Not sure if this works with a command that takes anything but COUNT as argument.
It also swallows first motion. WIP for now..."
  :repeat nil
  :keep-visual t
  (interactive "<c>")
  (evil-ensure-column
    (let ((result (apply command args)))
      (progn
        (evil-scroll-line-to-center nil)
        result))))

(evil-define-command ale/evil-scroll-up-recenter-visual (count)
  :repeat nil
  :keep-visual t
  (interactive "<c>")
  (ale/recenter-after-command-wrapper #'evil-scroll-up count))
(evil-define-command ale/evil-scroll-down-recenter-visual (count)
  :repeat nil
  :keep-visual t
  (interactive "<c>")
  (ale/recenter-after-command-wrapper #'evil-scroll-down count))
(evil-define-command ale/evil-ex-search-next-recenter-visual (count)
  :repeat nil
  :keep-visual t
  (interactive "<c>")
  (ale/recenter-after-command-wrapper #'evil-ex-search-next count))
(evil-define-command ale/evil-ex-search-previous-recenter-visual (count)
  :repeat nil
  :keep-visual t
  (interactive "<c>")
  (ale/recenter-after-command-wrapper #'evil-ex-search-previous count))

;; Swap highlighted text and text below it
(defun ale/evil-move-line-down ()
  (interactive)
  (evil-ex-execute "'<,'>m '>+1")
  (evil-indent-line (point-at-bol) (point-at-eol))
  (evil-visual-line))
;; Swap highlighted text and text above it
(defun ale/evil-move-line-up ()
  (interactive)
  (evil-ex-execute "'<,'>m '<-2")
  (evil-indent-line (point-at-bol) (point-at-eol))
  (evil-visual-line))
;; Append line below to current one
(defun ale/evil-append-next-line ()
  (interactive)
  ;;122 is ASCII for 'z'
  (evil-set-marker 122)
  (evil-join (point-at-bol) (point-at-eol 1))
  (evil-goto-mark 122))
(defun ale/evil-add-executable-flag ()
  (interactive)
  (shell-command (concat "chmod +x " (file!))))

(map! :after evil
      :nv "C-d" #'ale/evil-scroll-down-recenter-visual
      :nv "C-u" #'ale/evil-scroll-up-recenter-visual
      :nv "n" #'ale/evil-ex-search-next-recenter-visual
      :nv "N" #'ale/evil-ex-search-previous-recenter-visual
      :v "K" #'ale/evil-move-line-up
      :v "J" #'ale/evil-move-line-down
      :n "J" #'ale/evil-append-next-line
      :n "C-j" #'next-error
      :n "C-k" #'previous-error)

(map! :after evil-numbers
      :v "g C-a" #'evil-numbers/inc-at-pt-incremental
      :v "g C-x" #'evil-numbers/dec-at-pt-incremental
      :v "g _" #'evil-numbers/dec-at-pt)

;; Equivalent of
; (evil-define-key '(normal visual) 'global (kbd "C-d") 'ale/evil-scroll-down-recenter-visual)
; (evil-define-key '(normal visual) 'global (kbd "C-u") 'ale/evil-scroll-up-recenter-visual)
; (evil-define-key '(normal visual) 'global (kbd "n") 'ale/evil-ex-search-next-recenter-visual)
; (evil-define-key '(normal visual) 'global (kbd "N") 'ale/evil-ex-search-previous-recenter-visual)
; (evil-define-key 'visual 'global (kbd "K") 'ale/evil-move-line-up)
; (evil-define-key 'visual 'global (kbd "J") 'ale/evil-move-line-down)
; (evil-define-key 'normal 'global (kbd "J") 'ale/evil-append-next-line)
