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

(use-package ag)
(use-package rg)

;; Temporary (hopefully) fix due to the original functions
; not preserving changes when using C-g or stopping when inputting
; empty var name
(define-skeleton projectile-skel-dir-locals
  "Insert a .dir-locals.el template."
  nil
  "((nil . ("
  ("Value: "
   "("
   (let ((var-name (projectile-read-variable)))
     (if (string-empty-p var-name)
	 ;; Stop the sub-skeleton iteration on empty variable name.
	 (signal 'quit t)
       var-name))
   " . " str ")" \n)
  resume:
  ")))")
