;;;; blogbytefrio.lisp

(in-package #:blogbytefrio)

;;; "blogbytefrio" goes here. Hacks and glory await!

(define-route home ("")
  (list :title "Linkdemo"
	:body (home-page)))
