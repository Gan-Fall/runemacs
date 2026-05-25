(setq inhibit-startup-message t)
(scroll-bar-mode -1)        ; Disable visible scrollbar
(tool-bar-mode -1)          ; Disable the toolbar
(tooltip-mode -1)           ; Disable tooltips
(set-fringe-mode 10)        ; Give some breathing room
(menu-bar-mode -1)            ; Disable the menu bar

(defvar runemacs/default-font-size 160)
(set-face-attribute 'default nil :font "FiraCode Nerd Font Mono" :height runemacs/default-font-size)
(set-face-attribute 'fixed-pitch nil :font "FiraCode Nerd Font Mono" :height runemacs/default-font-size)
(set-face-attribute 'variable-pitch nil :font "Iosevka Aile" :height 195 :weight 'regular)

;; Make ESC quit prompts
(global-set-key (kbd "<escape>") 'keyboard-escape-quit)

;; Swap C-g and C-c
;(define-key key-translation-map (kbd "C-g") (kbd "C-c"))
;(define-key key-translation-map (kbd "C-c") (kbd "C-g"))

;; Configure the bell
(setq visible-bell t)
;(setq ring-bell-function 'beep)

;; Line numbers
(column-number-mode)
(setq display-line-numbers-type 'relative)
(global-display-line-numbers-mode 1)

;; Disable line numbers for some modes
(dolist (mode '(term-mode-hook
  		eshell-mode-hook
		vterm-mode-hook))
  (add-hook mode (lambda () (display-line-numbers-mode 0))))

;; Same but for fill column
(setq display-fill-column-indicator-column 80)
(add-hook 'prog-mode-hook 'display-fill-column-indicator-mode)

(which-key-mode)

;; Initialize package sources
(require 'package)

(setq package-archives '(("melpa" . "https://melpa.org/packages/")
                         ("org" . "https://orgmode.org/elpa/")
                         ("elpa" . "https://elpa.gnu.org/packages/")))

(package-initialize)
(unless package-archive-contents
 (package-refresh-contents))

;; Initialize use-package on non-Linux platforms
(unless (package-installed-p 'use-package)
   (package-install 'use-package))

(require 'use-package)
(setq use-package-always-ensure t)

;; Will create a package.d folder where all .el files inside are loaded
;; on startup
(setq ale/package-d-dir
      (concat user-emacs-directory "packages.d/"))
(ignore-errors 
  (make-directory ale/package-d-dir))
(defun ale/load (file)
  "My custom function to load a passed in file"
  (interactive "f")
  (load file) )
(defun ale/load-package-d (name)
  "My custom function to load a file from package.d directory.
  Must enter a string if called interactively."
  (interactive "s")
  (load (expand-file-name name ale/package-d-dir)) )
(defun ale/initialize-package-d ()
  "This function automatically runs ale/load-package-d on every
  .el file inside package.d folder"
  (interactive)
  (let* ((files (directory-files ale/package-d-dir))
         (el-files
	  (seq-filter (lambda (str) (string-match "\.el" str)) files)))
    (seq-map #'ale/load-package-d el-files)))

(ale/initialize-package-d)

(load (expand-file-name (concat user-emacs-directory "keybinds.el")))

;; Will add ~/.rbenv to PATH and exec-path if it exists
;; this is so lsp-mode is aware of my ruby executables
(let ((ruby-bin (expand-file-name "~/.rbenv/shims")))
  (when (file-directory-p ruby-bin)
    (progn
      (setenv "PATH" (concat ruby-bin ":" (getenv "PATH")))
      (add-to-list 'exec-path (expand-file-name "~/.rbenv/shims"))
     (setq lsp-sorbet-as-add-on t) ))) ; Also run sorbet as add on

(recentf-mode)

(setq custom-file (concat user-emacs-directory "custom.el"))
(load custom-file)
