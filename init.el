(let ((gc-cons-threshold (* 24 1024 1024)))
  (require 'package)
  (setq package-enable-at-startup nil)
  (setq package-archives '(("org"       . "https://orgmode.org/elpa/")
      			   ("gnu"       . "https://elpa.gnu.org/packages/")
                           ("melpa"     . "https://melpa.org/packages/")
                           ("marmalade" . "https://marmalade-repo.org/packages/")))
  (package-initialize)

  ;; Bootstrap 'use-package'
  (unless (package-installed-p 'use-package) ; unless it is already installed
    (package-refresh-contents) ; update package archives
    (package-install 'use-package)) ; install the most recent version of use-package

  (use-package org
    :pin org
    :ensure org-plus-contrib
    :defer 7)

  (setq vc-follow-symlinks "t") ; Don't prompt when opening org file
  (org-babel-load-file (expand-file-name "config.org" user-emacs-directory))

  (garbage-collect))
