(in-package #:linkdemo)



(defun start-blogbytefrio (&key (port 8080)
			 (datastore 'blogbytefrio.pg-datastore:pg-datastore)
			 (datastore-init nil))
  (setf *datastore* (apply #'make-instance datastore datastore-init))
  (init)
  (start '#:linkdemo :port port :render-method 'html-frame))

