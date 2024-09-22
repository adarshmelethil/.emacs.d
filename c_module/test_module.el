#!/usr/bin/env emacs --script
;; -*- mode: emacs-lisp; lexical-binding: t; -*-

(defconst script-dir (file-name-directory load-file-name))
(defconst libs-dir (expand-file-name "libs" script-dir))

(defun load-module-file (module-name)
  (let ((module-filename (format "%s.so" module-name))
        (module-path (expand-file-name module-filename libs-dir)))
    (message "Loading module file '%s'." module-path)
    (module-load module-path)))

(defun add-lib-path ()
  (when (not (memq libs-dir load-path))
    (message "Adding '%s' to 'load-path" libs-dir)
    (add-to-list 'load-path libs-dir)))

(defun require-module (module-name)
  (add-lib-path)
  (message "Requiring module %s" module-name)
  (require module-name))


(defun main ()
  (message "libs: %s" libs-dir)
  (require-module 'embededpython))

(when (member "-scriptload" command-line-args)
  (main))
