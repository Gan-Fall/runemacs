(use-package projectile
  :init
  (setq projectile-switch-project-action #'projectile-dired)
  (setq projectile-project-search-path
	;; Sanity check on directories/pairs
	(let (value) ; Projectile dir list should start empty
	                   ;directory list parameter
	  (dolist (element '("~/tmp/" ("~/git/" . 1)) value)
	    (if (consp element)

		;; If element in directory list is a cell
		(when (file-directory-p (car element))
		  (setq value (cons element value)))

		;; If element in directory list is not a cell
	        (when (file-directory-p element)
		  (setq value (cons element value))) ) )))
  :config
  (projectile-mode +1)
  (define-key projectile-mode-map (kbd "C-c p") 'projectile-command-map))

(use-package consult-projectile)
