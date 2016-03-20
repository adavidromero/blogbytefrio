;;;; pg-datastore.lisp

(in-package #:blogbytefrio.pg-datastore)

(defclass pg-datastore ()
  ((connection-spec :initarg :connection-spec
		    :accessor connection-spec)))

(defparameter *db* (make-instance 'pg-datastore
				  :connection-spec '("bfdb" "bfuser" "bfpass" "localhost")))

(defclass users ()
  ((id :col-type serial :reader user-id)
   (name :col-type string :reader user-name :initarg :name)
   (password :col-type string :reader user-password :initarg :password)
   (salt :col-type string :reader user-salt :initarg :salt))
  (:metaclass dao-class) 
  (:keys id))


(defclass posts ()
  ((id :col-type serial :reader post-id)
  (title :col-type string :reader post-title :initarg :post)
  (content :col-type string :reader post-content :initarg :content)
  (user-id :col-type integer :reader post-user-id :initarg :user-id))
  (:metaclass dao-class) 
  (:keys id))

(deftable posts 
  (!dao-def)
  (!foreign 'users 'user-id 'id))

;(defclass comments ())
;(defclass tag ())
;(defclass posttag ())

(defmethod datastore-init ((datastore pg-datastore))
  (with-connection (connection-spec datastore)
    (unless (table-exists-p 'users)
      (execute (dao-table-definition 'users)))
    (unless (table-exists-p 'posts)
      (execute (create-table 'posts)))
    ))
