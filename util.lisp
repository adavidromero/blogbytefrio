(in-package #:blogbytefrio)

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

(defun start-blogbytefrio (&key (port 8080)
			     (datastore 'blogbytefrio.pg-datastore:pg-datastore)
			     (datastore-init nil))
  (setf *datastore* (apply #'make-instance datastore datastore-init))
  (init)
  (start '#:blogbytefrio :port port :render-method 'html-frame))

