;;;; defmodule.lisp

(restas:define-policy datastore
  (:interface-package #:blogbytefrio.policy.datastore)
  (:interface-method-template "DATASTORE-~a")
  (:internal-package #:blogbytefrio.datastore)
  (:internal-function-template "~A")

  (define-method init ()
    "Initialize the datastore")

;  (define-method find-user (username)
 ;   "Find the user by username")
  
  ;(define-method auth-user (username password)
   ; "Check if user exists and has supplied password")
  
 (define-method register-user (username password)
   "Register a new user")
)

(restas:define-module #:blogbytefrio
  (:use #:cl #:restas #:blogbytefrio.datastore))

(defpackage #:blogbytefrio.pg-datastore
  (:use #:cl #:postmodern #:blogbytefrio.policy.datastore)
  (:export #:pg-datastore))

(in-package #:blogbytefrio)

(defparameter *template-directory*
  (merge-pathnames #P"templates/" blogbytefrio-config:*base-directory*))

(defparameter *static-directory*
  (merge-pathnames #P"static/" blogbytefrio-config:*base-directory*))


(defparameter hunchentoot:*catch-errors-p* t)
(defparameter hunchentoot:*show-lisp-errors-p* t)
(defparameter hunchentoot:*show-lisp-backtraces-p* t)

(sexml:with-compiletime-active-layers
    (sexml:standard-sexml sexml:xml-doctype)
  (sexml:support-dtd
   (merge-pathnames "html5.dtd" (asdf:system-source-directory "sexml"))
   :<))


(mount-module -static- (#:restas.directory-publisher)
  (:url "static")
  (restas.directory-publisher:*directory* *static-directory*))
