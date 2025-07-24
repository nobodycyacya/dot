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

;; [[ BUILTIN ]]

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
  (setq-default outline-margin-width 1)
  (setq-default gc-cons-threshold most-positive-fixnum)
  (setq-default gc-cons-percentage 0.6)
  (setq-default use-short-answers t)
  (setq-default default-frame-alist
		'((menu-bar-lines . 0)
		  (tool-bar-lines . 0)
		  (vertical-scroll-bars)))
  (setq-default display-line-numbers 'relative))

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

(use-package display-fill-column-indicator
  :ensure nil
  :hook
  (prog-mode . global-display-fill-column-indicator-mode))

(use-package paren
  :ensure nil
  :hook
  (prog-mode . show-paren-mode))

(use-package simple
  :ensure nil
  :hook
  (prog-mode . line-number-mode)
  (prog-mode . column-number-mode))

(use-package loaddefs
  :ensure nil
  :hook
  (after-init . save-place-mode)
  (after-init . global-tab-line-mode)
  (prog-mode . electric-pair-mode))

(use-package flymake
  :ensure nil
  :hook
  (prog-mode . flymake-mode)
  :bind
  (("M-n" . flymake-goto-next-error)
   ("M-p" . flymake-goto-prev-error)))

(use-package ibuffer
  :ensure nil
  :bind
  (("C-x C-b" . ibuffer)))

(use-package indent
  :ensure nil
  :config
  (setq tab-always-indent 'complete))

;; [[ MELPA, ELPA ]]

(use-package evil
  :init
  (setq evil-want-keybinding nil)
  :hook
  (after-init . evil-mode))

(use-package evil-escape
  :hook
  (evil-mode . evil-escape-mode)
  :config
  (setq-default evil-escape-key-sequence "jk")
  (setq-default evil-escape-delay 0.2))

(use-package evil-collection
  :defer 5
  :config
  (evil-collection-init))

(use-package evil-nerd-commenter
  :after evil
  :bind
  (:map evil-normal-state-map
	("gcc" . evilnc-comment-or-uncomment-lines))
  (:map evil-visual-state-map
	("gc" . evilnc-comment-or-uncomment-lines)))

(use-package evil-matchit
  :hook
  (evil-mode . global-evil-matchit-mode))

(use-package evil-goggles
  :hook
  (evil-mode . evil-goggles-mode)
  :config
  (setq evil-goggles-pulse t)
  (setq evil-goggles-blocking-duration 1.500)
  (setq evil-goggles-async-duration 0.900)
  (setq evil-goggles-duration 1.500)
  (evil-goggles-use-diff-faces))

(use-package catppuccin-theme
  :hook
  (after-init . (lambda () (load-theme 'catppuccin t)))
  :custom-face
  (default ((t (:background "#11111b" :foreground "#cdd6f4"))))
  (line-number ((t (:background "#11111b" :foreground "#9399b2"))))
  (line-number-current-line ((t (:background "#11111b" :foreground "#a6e3a1" :weight bold))))
  (fringe ((t (:background "#11111b")))))

(use-package doom-modeline
  :hook
  (after-init . doom-modeline-mode)
  :config
  (setq doom-modeline-height 25)
  (setq doom-modeline-bar-width 5)
  (setq doom-modeline-minor-modes t))

(use-package minions
  :hook
  (doom-modeline-mode . minions-mode))

(use-package colorful-mode
  :hook
  (prog-mode . colorful-mode))

(use-package color-identifiers-mode
  :hook
  (after-init . global-color-identifiers-mode))

(use-package indent-bars
  :hook ((prog-mode yaml-mode) . indent-bars-mode)
  :config
  (setq indent-bars-color '(highlight :face-bg t :blend 0.425))
  (setq indent-bars-no-descend-string t)
  (setq indent-bars-display-on-blank-lines nil)
  (setq indent-bars-prefer-character t))

(use-package vertico
  :hook
  (after-init . vertico-mode)
  :bind
  (:map vertico-map
	("RET" . vertico-directory-enter)
	("DEL" . vertico-directory-delete-char))
  :config
  (setq vertico-scroll-margin 0)
  (setq vertico-count 15)
  (setq vertico-resize t)
  (setq vertico-cycle t))

(use-package orderless
  :custom
  (completion-styles '(orderless basic))
  (completion-category-defaults nil)
  (completion-category-overrides '((file (styles partial-completion)))))

(use-package nerd-icons-completion
  :hook
  (vertico-mode . nerd-icons-completion-mode))

(use-package marginalia
  :hook
  (vertico-mode . marginalia-mode))

(use-package corfu
  :hook
  (after-init . global-corfu-mode)
  (global-corfu-mode . corfu-popupinfo-mode)
  :custom-face
  (corfu-border ((t (:inherit region :background unspecified))))
  :config
  (setq corfu-auto t)
  (setq corfu-auto-prefix 1)
  (setq corfu-preview-current nil)
  (setq corfu-auto-delay 0.1)
  (setq corfu-popupinfo-delay '(0.4 . 0.2)))

(use-package nerd-icons-corfu
  :after corfu
  :init (add-to-list 'corfu-margin-formatters #'nerd-icons-corfu-formatter))

(use-package cape
  :init
  (add-to-list 'completion-at-point-functions #'cape-dabbrev)
  (add-to-list 'completion-at-point-functions #'cape-file)
  (add-to-list 'completion-at-point-functions #'cape-elisp-block)
  (add-to-list 'completion-at-point-functions #'cape-keyword)
  (add-to-list 'completion-at-point-functions #'cape-abbrev))

(use-package yasnippet-capf
  :after cape
  :init
  (add-to-list 'completion-at-point-functions #'yasnippet-capf))

(use-package consult
  :hook
  (completion-list-mode . consult-preview-at-point-mode)
  :bind
  (("C-s" . consult-line)
   ("C-c h". consult-history)
   ("C-c f". consult-flymake)
   ("C-c r". consult-ripgrep)
   ("C-c o". consult-outline)
   ("C-x b" . consult-buffer)
   ("C-x 4 b" . consult-buffer-other-window)
   ("C-x 5 b" . consult-buffer-other-frame)
   ("C-x r b" . consult-bookmark)
   ("C-x p b" . consult-project-buffer)))

(use-package consult-eglot
  :after consult)

(use-package consult-todo
  :after consult
  :bind
  (("C-c t" . consult-todo)))

(use-package embark
  :bind
  (("C-." . embark-act)
   ("C-;" . embark-export)
   ("C-c C-l"  . embark-collect)))

(use-package embark-consult
  :hook
  (embark-collect-mode . consult-preview-at-point-mode))

(use-package helpful
  :bind
  (("C-h f" . helpful-callable)
   ("C-h v" . helpful-variable)
   ("C-h k" . helpful-key)
   ("C-h x" . helpful-command)
   ("C-h C-d" . helpful-at-point)))

(use-package rainbow-delimiters
  :hook
  (prog-mode . rainbow-delimiters-mode))

(use-package nerd-icons-ibuffer
  :hook
  (ibuffer-mode . nerd-icons-ibuffer-mode))

(use-package nerd-icons-dired
  :hook
  (dired-mode . nerd-icons-dired-mode))

(use-package diredfl
  :hook
  (dired-mode . diredfl-mode))

(use-package yasnippet
  :hook
  (prog-mode . yas-minor-mode))

(use-package yasnippet-snippets
  :after yasnippet)

(use-package ace-window
  :bind
  (([remap other-window] . ace-window))
  :config
  (setq aw-keys '(?a ?s ?d ?f ?g ?h ?j ?k ?l)))

(use-package winum
  :hook
  (after-init . winum-mode))

(use-package tab-line-nerd-icons
  :hook
  (global-tab-line-mode . tab-line-nerd-icons-global-mode))

(use-package avy
  :bind
  (("M-g l" . avy-goto-line)
   ("M-g c" . avy-goto-char-timer)
   ("M-g w" . avy-goto-word-0)))

(use-package hl-todo
  :hook ((prog-mode yaml-mode) . hl-todo-mode)
  :config
  (setq hl-todo-highlight-punctuation ":")
  (setq hl-todo-keyword-faces
        '(("TODO" warning bold)
          ("FIXME" error bold)
          ("REVIEW" font-lock-keyword-face bold)
          ("HACK" font-lock-constant-face bold)
          ("DEPRECATED" font-lock-doc-face bold)
          ("NOTE" success bold)
          ("BUG" error bold)
          ("XXX" font-lock-constant-face bold))))

(use-package dired-sidebar
  :hook
  (dired-sidebar-mode . (lambda () (display-line-numbers-mode -1)))
  :commands (dired-sidebar-show-sidebar))

(use-package wgrep
  :bind
  (:map grep-mode-map
	("C-c C-q" . wgrep-change-to-wgrep-mode))
  :commands
  (wgrep wgrep-change-to-wgrep-mode)
  :config
  (setq wgrep-auto-save-buffer t))

(use-package diff-hl
  :hook
  (after-init . global-diff-hl-mode)
  (dired-mode . diff-hl-dired-mode)
  (after-init . global-diff-hl-show-hunk-mouse-mode))

(use-package hide-mode-line
  :hook
  ((dired-sidebar-mode
    completion-list-mode
    eshell-mode
    term-mode
    symbols-outline-mode) . hide-mode-line-mode))

(use-package solaire-mode
  :hook
  (after-init . solaire-global-mode))

(use-package eshell-syntax-highlighting
  :hook
  (eshell-mode . eshell-syntax-highlighting-mode))

(use-package highlight-defined
  :hook
  (emacs-lisp-mode . highlight-defined-mode))

(use-package highlight-numbers
  :hook
  (prog-mode . highlight-numbers-mode))

(use-package symbols-outline
  :hook
  (eglot-mode . (lambda () (setq-local symbols-outline-fetch-fn #'symbols-outline-lsp-fetch)))
  :config
  (setq symbols-outline-window-position 'right)
  (symbols-outline-follow-mode))

(use-package symbol-overlay
  :bind
  (("M-i" . symbol-overlay-put)
   ("M-g n" . symbol-overlay-jump-next)
   ("M-g p" . symbol-overlay-jump-prev)
   ("M-g r" . symbol-overlay-remove-all))
  :hook
  (prog-mode . symbol-overlay-mode))

(use-package beacon
  :hook
  (after-init . beacon-mode)
  :config
  (setq beacon-size 60)
  (setq beacon-color "#ff0000")
  (setq beacon-blink-duration 0.8)
  (setq beacon-blink-delay 0.8)
  (setq beacon-blink-when-window-scrolls t)
  (setq beacon-blink-when-window-changes t)
  (setq beacon-blink-when-point-moves t))

(use-package xclip
  :hook
  (after-init . xclip-mode))

(use-package gcmh
  :hook
  (after-init . gcmh-mode))

(use-package flymake-popon
  :hook (flymake-mode . flymake-popon-mode))

(use-package lua-mode
  :config
  (setq lua-indent-level 2)
  (setq lua-indent-nested-block-content-align nil)
  (setq lua-indent-close-paren-align nil))

(use-package pyvenv
  :hook
  (python-mode . pyvenv-mode))

(use-package ess)
(use-package vimrc-mode)
(use-package csv-mode)
(use-package yaml-mode)
(use-package json-mode)
(use-package toml-mode)
(use-package typescript-mode)
(use-package web-mode)
(use-package emmet-mode)
(use-package markdown-mode)
(use-package quarto-mode)

(provide 'init)
;;; init.el ends here
