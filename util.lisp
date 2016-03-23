(in-package #:blogbytefrio)

(defun log-in (username &optional (redirect-route 'home))
  (hunchentoot:reset-session-secret)
  (hunchentoot:start-session)
  (setf (hunchentoot:session-value :username) username)
  (redirect redirect-route))

(defun log-out (&optional (redirect-route 'home))
  (setf (hunchentoot:session-value :username) nil)
  (redirect redirect-route))

(defun logged-on-p ()
  (hunchentoot:session-value :username))

(defun start-blogbytefrio (&key (port 8080)
			     (datastore 'blogbytefrio.pg-datastore:pg-datastore)
			     (datastore-init nil))
  (setf *datastore* (apply #'make-instance datastore datastore-init))
  (init)
  (start '#:blogbytefrio :port port :render-method 'html-frame))

