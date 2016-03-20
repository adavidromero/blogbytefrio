(in-package #:blogbytefrio)
(<:augment-with-doctype "html" "" :auto-emit-p t)

(defun html-frame (context)
  (<:html :lang "es"
   (add-header (getf context :title)) 
   (<:body
    (add-sidebar context)
    (<:div
      (getf context :body)))))

(defun home-page ()
  (add-blog-entries))

(defun about-page ()
  (<:p "Bienvenido a un blog escrito en lisp y utilizando material design")
  (<:p "El siguiente es un parrafo lorem de prueba")
  (<:p "Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque laudantium, totam rem aperiam, eaque ipsa quae ab illo inventore veritatis et quasi architecto beatae vitae dicta sunt explicabo. Nemo enim ipsam voluptatem quia voluptas sit aspernatur aut odit aut fugit, sed quia consequuntur magni dolores eos qui ratione voluptatem sequi nesciunt. Neque porro quisquam est, qui dolorem ipsum quia dolor sit amet, consectetur, adipisci velit, sed quia non numquam eius modi tempora incidunt ut labore et dolore magnam aliquam quaerat voluptatem. Ut enim ad minima veniam, quis nostrum exercitationem ullam corporis suscipit laboriosam, nisi ut aliquid ex ea commodi consequatur? Quis autem vel eum iure reprehenderit qui in ea voluptate velit esse quam nihil molestiae consequatur, vel illum qui dolorem eum fugiat quo voluptas nulla pariatur?")
)

(defun add-header (title)
  (<:head
   (<:meta :name "viewport" :content "width=device-width, initial-scale=1.0")
   (<:meta :charset "UTF-8")
   (<:link :rel "stylesheet" :href "http://yui.yahooapis.com/pure/0.6.0/pure-min.css")
   (<:link :rel "stylesheet" :href "http://yui.yahooapis.com/pure/0.6.0/grids-responsive-min.css")
   (<:link :rel "stylesheet" :type "text/css" 
	   :href "/static/css/style.css")
   (<:link :rel "stylesheet" :href "/static/css/blog.css")
   (<:link :rel "stylesheet" :href "/static/css/blog-old-ie.css")
   (<:title title)))

(defun add-sidebar (context)
  (<:div :class "pure-g"
    (<:div :class "sidebar pure-ui-1 pure-u-md-1-4"
      (<:div :class "header"
	(<:a :href (genurl 'home)
          (<:h1 :class "brand-title" (getf context :title))
	  (<:h2 :class "brand-tagline" (getf context :sub-title)))))))

(defun add-blog-entries ()
  (<:div :class "content pure-u-1 pure-u-md-3-4" "Contenido Blog"))
