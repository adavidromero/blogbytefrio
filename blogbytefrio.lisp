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
	:content (add-posts (get-posts-with-users "" "" ""))))


(define-route login ("login")
  (list :blog-title *blog-title* :blog-subtitle *blog-subtitle*
	:content (login-form)))

(define-route login/post ("login" :method :post)
  (let ((user (auth-user (hunchentoot:post-parameter "username")
			 (hunchentoot:post-parameter "password"))))
  (if user
      (log-in user)
      (redirect 'login))))

(define-route logout ("logout")
  (log-out))

(define-route register ("register")
  (if (logged-on-p)
    (list :blog-title *blog-title* :blog-subtitle *blog-subtitle*
	  :content (register-form))
    (redirect 'login)))
  
(define-route register/post ("register" :method :post)
  (if (logged-on-p)
       (let ((user (register-user (hunchentoot:post-parameter "username")
				(hunchentoot:post-parameter "password"))))
       (redirect 'register))
      (redirect 'login)))


;;;; ok, so our small blogging software is growing which means we need 
;;;; some order, so let's split the routes by modules

;;;; Blog Admin Interface
;;;; Add a new post

(define-route post-new ("post-new")
  (if (logged-on-p)
      (list :blog-title *blog-title* :blog-subtitle *blog-subtitle*
	    :content (post-new-form))
      (redirect 'login)))

(define-route post-new/post ("post-new" :method :post)
  (if (logged-on-p)
      (when (not (save-post-new (hunchentoot:session-value :username)
		      (hunchentoot:post-parameter "title")
		      (hunchentoot:post-parameter "content")))
       (redirect 'home))
      (redirect 'login)))


