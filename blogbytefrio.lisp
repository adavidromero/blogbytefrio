;;;; blogbytefrio.lisp

(in-package #:blogbytefrio)

;;; "blogbytefrio" goes here. Hacks and glory await!

;;; Global variables
(defparameter *blog-title* "Byte Frio")
(defparameter *blog-subtitle* 
"Tecnología Desarrollo e investigación sobre Informática y Sistemas Informáticos")

(defparameter *posts* (list "post1" "post2"))

(define-route home ("")
  (list :blog-title *blog-title* :blog-subtitle *blog-subtitle*
	:content (add-posts *posts*)))

(define-route about ("about")
  (list :blog-title "about" :blog-subtitle *sub-title*
	:body (about-page)))

(define-route login ("login")
  (list :title "Log in"
	:body (login-form)))

(define-route login/post ("login" :method :post)
  (let ((user (auth-user (hunchentoot:post-parameter "username")
			 (hunchentoot:post-parameter "password"))))
  (if user
      (log-in user)
      (redirect 'login))))

(define-route register ("register")
  (list :blog-title *blog-title* :blog-subtitle *blog-subtitle*
	:content (register-form)))

(define-route register/post ("register" :method :post)
  (let ((user (register-user (hunchentoot:post-parameter "username")
			     (hunchentoot:post-parameter "password")))))
  (redirect 'register))
