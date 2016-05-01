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
  (title :col-type string :reader post-title :initarg :title)
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


(defun hash-password (password)
  (multiple-value-bind (hash salt)
      (ironclad:pbkdf2-hash-password (babel:string-to-octets password))
    (list :password-hash (ironclad:byte-array-to-hex-string hash)
	  :salt (ironclad:byte-array-to-hex-string salt))))

(defun check-password (password password-hash salt)
   (let ((hash (ironclad:pbkdf2-hash-password
                (babel:string-to-octets password)
                :salt (ironclad:hex-string-to-byte-array salt))))
     (string= (ironclad:byte-array-to-hex-string hash)
              password-hash)))


(defmethod datastore-find-user ((datastore pg-datastore) username)
  (with-connection (connection-spec datastore)
    (query (:select :* :from 'users
		    :where (:= 'name username))
	   :plist)))

(defmethod datastore-auth-user ((datastore pg-datastore) username password)
  (let ((user (datastore-find-user datastore username)))
    (when (and user
	       (check-password password (getf user :password)
			       (getf user :salt)))
      username)))


(defmethod datastore-register-user ((datastore pg-datastore) username password)
  (with-connection (connection-spec datastore)
    (unless (datastore-find-user datastore username)
      (let ((password-salt (hash-password password)))
	(when 
	    (save-dao
	     (make-instance 'users
			    :name username
			    :password (getf password-salt :password-hash)
			    :salt (getf password-salt :salt)))
	  username)))))

(defmethod datastore-save-post-new ((datastore pg-datastore) username title content)
  (with-connection (connection-spec datastore)
  (let ((user (datastore-find-user datastore username)))
    (when
	(save-dao
	 (make-instance 'posts
			:title title
			:content content
			:user-id (getf user :id)))
      ))))

(defmethod datastore-get-posts-with-users ((datastore pg-datastore) offset num-posts order)
  (with-connection (connection-spec datastore)
    (query (:select :* :from 'posts) 
	   :plists)))

(defmethod datastore-init ((datastore pg-datastore))
  (with-connection (connection-spec datastore)
    (unless (table-exists-p 'users)
      (execute (dao-table-definition 'users))
      ) 
    (unless (table-exists-p 'posts)
      (execute (create-table 'posts)))
    (datastore-register-user datastore "David Romero" "contraseña")))
