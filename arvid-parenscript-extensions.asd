;;;; smackwrepl.asd

(asdf:defsystem "arvid-parenscript-extensions"
  :serial t
  :depends-on ("parenscript" "alexandria" )
  :components ((:file "package")
               (:file "utils")))
