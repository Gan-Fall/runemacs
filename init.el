(setq inhibit-startup-message t)

(scroll-bar-mode -1)        ; Disable visible scrollbar
(tool-bar-mode -1)          ; Disable the toolbar
(tooltip-mode -1)           ; Disable tooltips
(set-fringe-mode 10)        ; Give some breathing room

(menu-bar-mode -1)            ; Disable the menu bar

(defvar runemacs/default-font-size 160)
(set-face-attribute 'default nil :font "FiraCode Nerd Font Mono" :height runemacs/default-font-size)

;; Set the fixed pitch face
(set-face-attribute 'fixed-pitch nil :font "FiraCode Nerd Font Mono" :height runemacs/default-font-size)

;; Set the variable pitch face
(set-face-attribute 'variable-pitch nil :font "Iosevka Aile" :height 195 :weight 'regular)
