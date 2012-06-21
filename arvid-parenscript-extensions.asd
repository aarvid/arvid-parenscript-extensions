;;;; smackwrepl.asd

(asdf:defsystem #:arvid-parenscript-extensions
  :serial t
  :depends-on (#:parenscript)
  :components ((:file "package")
               (:file "utils")))
