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
  		eshell-mode-hook))
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
