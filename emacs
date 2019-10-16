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
;;For gocode use https://github.com/mdempsky/gocode
; (use-package go-mode
;   :init
;   (setq gofmt-command "goimports"     ; use goimports instead of gofmt
;         go-fontify-function-calls nil ; fontifing names of called
;                                       ; functions is too much for me
;         company-idle-delay nil)	; avoid auto completion popup, use TAB
;                                 ; to show it
;   :bind
;   (:map go-mode-map
;         ("C-c d" . lsp-describe-thing-at-point)
;         ("C-c g" . godoc)
;         ("C-c P" . my-godoc-package)
;         ("{" . my-go-electric-brace)
;         ("C-i" . company-indent-or-complete-common)
;         ("C-M-i" . company-indent-or-complete-common)
;    )
;   :config
;   (require 'go-guru)
;   (add-hook 'go-mode-hook #'lsp)
;   (add-hook 'go-mode-hook #'smartparens-mode)
;   ;; run gofmt/goimports when saving the file
;   (add-hook 'before-save-hook #'gofmt-before-save))

(use-package go-mode)

(use-package lsp-mode
  :commands (lsp lsp-deferred))

(add-hook 'go-mode-hook #'lsp-deferred)

;; Provides fancier overlays
(use-package lsp-ui
  :commands lsp-ui-mode)

;; Use company-mode for completion (otherwise, complete-at-point works out of the box):
(use-package company-lsp
  :commands company-lsp)

; ;; Custom Compile Command
; (defun go-mode-setup ()
;   (linum-mode 1)
;   (go-eldoc-setup)
;   (setq gofmt-command "goimports")
;   (add-hook 'before-save-hook 'gofmt-before-save)
;   (local-set-key (kbd "M-.") 'godef-jump)
;   (setq compile-command "echo Building... && go build -v && echo Testing... && go test -v && echo Linter... && golint")
;   (setq compilation-read-command nil)
;   ;;  (define-key (current-local-map) "\C-c\C-c" 'compile)
;   (local-set-key (kbd "M-,") 'compile))
; (add-hook 'go-mode-hook 'go-mode-setup)

; ;;Load auto-complete
; (ac-config-default)
; (require 'auto-complete-config)
; (require 'go-autocomplete)

; ;;Go rename

; (require 'go-rename)

; ;;Configure golint
; (add-to-list 'load-path (concat (getenv "GOPATH")  "/src/github.com/golang/lint/misc/emacs"))
; (require 'golint)

; ;;Smaller compilation buffer
; (setq compilation-window-height 14)
; (defun my-compilation-hook ()
;   (when (not (get-buffer-window "*compilation*"))
;     (save-selected-window
;       (save-excursion
;         (let* ((w (split-window-vertically))
;                (h (window-height w)))
;           (select-window w)
;           (switch-to-buffer "*compilation*")
;           (shrink-window (- h compilation-window-height)))))))
; (add-hook 'compilation-mode-hook 'my-compilation-hook)

; ;;Other Key bindings
; (global-set-key (kbd "C-c C-c") 'comment-or-uncomment-region)

; ;;Compilation autoscroll
; (setq compilation-scroll-output t)

;; For starting emacs as a server
;(server-start)

;(global-set-key (kbd "C-z")       'undo)
(define-key global-map "\C-r"     'isearch-backward-regexp)
(define-key global-map "\C-s"     'isearch-forward-regexp)
(define-key global-map "\M-%"     'query-replace-regexp)
;(setq select-enable-primary t)
;(setq select-enable-clipboard nil)
;(setq mouse-drag-copy-region t)
;(setq select-enable-clipboard t)
;(setq interprogram-paste-function 'x-cut-buffer-or-selection-value)

(delete-selection-mode 1)

(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)

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

;; Make cursor stay at the end of the buffer
;; instead of adding newlines
(setq-default next-line-add-newlines nil
              indent-tabs-mode nil)

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
 '(package-selected-packages (quote (spinner company flycheck))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
