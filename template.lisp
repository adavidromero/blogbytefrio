(in-package #:blogbytefrio)
(<:augment-with-doctype "html" "" :auto-emit-p t)

(defun html-frame (context)
  (<:html
   (<:head 
    (<:meta :charset "UTF-8")
    ;;Utilizaremos diseño material para el blog
  
    (<:title (getf context :title)))
   (<:body
    (<:div
     (<:h1 (getf context :title))
     (<:a :href (genurl 'home) "Inicio") 
     (getf context :body)))))

(defun home-page ()
  (<:p "Benvenue avec mon chateau"))

(defun about-page ()
  (<:p "Bienvenido a un blog escrito en lisp y utilizando material design")
  (<:p "El siguiente es un parrafo lorem de prueba")
  (<:p "Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque laudantium, totam rem aperiam, eaque ipsa quae ab illo inventore veritatis et quasi architecto beatae vitae dicta sunt explicabo. Nemo enim ipsam voluptatem quia voluptas sit aspernatur aut odit aut fugit, sed quia consequuntur magni dolores eos qui ratione voluptatem sequi nesciunt. Neque porro quisquam est, qui dolorem ipsum quia dolor sit amet, consectetur, adipisci velit, sed quia non numquam eius modi tempora incidunt ut labore et dolore magnam aliquam quaerat voluptatem. Ut enim ad minima veniam, quis nostrum exercitationem ullam corporis suscipit laboriosam, nisi ut aliquid ex ea commodi consequatur? Quis autem vel eum iure reprehenderit qui in ea voluptate velit esse quam nihil molestiae consequatur, vel illum qui dolorem eum fugiat quo voluptas nulla pariatur?")
)

(defun style-sheets-fragments
  (<:link :rel "stylesheet" :type "text/css" :href "https://fonts.googleapis.com/icon?family=Material+Icons")
    (<:link :rel "stylesheet" :type "text/css" :href "https://code.getmdl.io/1.1.3/material.indigo-deep_purple.min.css")
    (<:link :rel "stylesheet" :type "text/css" :href "/static/css/style.css")
    )
