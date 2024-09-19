;; -*- lexical-binding: t; -*-

(find-definition-noselect 'find-function nil)

(defun type (symbol)
  (symbolp symbol))

(defun symbol-meta (symbol)
  (unless (symbolp symbol)
    (user-error "Need symbol"))
  (symbol-name symbol)
  (symbol-value symbol))

(setq global-predicates '())


(defun parse-obarray (value)
  (let ((name (symbol-name value)))
    (when (and (not (string-search "--" name))
               (if (string-search "-" name)
                   (string-suffix-p "-p" name)
                 (string-suffix-p "p" name)))
      (setq global-predicates (cons name global-predicates)))))

(mapatoms #'parse-obarray obarray)
(message "%s" global-predicates)
(message "%s" (safe-length global-predicates))

(symbolp (aref obarray 0))  ; 15121
(vectorp obarray)
(message "%d" obarray-count)  ; 114255

(typep obarray)

(defclass person () ; No superclasses
  ((name :initarg :name
         :initform ""
         :type string
         :custom string
         :documentation "The name of a person.")
   (birthday :initarg :birthday
             :initform "Jan 1, 1970"
             :custom string
             :type string
             :documentation "The person's birthday.")
   (phone :initarg :phone
          :initform ""
          :documentation "Phone number."))
  "A class for tracking people I know.")

(message "%s" (functionp person))

(fixnump 1)
(provide 'mypkg)
;;; mypkg.el ends here
