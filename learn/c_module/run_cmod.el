#!/usr/bin/env emacs --script
;; -*- mode: emacs-lisp; lexical-binding: t; -*-

(defconst script-dir (file-name-directory load-file-name))

(defun main ()
  (let ((libs-dir (expand-file-name "libs" script-dir)))
    (message "libs: %s" libs-dir)
    (message "%s" module-file-suffix)

    ;; Loading module my filename
    ;; (module-load (expand-file-name "mymod.so" libs-dir))

    (add-to-list 'load-path libs-dir)
    (require 'mymod)
    ))

(when (member "-scriptload" command-line-args)
  (main))

