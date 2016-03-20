;;;; blogbytefrio.lisp

(in-package #:blogbytefrio)

;;; "blogbytefrio" goes here. Hacks and glory await!

(define-route home ("")
  (list :title "Byte Frio"
	:body (home-page)))

(define-route about ("about")
  (list :title "about"
	:body (about-page)))
