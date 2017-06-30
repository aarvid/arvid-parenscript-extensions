(in-package :arvid-parenscript-extensions)

(defun ps-inline-return* (form &optional
                   (ps:*js-string-delimiter* ps:*js-inline-string-delimiter*))
  (concatenate 'string "javascript:return " (ps:ps* form)))

(defmacro+ps ps-inline-return (form &optional
                             (string-delimiter *js-inline-string-delimiter*))
  `(concatenate 'string "javascript:return "
                ,@(let ((ps:*js-string-delimiter* string-delimiter))
                    (ps::parenscript-print (ps::compile-statement form) nil))))



(defpsmacro aif (test then &optional else)
  `(let ((it ,test))
     (if it ,then ,else)))

(defpsmacro awhen (test &rest body)
  `(let ((it ,test))
     (when it ,@body)))


(ps:import-macros-from-lisp
   'alexandria:when-let
   'alexandria:when-let*
   'alexandria:if-let)

;; dont call pchain within an init-form of a let:
;;(ps (let ((x (let ((y (a))) 
;;	       (progn (b) y))))
;;      (1+ x)))
;;==>
;;"(function () {
;;    var y;
;;    var x = (y = a(), (b(), y));
;;    return x + 1;
;;})();"
 
(defpsmacro pchain (object &rest chains)
  "generate pseudo-chain of method calls of object. use in imperative code only.
for use of js prototypes that do not allow chaining like j-query."
  (ps-once-only (object)
    `(progn
       ,@(mapcar (lambda (x) `(chain ,object ,x))
                chains))))

;;  should be called something like with-object-chain or with-prototype-chain
;;  but this name allows use similar to ps:chain.
(defpsmacro fchain (object &rest chains)
  "generate a pseudo-chain of method calls of given object
and return the object. for use of js prototypes that do not
allow chaining like j-query."
  (with-ps-gensyms (obj)
    `(funcall (lambda (,obj)
                ,@(mapcar (lambda (x) `(chain ,obj ,x))
                         chains)
                ,obj)
              ,object)))


(defpsmacro fpchain (object &rest chains)
  "generate a pseudo-chain of method calls of given object
and return the object. for use of js prototypes that do not
allow chaining like j-query.
Deprecated use fchain."
  (ps-once-only (object)
    (append '(progn)
            (mapcar (lambda (x) `(chain ,object ,x))
                    chains)
            `(,object))))




;; may be should be named with-object-setf
(defpsmacro slot-setf (object &rest slot-pairs)
  "setf several slot-value pairs of the same object"
  (ps-once-only (object)
    `(setf ,@(mapcan (lambda (x) `((@ ,object ,(car x))
                                     ,(cdr x)))
                    (alexandria:plist-alist slot-pairs)))))
