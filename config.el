(defconst *is-a-mac*
  (eq system-type 'darwin)
  "Is this running on OS X?")

(setq inhibit-startup-screen t )	; inhibit useless and old-school startup screen
(setq ring-bell-function 'ignore )	; silent bell when you make a mistake
(setq coding-system-for-read 'utf-8 )	; use utf-8 by default
(setq coding-system-for-write 'utf-8 )
(setq sentence-end-double-space nil)	; sentence SHOULD end with only a point.
(setq default-fill-column 80)		; toggle wrapping text at the 80th character
(setq initial-scratch-message "Whatever you're about to do, it's not worth it")

(when (and (fboundp 'tool-bar-mode) (not (eq tool-bar-mode -1)))
  (tool-bar-mode -1))
(unless *is-a-mac*
  (when (and (fboundp 'menu-bar-mode) (not (eq menu-bar-mode -1)))
    (menu-bar-mode -1)))
(when (and (fboundp 'scroll-bar-mode) (not (eq scroll-bar-mode -1)))
  (scroll-bar-mode -1))
;; tooltips in echo-aera
(when (and (fboundp 'tooltip-mode) (not (eq tooltip-mode -1)))
  (tooltip-mode -1))
  
;; add dark mode header
(add-to-list 'default-frame-alist '(ns-transparent-titlebar . t))
(add-to-list 'default-frame-alist '(ns-appearance . dark))

(setq delete-old-versions -1 )		; don't delete old backups
(setq version-control t)		; use version control
(setq vc-make-backup-files t )		; make backups file even when in version controlled dir
(setq backup-directory-alist `(("." . "~/.emacs.d/backups")) ) ; which directory to put backups file
(setq auto-save-file-name-transforms '((".*" "~/.emacs.d/auto-save-list/" t)) ) ;transform backups file name

(use-package evil :ensure t
  :config
  (evil-mode 1))

(use-package ranger :ensure t
  :commands (ranger)
  :config
  (setq ranger-cleanup-eagerly t)
  )

(use-package magit :ensure t) 

(use-package general :ensure t
  :config
  )
  
;; a package for discovering keybinding in the current leader mode
(use-package discover-my-major :ensure t)

;; Leader commands 
(general-define-key
  :states '(normal visual motion)
  :prefix "SPC"
  :keymaps 'override ;; Override so that SPC isn't overridden in help mode.

  "SPC"   'counsel-M-x
  "/"     'counsel-ag
  "TAB"   '(switch-to-buffer :which-key "other buffer")
  "a"     '(:ignore t :which-key "Application")
  "aa"    'org-agenda
  "ar"    'ranger
  "ad"    'dired
  "g"     '(:ignore t :which-key "Git")
  "gs"    'magit-status
  "b"     'ivy-switch-buffer   ; change buffer, chose using ivy
  "/"     'counsel-git-grep    ; find string in git project 
  "f"     '(:ignore t :which-key "File")
  "ff"    'counsel-find-file     ; find file using ivy
  "fr"    'counsel-recentf       ; find recently edited file
  "fs"    'save-buffer           ; save current buffer
  "p"     '(:ignore t :which-key "Project")
  "pf"    'counsel-git           ; find file in git project
  "w"     '(:ignore t :which-key "Window")
  "wj"    'evil-window-down
  "wk"    'evil-window-up
  )
  
;; General keys
(general-define-key
  :states '(normal visual)
  "C-h C-m"   'discover-my-major
  "C-u"       'evil-scroll-up
  )

(use-package ivy :ensure t
  :diminish (ivy-mode . "") ; does not display ivy in the modeline
  :init (ivy-mode 1)        ; enable ivy globally at startup
  :bind (:map ivy-mode-map  ; bind in the ivy buffer
         ("C-'" . ivy-avy)) ; C-' to ivy-avy
  :config
  (setq ivy-use-virtual-buffers t)   ; extend searching to bookmarks and …
  (setq ivy-height 20)               ; set height of the ivy window
  (setq ivy-count-format "(%d/%d) ") ; count format, from the ivy help page
  )

(use-package swiper :ensure t)  ; find text in a buffer quickly
(use-package counsel :ensure t) ; find recent files/buffers & search for funcs/apps/etc

(general-define-key
  ;; replace default keybindings
  "C-s" 'swiper           ; Search for string in current buffer
  "M-x" 'counsel-M-x      ; Replace default M-x with ivy backend
  )

(use-package which-key :ensure t  ; Add minimap for key chords
  :init
  (which-key-mode)
  (setq which-key-sort-order 'which-key-key-order-alpha
        which-key-side-window-max-width 0.33
        which-key-idle-delay 0.05)
  )

(setq custom-file "~/.emacs.d/custom.el")

(load custom-file 'no-error)
