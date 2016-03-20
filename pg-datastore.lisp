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

(defmethod datastore-init ((datastore pg-datastore))
  (with-connection (connection-spec datastore)
    (unless (table-exists-p 'users)
      (execute (dao-table-definition 'users)))))
