;;; init.el --- Init-File -*- lexical-binding: t; -*-
;;
;; Copyright (C) 2022 Adarsh Melethil
;;
;; Author: Adarsh Melethil <adarshmelethil@gmail.com>
;; Maintainer: Adarsh Melethil <adarshmelethil@gmail.com>
;; Created: June 12, 2022
;; Modified: June 12, 2022
;; Version: 0.0.1
;; Keywords: abbrev bib c calendar comm convenience data docs emulations extensions faces files frames games hardware help hypermedia i18n internal languages lisp local maint mail matching mouse multimedia news outlines processes terminals tex tools unix vc wp
;; Homepage: https://github.com/adarshmelethil/init
;; Package-Requires: ((emacs "24.3"))
;;
;; This file is not part of GNU Emacs.
;;
;;; Commentary:
;;
;;  Init-File
;;
;;; Code:
(require 'org)

(defconst
  personal-emacs-config-dir
  (file-name-directory (directory-file-name (or load-file-name (buffer-file-name))))
  "The config directory.")

(org-babel-load-file
 (expand-file-name
  "emacs-config.org"
  personal-emacs-config-dir))

;;; init.el ends here
