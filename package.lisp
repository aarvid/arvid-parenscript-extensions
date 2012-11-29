;;;; package.lisp
(in-package :cl)

(defpackage #:arvid-parenscript-extensions
  (:nicknames :ps-ext)
  (:use #:common-lisp
        #:parenscript)
  (:export
   pchain
   fchain
   fpchain
   slot-setf
   ps-inline-return
   ps-inline-return*))
