;;; -*- lexical-binding: t; -*-

(defmacro cmd (&rest body)
  `(lambda ()
     (interactive)
     ,@body))

(setq user-full-name "Adarsh Melethil"
      user-mail-address "adarshmelethil@gmail.com")

(setq inhibit-startup-screen t
      inhibit-startup-echo-area-message "adarshmelethil"
      initial-scratch-message "Adarsh's Emacs"
      ;; Line numbers
      display-line-numbers-major-tick 0
      global-display-line-numbers-mode 'visual
      display-line-numbers-type 'visual
      display-line-numbers 'visual
      column-number-mode t
      ;; Parens
      show-paren-style 'mixed
      ;; doom-font (font-spec :family "Red Hat Mono" :size 12)
      )
(add-to-list 'initial-frame-alist '(fullscreen . maximized))

(setq
 work-dir (concat (file-name-as-directory (getenv "HOME")) "work")
 org-dir (concat (file-name-as-directory work-dir) "org")
 src-dir (concat (file-name-as-directory work-dir) "src")
 scripts-dir (concat (file-name-as-directory work-dir) "scripts")
 bin-dir (concat (file-name-as-directory work-dir) "bin")
 conda-root-dir (concat (file-name-as-directory (getenv "HOME")) "miniforge3"))

(defconst bootstrap-version 5)
(setq straight-repository-branch "develop"
      straight-use-package-by-default t
      straight-base-dir personal-emacs-config-dir)

(let ((bootstrap-file
       (expand-file-name "straight/repos/straight.el/bootstrap.el" straight-base-dir)))
  (unless (file-exists-p bootstrap-file)
    (with-current-buffer
        (url-retrieve-synchronously
         "https://raw.githubusercontent.com/raxod502/straight.el/develop/install.el"
         'silent 'inhibit-cookies)
      (goto-char (point-max))
      (eval-print-last-sexp)))
  (load bootstrap-file nil 'nomessage))

(straight-use-package 'use-package)

(use-package cyberpunk
  :no-require t
  :ensure t
  :straight '(cyberpunk
              :type git
              :host github
              :repo "n3mo/cyberpunk-theme.el")
  :init (load-theme 'cyberpunk t))

(use-package s)

(use-package ht)

(use-package f)

(use-package signal)
(use-package deferred)

(use-package tree-sitter
  :config
  (global-tree-sitter-mode))
(use-package tree-sitter-langs)
(use-package moldable-emacs
  :straight '(moldable-emacs
              :type git
              :host github
              :repo "ag91/moldable-emacs"))

(use-package dash)

(use-package anaphora)

(use-package svg-lib)

(use-package discover
  :ensure t
  :init (global-discover-mode 1))

(use-package which-key
  :ensure t
  :init
  (which-key-mode 1)
  :config
  (which-key-setup-side-window-right-bottom))

(use-package evil
  :config (evil-mode 1))

(use-package general
  :after (dash)
  :config
  (general-create-definer spc-leader-def :prefix "SPC")
  (general-def 'normal
   "<up>" #'evil-window-up
   "<down>" #'evil-window-down
   "<right>" #'evil-window-right
   "<left>" #'evil-window-left)
  (spc-leader-def 'normal
   "<up>" #'split-window-vertically
   "<down>" (cmd (split-window-vertically) (evil-window-down 1))
   "<right>" (cmd (split-window-horizontally) (evil-window-right 1))
   "<left>" #'split-window-horizontally))

(use-package undo-tree
  :config (global-undo-tree-mode))

(use-package goto-chg)

(use-package ivy :config (ivy-mode))
(use-package counsel :after ivy :config (counsel-mode))
(use-package swiper :after ivy
  :commands swiper
  :config
  (setq ivy-use-selectable-prompt t
        search-default-mode #'char-fold-to-regexp)
  :general
  (spc-leader-def 'normal "b f" #'swiper))

(use-package magit :ensure t)

(use-package projectile :ensure t
  :init (projectile-mode +1)
  :bind-keymap ("C-x p" . projectile-command-map)
  ;; (:prefix-command projectile-mode-map "SPC p")
  )

(use-package perspective)
(use-package persp-projectile
  :after (perspective projectile))

(require 'f)
(use-package svg-tag-tags
  :after svg-lib
  :straight '(svg-tag-tags
              :type git
              :host github
              :repo "rougier/svg-tag-mode")
  ;; :custom
  ;; (svg-tag-tags
  ;;  '((":TODO:" . ((lambda (tag) (svg-tag-make "TODO"))))))
  )

(require 'deferred)

(deferred:$
  (deferred:process "which" "python")
  (deferred:nextc it
    (lambda (x) (message "%s" x))))
