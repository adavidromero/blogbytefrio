(in-package #:blogbytefrio)
(<:augment-with-doctype "html" "" :auto-emit-p t)

(defun html-frame (context)
  (<:html
   (<:head 
    (<:meta :charset "UTF-8")
    (<:link :rel "stylesheet" :type "text/css" :href "/static/css/style.css")
    (<:title (getf context :title)))
   (<:body
    (<:div
     (<:h1 (getf context :title))
     (<:a :href (genurl 'home) "Inicio") 
     (getf context :body)))))

(defun home-page ()
  (<:p "Benvenue avec mon chateau"))

