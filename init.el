                                        ; -*- lexical-binding: t; -*-
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
                                        ;              Bootstrap              ;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(setq package-enable-at-startup nil)
(defconst emacs-config-dir
  (file-name-directory
   (directory-file-name
    (or load-file-name (buffer-file-name))))
  "The config directory.")

(defconst bootstrap-version 5)
(setq straight-repository-branch "develop"
      straight-use-package-by-default t
      straight-base-dir emacs-config-dir)
(let ((bootstrap-file
       (expand-file-name "straight/repos/straight.el/bootstrap.el" straight-base-dir)))
  (unless (file-exists-p bootstrap-file)
    (with-current-buffer
        (url-retrieve-synchronously "https://raw.githubusercontent.com/raxod502/straight.el/develop/install.el" 'silent 'inhibit-cookies)
      (goto-char (point-max))
      (eval-print-last-sexp)))
  (load bootstrap-file nil 'nomessage))

(straight-use-package 'use-package)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
                                        ;               Settings              ;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(setq user-full-name "Adarsh Melethil"
      user-mail-address "adarshmelethil@gmail.com"
      ;; Startup
      inhibit-startup-screen t
      inhibit-startup-echo-area-message "adarshmelethil"
      initial-scratch-message ""
      initial-buffer-choice #'messages-buffer
      ;; Line numbers
      display-line-numbers-major-tick 0
      global-display-line-numbers-mode 'visual
      display-line-numbers-type 'visual
      display-line-numbers 'visual
      column-number-mode t
      ;; Parens
      show-paren-style 'mixed

      ;; General
      switch-to-buffer-in-dedicated-window 'pop

      work-dir (expand-file-name "~/work")
      org-dir (expand-file-name "org" work-dir)
      script-dir (expand-file-name "script" work-dir)
      bin-dir (expand-file-name "bin" work-dir)
      src-dir (expand-file-name "src" work-dir)
      conda-root-dir (expand-file-name "~/miniforge3"))

(set-frame-font (font-spec
                 :family
                 "ProggyCleanTT Nerd Font Mono"
                 :size 24 :weight 'light))

(add-to-list 'default-frame-alist '(fullscreen . maximized))

(when (and (featurep 'native-compile) (not (native-comp-available-p)))
  (delq 'native-compile features))

(when (bound-and-true-p module-file-suffix)
  (push 'dynamic-modules features))

(when (fboundp #'json-parse-string)
  (push 'jansson features))

(when (eq system-type 'darwin)
  (customize-set-variable 'native-comp-driver-options '("-Wl,-w")))

;; https://github.com/daviwil/emacs-from-scratch
(defun efs/display-startup-time ()
  (message "Emacs loaded in %s with %d garbage collections."
           (format "%.2f seconds"
                   (float-time (time-subtract after-init-time before-init-time)))
           gcs-done))
(add-hook 'emacs-startup-hook #'efs/display-startup-time)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
                                        ;               Packages              ;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

                                        ; Core
(setq edebug-all-defs t)
(use-package magit)
(use-package evil
  :demand t
  :preface
  (setq
   evil-want-C-g-bindings t
   evil-want-C-u-scroll t    ;; [normal] scroll/prefix-args
   evil-want-C-d-scroll t
   evil-want-C-u-delete t    ;; [insert] 'c^' in insert mode/prefix-args
   evil-want-C-w-delete t    ;; [insert] 'diw' in insert mode
   evil-want-Y-yank-to-eol t ;; [normal] y$ / yy
   evil-undo-system 'undo-tree
   evil-default-cursor (lambda () (put 'cursor 'evil-normal-color (face-background 'cursor)))
   evil-normal-state-cursor 'box
   evil-insert-state-cursor 'bar
   evil-visual-state-cursor 'hollow
   evil-emacs-state-cursor  '(box (lambda () (put 'cursor 'evil-emacs-color  (face-foreground 'warning))))
   ;; == DOOM ==
   ;; Only do highlighting in selected window so that Emacs has less work
   ;; to do highlighting them all.
   evil-ex-interactive-search-highlight 'selected-window
   ;; == DOOM ==
   ;; It's infuriating that innocuous "beginning of line" or "end of line"
   ;; errors will abort macros, so suppress them:
   evil-kbd-macro-suppress-motion-error t
   evil-regexp-search t)
  :demand t
  :config (evil-select-search-module 'evil-search-module 'evil-search)  ;; evil-search OR isearch
  ;; == DOOM ==
  ;; Ensure `evil-shift-width' always matches `tab-width'; evil does not police
  ;; this itself, so we must.
  (setq-hook! 'after-change-major-mode-hook evil-shift-width tab-width))

;; (use-package evil-args)
;; (use-package! evil-easymotion
;;   :commands evilem-create evilem-default-keybindings)
;; ;; (use-package evil-embrace)
;; ;; (use-package evil-quick-diff)
;; ;; (use-package evil-escape)
;; (use-package evil-escape)
;; (use-package evil-traces
;;   :config
;;   (evil-traces-use-diff-faces) ; if you want to use diff's faces
;;   (evil-traces-mode))
;; (use-package evil-exchange)
;; (use-package evil-indent-plus)
;; (use-package evil-surround)
;; (use-package evil-lion) ;; 'gl' align to char
;; (use-package evil-nerd-commenter)
;; (use-package evil-visualstar)  ;; #/* to search backward/forward


;; (use-package evil-collection
;;   :config (evil-collection-init))
;; ;; (use-package evil-easymotion)

;;                                         ; Coding
;; (use-package dash)  ; -map

;;                                         ; Display
;; (use-package eros)  ; Evaluation Result OverlayS for Emacs Lisp.

;;                                         ; Editor
;; (use-package undo-tree
;;   :config
;;   (setq undo-tree-visualizer-diff t
;;         undo-tree-auto-save-history t
;;         undo-tree-enable-undo-in-region t
;;         ;; Increase undo limits to avoid emacs prematurely truncating the undo
;;         ;; history and corrupting the tree. This is larger than the undo-fu
;;         ;; defaults because undo-tree trees consume exponentially more space,
;;         ;; and then some when `undo-tree-enable-undo-in-region' is involved. See
;;         ;; syl20bnr/spacemacs#12110
;;         undo-limit 800000           ; 800kb (default is 160kb)
;;         undo-strong-limit 12000000  ; 12mb  (default is 240kb)
;;         undo-outer-limit 128000000)
;;   )


;; ;; Key bindings

;; (use-package exato
;;   ;; 'x' for xml obj
;;   )


;; ;; (package-activate-all)
