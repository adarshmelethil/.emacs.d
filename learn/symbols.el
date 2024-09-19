;;; symbols.el All things symbols -*- lexical-binding: t; -*-
;;
;; Copyright (C) 2024 Adarsh Melethil
;;
;; Author: Adarsh Melethil <adarshmelethil@gmail.com>
;; Maintainer: Adarsh Melethil <adarshmelethil@gmail.com>
;; Created: September 17, 2024
;; Modified: September 17, 2024
;; Version: 0.0.1
;; Keywords: abbrev bib c calendar comm convenience data docs emulations extensions faces files frames games hardware help hypermedia i18n internal languages lisp local maint mail matching mouse multimedia news outlines processes terminals tex text tools unix vc wp
;; Homepage: https://github.com/adarsh.melethil/symbols
;; Package-Requires: ((emacs "24.3"))
;;
;; This file is not part of GNU Emacs.
;;
;;; Commentary:
;;
;;
;;
;;; Code:


;; 1) Print name (immutable): The symbol’s name.
;;    `symbol-name'
;;
;; To define shorthands set local variable `read-symbol-shorthands':
;; -*- mode: modename; read-symbol-shorthands: (("snu-" . "some-nice-string-utils-")); … -*-
;; OR
;; Local Variables:
;; read-symbol-shorthands: (("snu-" . "some-nice-string-utils-"))
;; End:
;;
;; 2) Value: The symbol’s current value as a variable.
;;   `boundp'
;;   `symbol-value', `set', `makunbound': get/set/del value cell's object
;;   `setq' ('q' means quoted)
;;
;; 3) Function: The symbol’s function definition. It can also hold a symbol, a keymap, or a keyboard macro.
;;   `fboundp': function cell has object
;;   `symbol-function', `fset', `fmakunbound': get/set/del function cell's object
;;   `indirect-function': recursivly follow symbol in function cell till a function is found
;;   `defun', `defalias' (prop `defalias-fset-function' > `fset'), `function-alias-p'
;;   `subrp': is function primative e.g. '(subrp (symbol-function 'car))'
;;
;; Symbol Function Indirection: the func cell's value is another symbol.
;;
;; 4) Property list: The symbol’s property list.

;; `keywordp'
;;
;; `defvar':
;;   - initalizes only if void
;;   - buffer-local binding sets global value if void
;; `defconst': unconditionally initializes the variable
;; `defcustom': `setopt'
;;
;;
;; `{get/add/remove}-variable-watcher'
;;   `debug-on-variable-change', `cancel-debug-on-variable-change'


(provide 'symbols)
;;; symbols.el ends here
