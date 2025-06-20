;;; init.el --- -*- lexical-binding: t; coding: utf-8; -*-

;;; Commentary:
;;
;; Emacs - A Self-Defined, Fast and Simple Emacs Configuration.
;;

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

;; BUILTIN
(when (or (featurep 'esup-child)
          (daemonp)
          noninteractive)
  (package-initialize))
(setq package-enable-at-startup nil)
(setq package-check-signature nil)
(setq package-quickstart t)
(setq package-archives '(("melpa" . "https://melpa.org/packages/")
                         ;; ("elpa-devel" . "https://elpa.gnu.org/devel/")
                         ;; ("org" . "https://orgmode.org/elpa/")
                         ;; ("marmalade" . "http://marmalade-repo.jrg/packages/")
                         ;; ("melpa-stable" . "https://stable.melpa.org/packages/")
                         ;; ("jcs-elpa" . "https://jcs-emacs.github.io/jcs-elpa/packages/")
                         ("gnu" . "https://elpa.gnu.org/packages/")
                         ("nongnu" . "https://elpa.nongnu.org/nongnu/")))
(defun require-package (package &optional min-version no-refresh)
  "Ask elpa to install given PACKAGE with MIN-VERSION.
If NO-REFRESH is nil, `package-refresh-contents' is called."
	(unless (featurep 'package)
    (condition-case nil
        (require 'package)
      (error nil)))
  (unless (package-installed-p package min-version)
    (unless (or (assoc package package-archive-contents) no-refresh)
      (message "Missing package: %s" package)
      (package-refresh-contents))
    (package-install package)))
(setq gc-cons-threshold most-positive-fixnum)
(setq gc-cons-percentage 0.6)
(setq frame-inhibit-implied-resize t)
(setq frame-resize-pixelwise t)
(setq-default read-process-output-max 1048576)
(setq-default read-buffer-completion-ignore-case t)
(setq-default cursor-in-non-selected-windows nil)
(setq-default highlight-nonselected-windows nil)
(setq-default bidi-display-reordering nil)
(setq-default bidi-inhibit-bpa t)
(setq-default long-line-threshold 500)
(setq-default large-hscroll-threshold 500)
(setq-default fast-but-imprecise-scrolling t)
(setq-default inhibit-compacting-font-caches t)
(setq-default read-process-output-max (* 64 1024))
(setq-default highlight-nonselected-windows nil)
(setq-default redisplay-skip-fontification-on-input t)
(setq-default cursor-in-non-selected-windows nil)
(setq-default enable-recursive-minibuffers t)
(setq-default bidi-paragraph-direction 'left-to-right)
(setq-default tab-width 2)
(setq-default truncate-lines t)
(setq-default completion-ignore-case t)
(setq-default resize-mini-windows t)
(setq-default use-short-answers t)
(setq-default display-fill-column-indicator-column 80)
(add-hook 'prog-mode-hook #'display-fill-column-indicator-mode)
(setq auto-save-list-file-prefix nil)
(setq initial-major-mode 'fundamental-mode)
(setq inhibit-startup-screen t)
(setq inhibit-startup-message t)
(setq inhibit-default-init t)
(setq initial-scratch-message (concat ";; Happy hacking, " user-login-name " - Emacs ♥ you!\n\n"))
(setq custom-file (locate-user-emacs-file "custom.el"))
(setq which-key-idle-delay 0.3)
(setq which-key-idle-secondary-delay 0.01)
(run-with-idle-timer 5 nil #'which-key-mode)
(setq-default indent-tabs-mode nil)
(add-hook 'prog-mode-hook #'column-number-mode)
(add-hook 'prog-mode-hook #'line-number-mode)
(add-hook 'prog-mode-hook #'size-indication-mode)
(add-hook 'prog-mode-hook #'display-line-numbers-mode)
(setq auto-save-default nil)
(setq make-backup-files nil)
(setq auto-mode-case-fold nil)
(add-hook 'after-init-hook #'auto-save-visited-mode)
(add-hook 'after-init-hook #'global-auto-revert-mode)
(add-hook 'prog-mode-hook #'electric-pair-mode)
(global-set-key (kbd "C-x C-b") #'ibuffer)
(setq dired-dwim-target t)
(setq dired-listing-switches "-alGhv")
(setq dired-recursive-copies 'always)
(setq dired-kill-when-opening-new-dired-buffer t)
(add-hook 'prog-mode-hook #'whitespace-mode)
(setq whitespace-style '(trailing face))
(add-hook 'after-init-hook #'global-so-long-mode)
(add-hook 'after-init-hook #'delete-selection-mode)
(add-hook 'prog-mode-hook #'show-paren-mode)
(setq show-paren-when-point-inside-paren t)
(setq show-paren-when-point-in-periphery t)
(setq show-paren-context-when-offscreen t)
(setq show-paren-delay 0.2)
(add-hook 'prog-mode-hook #'hl-line-mode)
(add-hook 'after-init-hook #'save-place-mode)

(provide 'init)
;;; init.el ends here
