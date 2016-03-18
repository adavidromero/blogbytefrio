;;;; defmodule.lisp

(restas:define-policy datastore
    (:interface-package #:blogbytefrio.policy.datastore)
  (:interface-method-template "DATASTORE-~a")
  (:internal-package #:linkdemo.datastore)
  (:internal-function-template "~A")

  (define-method init ()
    "Initialize the datastore")

  (define-method find-user (username)
    "Find the user by username")
  
  (define-method auth-user (username password)
    "Check if user exists and has supplied password")
  
  (define-method register-user (username password)
    "Register a new user"))


(restas:define-module #:blogbytefrio
  (:use #:cl #:restas #:blogbytefrio.datastore))

(in-package #:blogbytefrio)

(defparameter *template-directory*
  (merge-pathnames #P"templates/" blogbytefrio-config:*base-directory*))

(defparameter *static-directory*
  (merge-pathnames #P"static/" blogbytefrio-config:*base-directory*))


