(setq inhibit-splash-screen t)
(setq frame-background-mode 'dark)

(global-set-key (kbd "C-z")       'undo)
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
