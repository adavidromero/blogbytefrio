(defpackage #:blogbytefrio-config (:export #:*base-directory*))
(defparameter blogbytefrio-config:*base-directory* 
  (make-pathname :name nil :type nil :defaults *load-truename*))

(asdf:defsystem #:blogbytefrio
  :serial t
  :description "Your description here"
  :author "Your name here"
  :license "Your license here"
  :depends-on (:RESTAS :sexml :postmodern :ironclad
		       :babel :restas-directory-publisher)
  :components ((:file "defmodule")
	       (:file "pg-datastore")
	       (:file "util")
	       (:file "template")
               (:file "blogbytefrio")))
