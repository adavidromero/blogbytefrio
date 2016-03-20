;;;; blogbytefrio.lisp

(in-package #:blogbytefrio)

;;; "blogbytefrio" goes here. Hacks and glory await!
(defparameter *title* "Byte Frio")
(defparameter *sub-title* 
"Tecnología Desarrollo e investigación sobre Informática y Sistemas Informáticos")
(define-route home ("")
  (list :title *title*
	:sub-title *sub-title*
	:body (home-page)))

(define-route about ("about")
  (list :title "about"
	:sub-title *sub-title*
	:body (about-page)))
