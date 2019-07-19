(setq inhibit-splash-screen t)
(add-to-list 'custom-theme-load-path "~/.emacs.d/themes/")
(load-theme 'zenburn t)

;; For it to work in terminal mode, dark mode had to be forced
;(setq frame-background-mode 'dark)

;; Set up link to package sources and initialize
(require 'package)

;; add melpa stable
(add-to-list 'package-archives
         '("melpa-stable" . "https://stable.melpa.org/packages/"))
;; add melpa
(add-to-list 'package-archives
         '("melpa" . "http://melpa.milkbox.net/packages/"))

;; Initialize packages
(package-initialize)

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

;; Magit to incorporate and improve git-commands
(use-package magit
  :bind ("C-x g" . 'magit-status))

;; Flyckeck to verify code syntax
(use-package flycheck)
(add-hook 'after-init-hook #'global-flycheck-mode)

;; Company to help with auto-completion
(use-package company)
(add-hook 'after-init-hook #'global-company-mode)

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
;(global-set-key "\M-[" 'insert-balanced-brackets)

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
 '(package-selected-packages (quote (company flycheck))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
