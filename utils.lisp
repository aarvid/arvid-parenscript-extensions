(in-package :arvid-parenscript-extensions)

(defun ps-inline-return* (form &optional
                   (ps:*js-string-delimiter* ps:*js-inline-string-delimiter*))
  (concatenate 'string "javascript:return " (ps:ps* form)))

(defmacro+ps ps-inline-return (form &optional
                             (string-delimiter *js-inline-string-delimiter*))
  `(concatenate 'string "javascript:return "
                ,@(let ((ps:*js-string-delimiter* string-delimiter))
                    (ps::parenscript-print (ps::compile-statement form) nil))))

