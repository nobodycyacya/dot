;;; init.el --- -*- lexical-binding: t; coding: utf-8; -*-

;;; Commentary:

;;; References:
;; https://github.com/seagle0128/.emacs.d
;; https://github.com/bbatsov/prelude
;; https://github.com/redguardtoo/emacs.d
;; https://github.com/manateelazycat/lazycat-emacs
;; https://github.com/MiniApollo/kickstart.emacs
;; https://github.com/doomemacs/doomemacs
;; https://github.com/purcell/emacs.d
;; https://github.com/SystemCrafters/crafted-emacs

;;; Code:

(use-package use-package
  :custom
  (use-package-always-ensure t)
  (use-package-always-defer t)
  (use-package-expand-minimally t)
  (use-package-enable-imenu-support t))

(use-package package
  :ensure nil
  :custom
  (package-enable-at-startup nil)
  :config
  (when (or (featurep 'esup-child)
            (daemonp)
            noninteractive)
    (package-initialize))
  (setq package-check-signature nil)
  (setq package-quickstart t)
  (setq package-archives '(("melpa" . "https://melpa.org/packages/")
                           ;; ("elpa-devel" . "https://elpa.gnu.org/devel/")
                           ;; ("org" . "https://orgmode.org/elpa/")
                           ;; ("marmalade" . "http://marmalade-repo.jrg/packages/")
                           ;; ("melpa-stable" . "https://stable.melpa.org/packages/")
                           ;; ("jcs-elpa" . "https://jcs-emacs.github.io/jcs-elpa/packages/")
                           ("gnu" . "https://elpa.gnu.org/packages/")
                           ("nongnu" . "https://elpa.nongnu.org/nongnu/"))))

(use-package emacs
  :ensure nil
  :config
  (setq-default gc-cons-threshold most-positive-fixnum)
  (setq-default gc-cons-percentage 0.6)
  (setq-default use-short-answers t))

(use-package startup
  :ensure nil
  :custom
  (initial-major-mode 'fundamental-mode)
  (inhibit-startup-screen t)
  (inhibit-startup-message t)
  (inhibit-default-init t))

(use-package cus-edit
  :ensure nil
  :custom
  (custom-file (locate-user-emacs-file "custom.el")))

(use-package which-key
  :ensure nil
  :defer 10
  :config
  (which-key-mode +1))

(use-package autorevert
  :ensure nil
  :hook
  (after-init . global-auto-revert-mode))

(provide 'init)
;;; init.el ends here
