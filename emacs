(setq inhibit-splash-screen t)
(add-to-list 'custom-theme-load-path "~/.emacs.d/themes/")
(load-theme 'zenburn t)

;; For it to work in terminal mode, dark mode had to be forced
;(setq frame-background-mode 'dark)

;; Set up link to package sources and initialize
(require 'package)

;; Set package archives to include melpa
(setq package-archives
      '(("gnu" . "https://elpa.gnu.org/packages/")
        ("melpa-stable" . "https://stable.melpa.org/packages/")
        ("melpa" . "https://melpa.org/packages/"))
      tls-checktrust t
      tls-program '("gnutls-cli --x509cafile %t -p %p %h")
      gnutls-verify-error t)
    
;; Add additional package sources
; (add-to-list 'package-archives
;          '("NAME" . "URL"))

;; Initialize packages
(package-initialize)
; (package-refresh-contents)

;; Install package installer use-package unless it is installed
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

(require 'use-package)
(setq use-package-always-ensure t)

;; Define packages to use:

; ;; Smartparens to better handle parenthesis and brackets
; (use-package smartparens
;   :diminish smartparens-mode
;   :config
;   (progn
;     (require 'smartparens-config)
;     (smartparens-global-mode 1)
;     (show-paren-mode t)))

;; Ace jump mode to navigate in editor
(use-package ace-jump-mode
  :bind ("C-c SPC" . ace-jump-mode)
  :bind ("C-x SPC" . ace-jump-mode-pop-mark))

; Enable mark pop between windows and frames
(autoload
  'ace-jump-mode-pop-mark
  "ace-jump-mode"
  "Ace jump back:-)"
  t)
(eval-after-load "ace-jump-mode"
  '(ace-jump-mode-enable-mark-sync))
;(define-key global-map (kbd "C-x SPC") 'ace-jump-mode-pop-mark)

;; Multi-term to enable easy terminal handling
(use-package multi-term
  :bind ("C-c t" . 'multi-term-dedicated-toggle)
  :bind ("C-c C-t" . 'multi-term))
(setq multi-term-program "/bin/bash")
(setq multi-term-dedicated-close-back-to-open-buffer-p t)
(setq multi-term-dedicated-select-after-open-p t)

;; Magit to incorporate and improve git-commands
(use-package magit
  :bind ("C-x g" . 'magit-status))

;; Flyckeck to verify code syntax
(use-package flycheck)
(add-hook 'after-init-hook #'global-flycheck-mode)

;; Company to help with auto-completion
(use-package company)
(add-hook 'after-init-hook #'global-company-mode)

;; Load Go-specific language syntax
(defun my-go-electric-brace ()
  "Insert an opening brace may be with the closing one.
   If there is a space before the brace also adds new line with
   properly indented closing brace and moves cursor to another line
   inserted between the braces between the braces."
  (interactive)
  (if (not (looking-back " "))
      (insert "{")
    (insert "{")
    (newline)
    (indent-according-to-mode)
    (save-excursion
      (newline)
      (insert "}")
      (indent-according-to-mode))))

(defun my-go-list-packages ()
  "Return list of Go packages."
  (split-string
   (with-temp-buffer
     (shell-command "go list ... 2>/dev/null" (current-buffer))
     (buffer-substring-no-properties (point-min) (point-max)))
   "\n"))

(defun my-godoc-package ()
  "Display godoc for given package (with completion)."
  (interactive)
  (godoc (helm :sources (helm-build-sync-source "Go packages"
                          :candidates (my-go-list-packages))
               :buffer "*godoc packages*")))

(use-package go-guru)

(use-package yasnippet)

(use-package go-mode
  :init
  (setq gofmt-command "goimports"     ; use goimports instead of gofmt
        go-fontify-function-calls nil ; fontifing names of called
                                      ; functions is too much for me
        company-idle-delay nil ; avoid auto completion popup, use TAB
                               ; to show it
        tab-width 4 ; set indent to 4 characters
        indent-tabs-mode nil) ; use spaces for indents
  :bind
  (:map go-mode-map
        ("C-c d" . lsp-describe-thing-at-point)
        ("C-c g" . godoc)
        ("C-c P" . my-godoc-package)
        ("{" . my-go-electric-brace)
        ("C-i" . company-indent-or-complete-common)
        ("C-M-i" . company-indent-or-complete-common)
   )
  :config
  (require 'go-guru)
  (require 'yasnippet)
  (add-hook 'go-mode-hook #'lsp)
  (add-hook 'go-mode-hook #'smartparens-mode)
  ;; run gofmt/goimports when saving the file
  (add-hook 'before-save-hook #'gofmt-before-save))

;; Go/speedbar integration

(eval-after-load 'speedbar
  '(speedbar-add-supported-extension ".go"))

;; Setup for gopls
;; For more information see https://github.com/golang/tools/blob/master/gopls/doc/emacs.md
(use-package lsp-mode
  :commands (lsp lsp-deferred))
(add-hook 'go-mode-hook #'lsp-deferred)

;; Provides fancier overlays
(use-package lsp-ui
  :commands lsp-ui-mode)

;; Use company-mode for completion (otherwise, complete-at-point works out of the box):
(use-package company-lsp
  :commands company-lsp)

;; ------------- General Emacs settings -------------------------------------------------

(delete-selection-mode 1)

(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)
(setq split-width-threshold 0)
(setq split-height-threshold nil)

;; Enable as much font locking as possible
(global-font-lock-mode 1)
(setq font-lock-maximum-decoration t)

(setq lazy-lock-defer-contextually t)
(setq font-lock-maximum-decoration t)

(show-paren-mode)

;; Visible bell
(setq visible-bell t)

;; Make the Delete key perform delete-char and not backspace
;(global-set-key (quote [DEL]) 'delete-char)

(set-input-mode nil nil 1)
(set-language-environment 'Latin-1)

;; Make cursor stay at the end of the buffer instead of adding newlines and set tab defaults
(setq-default next-line-add-newlines nil
              indent-tabs-mode nil
              tab-width 4)

(setq-default c-default-style "k&r"
              c-basic-offset 4)

(line-number-mode t)
(setq which-func-mode t)
(which-function-mode)
(column-number-mode t)

(setq ediff-diff-options "-w")
(setq ediff-split-window-function 'split-window-horizontally)

(display-time)

(require 'cc-mode)

; Various balanced inserts
(defun insert-balanced-braces()
  (interactive)
  (insert "{}")
  (backward-char)
)
(global-set-key "\M-{" 'insert-balanced-braces)

(defun insert-balanced-brackets()
  (interactive)
  (insert "[]")
  (backward-char)
)
(global-set-key "\M-[" 'insert-balanced-brackets)

(defun insert-balanced-quotes()
  (interactive)
  (insert "\"\"")
  (backward-char)
)
(global-set-key "\M-\"" 'insert-balanced-quotes)

(setq-default ispell-program-name "aspell")
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   (quote
    ("e2a42f0ee660f30851428ab328de50d0739adf08f732a5cb7a73b1395fee24a5" default)))
 '(package-selected-packages (quote (yasnippet spinner company flycheck))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
