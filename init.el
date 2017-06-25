(setq delete-old-versions -1 )		; delete excess backup versions silently
(setq version-control t)		; use version control
(setq vc-make-backup-files t )		; make backups file even when in version controlled dir
(setq backup-directory-alist `(("." . "~/.emacs.d/backups")) ) ; which directory to put backups file
(setq vc-follow-symlinks t )				       ; don't ask for confirmation when opening symlinked file
(setq auto-save-file-name-transforms '((".*" "~/.emacs.d/auto-save-list/" t)) ) ;transform backups file name
(setq inhibit-startup-screen t )	; inhibit useless and old-school startup screen
(setq ring-bell-function 'ignore )	; silent bell when you make a mistake
(setq coding-system-for-read 'utf-8 )	; use utf-8 by default
(setq coding-system-for-write 'utf-8 )
(setq sentence-end-double-space nil)	; sentence SHOULD end with only a point.
(setq default-fill-column 80)		; toggle wrapping text at the 80th character
(setq initial-scratch-message "Hey you :3") ; print a default message in the empty scratch buffer opened at startup

(require 'package)
(setq package-enable-at-startup nil) ; tells emacs not to load any packages before starting up
(setq package-archives '(("org"       . "https://orgmode.org/elpa/")
			 ("gnu"       . "https://elpa.gnu.org/packages/")
                         ("melpa"     . "https://melpa.org/packages/")
                         ("marmalade" . "https://marmalade-repo.org/packages/")))
(package-initialize)

;; Bootstrap 'use-package'
(unless (package-installed-p 'use-package) ; unless it is already installed
  (package-refresh-contents) ; update package archives
  (package-install 'use-package)) ; install the most recent version of use-package

(defconst *is-a-mac*
  (eq system-type 'darwin)
  "Is this running on OS X?")


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
    
  (general-define-key
   :states '(normal visual)
   :prefix "SPC"
   
   ;; simple commands 
   "/"     'counsel-ag
   "TAB"   '(switch-to-other-buffer :which-key "other buffer")
   "a"     '(:ignore t :which-key "Applications")
   "ar"    'ranger
   "ad"    'dired
   "g"     '(:ignore t :which-key "Git")
   "gs"    'magit-status
   "b"     'ivy-switch-buffer   ; change buffer, chose using ivy
   "/"     'counsel-git-grep    ; find string in git project 
   "f"     '(:ignore t :which-key "Files")
   "ff"    'counsel-find-file     ; find file using ivy
   "fr"    'counsel-recentf       ; find recently edited file
   "fs"    'save-buffer           ; save current buffer
   "p"     '(:ignore t :which-key "Project")
   "pf"    'counsel-git           ; find file in git project
  ))

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



 
 















(require 'use-package)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   (quote
    (magit ranger evil which-key counsel swiper avy general use-package))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
