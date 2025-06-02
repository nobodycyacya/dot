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
(when (eq system-type 'darwin)
	(setq mac-option-modifier 'super)
  (setq mac-command-modifier 'meta))
(add-hook 'window-setup-hook
					#'(lambda ()
							(cl-loop for font in '("JetbrainsMono Nerd Font" "SF Mono" "Monaco" "Menlo" "Consolas")
											 when (find-font (font-spec :name font))
											 return (set-face-attribute 'default nil :family font :height 130))))
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
(add-hook 'yaml-mode-hook #'display-line-numbers-mode)
(add-hook 'conf-mode-hook #'display-line-numbers-mode)
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
(setq treesit-language-source-alist
      '((bash . ("https://github.com/tree-sitter/tree-sitter-bash"))
        (c . ("https://github.com/tree-sitter/tree-sitter-c"))
        (cpp . ("https://github.com/tree-sitter/tree-sitter-cpp"))
        (css . ("https://github.com/tree-sitter/tree-sitter-css"))
        (cmake . ("https://github.com/uyha/tree-sitter-cmake"))
        (csharp . ("https://github.com/tree-sitter/tree-sitter-c-sharp.git"))
        (dockerfile . ("https://github.com/camdencheek/tree-sitter-dockerfile"))
        (elisp . ("https://github.com/Wilfred/tree-sitter-elisp"))
        (elixir "https://github.com/elixir-lang/tree-sitter-elixir" "main" "src" nil nil)
        (go . ("https://github.com/tree-sitter/tree-sitter-go"))
        (gomod . ("https://github.com/camdencheek/tree-sitter-go-mod.git"))
        (haskell "https://github.com/tree-sitter/tree-sitter-haskell" "master" "src" nil nil)
        (html . ("https://github.com/tree-sitter/tree-sitter-html"))
        (java . ("https://github.com/tree-sitter/tree-sitter-java.git"))
        (javascript . ("https://github.com/tree-sitter/tree-sitter-javascript"))
        (json . ("https://github.com/tree-sitter/tree-sitter-json"))
        (lua . ("https://github.com/Azganoth/tree-sitter-lua"))
        (make . ("https://github.com/alemuller/tree-sitter-make"))
        (markdown . ("https://github.com/tree-sitter-grammars/tree-sitter-markdown" "split_parser" "tree-sitter-markdown/src"))
        (markdown-inline . ("https://github.com/tree-sitter-grammars/tree-sitter-markdown" "split_parser" "tree-sitter-markdown-inline/src"))
        (ocaml . ("https://github.com/tree-sitter/tree-sitter-ocaml" nil "ocaml/src"))
        (org . ("https://github.com/milisims/tree-sitter-org"))
        (python . ("https://github.com/tree-sitter/tree-sitter-python"))
        (php . ("https://github.com/tree-sitter/tree-sitter-php"))
        (typescript . ("https://github.com/tree-sitter/tree-sitter-typescript" nil "typescript/src"))
        (tsx . ("https://github.com/tree-sitter/tree-sitter-typescript" nil "tsx/src"))
        (ruby . ("https://github.com/tree-sitter/tree-sitter-ruby"))
        (rust . ("https://github.com/tree-sitter/tree-sitter-rust"))
        (sql . ("https://github.com/m-novikov/tree-sitter-sql"))
        (scala "https://github.com/tree-sitter/tree-sitter-scala" "master" "src" nil nil)
        (toml "https://github.com/tree-sitter/tree-sitter-toml" "master" "src" nil nil)
        (vue . ("https://github.com/merico-dev/tree-sitter-vue"))
        (kotlin . ("https://github.com/fwcd/tree-sitter-kotlin"))
        (yaml . ("https://github.com/ikatyang/tree-sitter-yaml"))
        (zig . ("https://github.com/GrayJack/tree-sitter-zig"))
        (clojure . ("https://github.com/sogaiu/tree-sitter-clojure"))
        (nix . ("https://github.com/nix-community/nix-ts-mode"))
        (mojo . ("https://github.com/HerringtonDarkholme/tree-sitter-mojo"))))
(setq-default display-fill-column-indicator-column 80)
(add-hook 'prog-mode-hook #'display-fill-column-indicator-mode)

;; VIM-LIKE
(require-package 'evil)
(add-hook 'after-init-hook #'evil-mode)
(setq evil-want-integration t)
(setq evil-want-keybinding nil)

(require-package 'evil-escape)
(add-hook 'evil-mode-hook #'evil-escape-mode)
(with-eval-after-load 'evil-escape
	(setq-default evil-escape-key-sequence "jk")
	(setq-default evil-escape-delay 0.2))

(require-package 'evil-collection)
(add-hook 'evil-mode-hook #'evil-collection-init)

(require-package 'evil-nerd-commenter)
(with-eval-after-load 'evil
  (define-key evil-normal-state-map (kbd "gcc") #'evilnc-comment-or-uncomment-lines)
  (define-key evil-visual-state-map (kbd "gc") #'evilnc-comment-or-uncomment-lines))

(require-package 'evil-matchit)
(add-hook 'evil-mode-hook #'global-evil-matchit-mode)

(require-package 'evil-goggles)
(add-hook 'evil-mode-hook #'evil-goggles-mode)
(with-eval-after-load 'evil-goggles
  (setq evil-goggles-pulse t)
  (setq evil-goggles-duration 1.500)
  (setq evil-goggles-blocking-duration 1.500)
  (setq evil-goggles-async-duration 1.500)
  (evil-goggles-use-diff-faces))

(require-package 'evil-surround)
(add-hook 'evil-mode-hook #'evil-surround-mode)

(require-package 'evil-visualstar)
(add-hook 'evil-mode-hook #'global-evil-visualstar-mode)

(require-package 'evil-args)
(with-eval-after-load 'evil
  (define-key evil-normal-state-map "L" 'evil-forward-arg)
  (define-key evil-normal-state-map "H" 'evil-backward-arg)
  (define-key evil-motion-state-map "L" 'evil-forward-arg)
  (define-key evil-motion-state-map "H" 'evil-backward-arg))

(require-package 'evil-indent-plus)
(with-eval-after-load 'evil
  (define-key evil-inner-text-objects-map "i" 'evil-indent-plus-i-indent)
  (define-key evil-outer-text-objects-map "i" 'evil-indent-plus-a-indent)
  (define-key evil-inner-text-objects-map "I" 'evil-indent-plus-i-indent-up)
  (define-key evil-outer-text-objects-map "I" 'evil-indent-plus-a-indent-up)
  (define-key evil-inner-text-objects-map "J" 'evil-indent-plus-i-indent-up-down)
  (define-key evil-outer-text-objects-map "J" 'evil-indent-plus-a-indent-up-down))

(require-package 'evil-snipe)
(add-hook 'evil-mode-hook #'evil-snipe-mode)
(add-hook 'evil-mode-hook #'evil-snipe-override-mode)
(with-eval-after-load 'evil-snipe
  (setq evil-snipe-scope 'whole-buffer))

(require-package 'general)
(run-with-idle-timer
 5 nil
 #'(lambda ()
     (require 'general)
     (general-evil-setup t)
     (general-create-definer spc-leader-def
       :prefix "SPC"
       :states '(normal visual))
     (spc-leader-def
       "SPC" 'counsel-M-x
       "ff" 'counsel-find-file
       "fb" 'counsel-ibuffer
       "fc" 'counsel-load-theme
       "fw" 'counsel-rg
       "fW" 'counsel-grep
       "fF" 'counsel-flycheck
       "fo" 'counsel-outline
       "tt" 'emacs-init-time
       "tn" 'neotree-toggle
       "ts" 'scratch
       "tr" 'quickrun
       "tp" 'symbol-overlay-put
       "tu" 'vundo
       "tR" 'symbol-overlay-remove-all
       "tm" 'minimap-mode
       "ww" 'ace-window
       "wd" 'ace-delete-window
       "wD" 'ace-delete-other-windows
       "1" 'winum-select-window-1
       "2" 'winum-select-window-2
       "3" 'winum-select-window-3
       "4" 'winum-select-window-4
       "5" 'winum-select-window-5
       "6" 'winum-select-window-6
       "7" 'winum-select-window-7
       "8" 'winum-select-window-8
       "9" 'winum-select-window-9
       "0" 'winum-select-window-0-or-10)))

;; COMPLETION, SNIPPET
(require-package 'company)
(add-hook 'prog-mode-hook #'global-company-mode)
(with-eval-after-load 'company
  (setq company-idle-delay 0.01)
  (setq company-minimum-prefix-length 1)
  (setq company-tooltip-align-annotations t)
  (setq company-tooltip-margin 3)
  (setq company-format-margin-function #'company-text-icons-margin)
  (setq company-global-modes '(not eshell-mode help-mode vterm-mode))
  (setq company-dabbrev-other-buffers nil)
  (setq company-dabbrev-ignore-case nil)
  (setq company-dabbrev-downcase nil)
  (setq company-backends
        '((company-capf :with company-yasnippet)
          (company-files :with company-yasnippet)
          (company-dabbrev :with company-yasnippet)
          ((company-dabbrev-code company-keywords) :with company-yasnippet))))

(require-package 'company-box)
(when (display-graphic-p)
  (add-hook 'global-company-mode-hook #'company-box-mode))
(with-eval-after-load 'company-box
  (setq company-box-show-single-candidate t)
  (setq company-box-backends-colors nil)
  (setq company-box-tooltip-limit 50)
  (setq company-box-icons-alist 'company-box-icons-idea))

(require-package 'yasnippet)
(require-package 'yasnippet-snippets)
(add-hook 'prog-mode-hook #'yas-minor-mode)

;; UI
(require-package 'dashboard)
(when (display-graphic-p)
  (add-hook 'after-init-hook #'dashboard-setup-startup-hook))
(with-eval-after-load 'dashboard
  (setq dashboard-startup-banner 'logo)
  (setq dashboard-center-content t)
  (setq dashboard-vertically-center-content t)
  (setq dashboard-navigation-cycle t)
  (setq dashboard-display-icons-p t)
  (setq dashboard-icon-type 'nerd-icons)
  (setq dashboard-set-heading-icons t)
  (setq dashboard-set-file-icons t)
  (setq dashboard-icon-file-height 1.25)
  (setq dashboard-heading-icon-height 1.25)
  (setq dashboard-icon-file-v-adjust -0.125)
  (setq dashboard-heading-icon-v-adjust -0.125)
  (setq dashboard-item-shortcuts '((recents . "r") (bookmarks . "m") (projects . "p")))
  (setq dashboard-items '((recents . 10) (bookmarks . 10) (projects . 5))))

(require-package 'rainbow-delimiters)
(add-hook 'prog-mode-hook #'rainbow-delimiters-mode)

(require-package 'nerd-icons-ibuffer)
(add-hook 'ibuffer-mode-hook #'nerd-icons-ibuffer-mode)

(require-package 'diredfl)
(add-hook 'dired-mode-hook #'diredfl-mode)

(require-package 'nerd-icons-dired)
(add-hook 'dired-mode-hook #'nerd-icons-dired-mode)

(require-package 'doom-themes)
(add-hook 'after-init-hook #'(lambda () (load-theme 'doom-palenight t)))

(require-package 'doom-modeline)
(run-with-idle-timer 5 nil #'doom-modeline-mode)
(with-eval-after-load 'doom-modeline
  (setq doom-modeline-height 25)
  (setq doom-modeline-bar-width 5)
  (setq doom-modeline-window-width-limit 75)
  (setq doom-modeline-minor-modes t))

(require-package 'minions)
(add-hook 'doom-modeline-mode-hook #'minions-mode)

(require-package 'solaire-mode)
(run-with-idle-timer 5 nil #'solaire-global-mode)

(require-package 'hide-mode-line)
(add-hook 'completion-list-mode-hook #'hide-mode-line-mode)
(add-hook 'neotree-mode-hook #'hide-mode-line-mode)
(add-hook 'eshell-mode-hook #'hide-mode-line-mode)

(require-package 'winum)
(run-with-idle-timer 5 nil #'winum-mode)
(with-eval-after-load 'winum
  (setq winum-format "[%s]")
  (setq winum-mode-line-position 0)
  (set-face-attribute 'winum-face nil :foreground "DeepPink" :weight 'bold))

(require-package 'highlight-numbers)
(add-hook 'prog-mode-hook #'highlight-numbers-mode)

(require-package 'auto-highlight-symbol)
(add-hook 'prog-mode-hook #'global-auto-highlight-symbol-mode)

(require-package 'highlight-defined)
(add-hook 'emacs-lisp-mode-hook #'highlight-defined-mode)

(require-package 'highlight-quoted)
(add-hook 'emacs-lisp-mode-hook #'highlight-quoted-mode)

(require-package 'beacon)
(run-with-idle-timer 5 nil #'beacon-mode)
(with-eval-after-load 'beacon
  (setq beacon-size 60)
  (setq beacon-blink-duration 1.0)
  (setq beacon-blink-when-point-moves-vertically 3)
  (setq beacon-blink-when-point-moves-horizontally 3)
  (setq beacon-blink-when-focused t))

(require-package 'indent-bars)
(add-hook 'prog-mode-hook #'indent-bars-mode)
(with-eval-after-load 'indent-bars
  (setq indent-bars-starting-column 0)
  (setq indent-bars-width-frac 0.15)
  (setq indent-bars-prefer-character t)
  (setq indent-bars-no-descend-string t)
  (setq indent-bars-display-on-blank-lines nil)
  (setq indent-bars-color '(highlight :face-bg t :blend 0.425)))

(require-package 'mode-line-bell)
(run-with-idle-timer 10 nil #'mode-line-bell-mode)

(require-package 'centaur-tabs)
(run-with-idle-timer
 5 nil
 #'(lambda ()
     (setq centaur-tabs-style "bar")
     (setq centaur-tabs-height 25)
     (setq centaur-tabs-set-icons t)
     (setq centaur-tabs-icon-type 'nerd-icons)
     (setq centaur-tabs-gray-out-icons 'buffer)
     (setq centaur-tabs-set-bar 'over)
     (centaur-tabs-mode)))

;; IVY
(require-package 'ivy)
(require-package 'counsel)
(require-package 'swiper)
(require-package 'ivy-rich)
(require-package 'nerd-icons-ivy-rich)
(add-hook 'after-init-hook #'ivy-mode)
(add-hook 'ivy-mode-hook #'counsel-mode)
(add-hook 'ivy-mode-hook #'ivy-rich-mode)
(add-hook 'ivy-mode-hook #'nerd-icons-ivy-rich-mode)
(with-eval-after-load 'ivy
  (setq ivy-use-virutal-buffers t)
  (setq enable-recursive-minibuffers t)
  (setq ivy-height 13)
  (setq ivy-initial-inputs-alist nil)
  (setq ivy-count-format "(%d/%d)")
  (setq ivy-re-builders-alist `((t . ivy--regex-ignore-order))))
(global-set-key (kbd "C-s") #'counsel-grep-or-swiper)

(require-package 'amx)
(add-hook 'ivy-mode-hook #'amx-mode)

(require-package 'wgrep)
(with-eval-after-load 'wgrep
  (setq wgrep-auto-save-buffer t))

(require-package 'avy)

(require-package 'hydra)
(require-package 'pretty-hydra)
(run-with-idle-timer
 5 nil
 #'(lambda ()
     ;; avy
     (pretty-hydra-define hydra-avy
       (:color pink :quit-key "q" :title "Avy Commands")
       ("Line"
        (("y" avy-copy-line)
         ("m" avy-move-line)
         ("k" avy-kill-whole-line))
        "Region"
        (("Y" avy-copy-region)
         ("M" avy-move-region)
         ("K" avy-kill-region))
        "Goto"
        (("c" avy-goto-char-timer)
         ("C" avy-goto-char)
         ("w" avy-goto-word-1)
         ("W" avy-goto-word-0)
         ("l" avy-goto-line)
         ("L" avy-goto-end-of-line))))
     (global-set-key (kbd "M-g a") 'hydra-avy/body)
     ;; lsp-mode
     (pretty-hydra-define hydra-lsp
       (:color pink :quit-key "q" :title "LSP Commands")
       ("Buffer"
        (("f" lsp-format-buffer)
         ("m" lsp-ui-imenu)
         ("x" lsp-execute-code-action))
        "Server"
        (("M-r" lsp-restart-workspace)
         ("S" lsp-shutdown-workspace)
         ("M-s" lsp-describe-session))
        "Symbol"
        (("d" lsp-find-declaration)
         ("D" lsp-ui-peek-find-definitions)
         ("R" lsp-ui-peek-find-references)
         ("i" lsp-ui-peek-find-implementation)
         ("t" lsp-find-type-definition)
         ("s" lsp-signature-help)
         ("o" lsp-describe-thing-at-point)
         ("r" lsp-rename))))
     (global-set-key (kbd "M-g l") 'hydra-lsp/body)))

;; TOOL
(require-package 'ace-window)
(global-set-key [remap other-window] #'ace-window)
(with-eval-after-load 'ace-window
  (setq aw-keys '(?a ?s ?d ?f ?g ?h ?j ?k ?l)))

(require-package 'symbol-overlay)
(add-hook 'prog-mode-hook #'symbol-overlay-mode)
(with-eval-after-load 'symbol-overlay
  (global-set-key (kbd "M-g p") 'symbol-overlay-put)
  (global-set-key (kbd "M-g r") 'symbol-overlay-remove-all))

(require-package 'colorful-mode)
(add-hook 'prog-mode-hook #'colorful-mode)

(require-package 'gcmh)
(run-with-idle-timer 2 nil #'gcmh-mode)

(require-package 'xclip)
(run-with-idle-timer 2 nil #'xclip-mode)

(require-package 'neotree)
(with-eval-after-load 'neotree
  (setq neo-theme 'nerd-icons))

(require-package 'quickrun)
(with-eval-after-load 'quickrun
  (setq quickrun-focus-p nil))

(require-package 'helpful)
(global-set-key (kbd "C-h f") #'helpful-callable)
(global-set-key (kbd "C-h v") #'helpful-variable)
(global-set-key (kbd "C-h k") #'helpful-key)
(global-set-key (kbd "C-h x") #'helpful-command)
(global-set-key (kbd "C-c C-d") #'helpful-at-point)

(require-package 'git-gutter)
(add-hook 'prog-mode-hook #'global-git-gutter-mode)

(require-package 'format-all)
(add-hook 'prog-mode-hook #'format-all-mode)

(require-package 'scratch)

(require-package 'vundo)

(require-package 'sudo-edit)

(require-package 'hl-todo)
(add-hook 'prog-mode-hook #'hl-todo-mode)
(add-hook 'yaml-mode-hook #'hl-todo-mode)
(with-eval-after-load 'hl-todo
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

(require-package 'esup)

(require-package 'exec-path-from-shell)
(when (eq system-type 'darwin)
  (run-with-idle-timer 10 nil #'exec-path-from-shell-initialize))

(require-package 'eshell-syntax-highlighting)
(add-hook 'eshell-mode-hook #'eshell-syntax-highlighting-mode)

(require-package 'minimap)
(with-eval-after-load 'minimap
  (setq minimap-window-location 'right)
  (setq minimap-update-delay 0.1)
  (setq minimap-width-fraction 0.09)
  (setq minimap-minimum-width 15))

(require-package 'symbols-outline)
(with-eval-after-load 'symbols-outline
  (setq symbols-outline-fetch-fn #'symbols-outline-lsp-fetch)
  (setq symbols-outline-window-position 'right))

;; SYNTAX CHECK
(require-package 'flycheck)
(add-hook 'prog-mode-hook #'global-flycheck-mode)

;; LSP & DAP
(require-package 'lsp-mode)
(require-package 'lsp-ivy)
(require-package 'lsp-ui)
(require-package 'dap-mode)

;; PROGRAMMING
(require-package 'lua-mode)
(with-eval-after-load 'lua-mode
  (setq lua-indent-level 2)
  (setq lua-indent-nested-block-content-align nil)
  (setq lua-indent-close-paren-align nil))

(require-package 'pyvenv)
(add-hook 'python-mode-hook #'pyvenv-mode)

(require-package 'typescript-mode)
(require-package 'markdown-mode)
(require-package 'vimrc-mode)
(require-package 'scss-mode)
(require-package 'web-mode)
(require-package 'go-mode)
(require-package 'cmake-mode)
(require-package 'rust-mode)
(require-package 'dotenv-mode)
(require-package 'ess)
(require-package 'ess-view-data)
(require-package 'polymode)
(require-package 'poly-R)
(require-package 'quarto-mode)
(require-package 'clojure-mode)
(require-package 'haskell-mode)
(require-package 'json-mode)
(require-package 'yaml-mode)
(require-package 'csv-mode)
(require-package 'toml-mode)
(require-package 'emmet-mode)
(require-package 'zig-mode)
(require-package 'rust-mode)

(provide 'init)
;; Local Variables:
;; no-byte-compile: t
;; no-native-compile: t
;; no-update-autoloads: t
;; End:
;;; init.el ends here
