(in-package #:blogbytefrio)
(<:augment-with-doctype "html" "" :auto-emit-p t)

(defun html-frame (context)
  (<:html :lang "es"
   (add-header (getf context :blog-title))
   (<:body
    (<:div :class "pure-g" :id "layout"
    (add-sidebar context)
    (add-main-content (getf context :content))))))

(defun about-page ()
  (<:p "Bienvenido a un blog escrito en lisp y utilizando material design")
  (<:p "El siguiente es un parrafo lorem de prueba"))

(defun add-header (title)
  (<:head
   (<:meta :charset "utf-8")
   (<:meta :name "viewport" :content "width=device-width, initial-scale=1.0")
   (<:link :rel "stylesheet" :href "http://yui.yahooapis.com/pure/0.6.0/pure-min.css")
   (<:link :rel "stylesheet" :href "http://yui.yahooapis.com/pure/0.6.0/grids-responsive-min.css")
   (<:link :rel "stylesheet" :type "text/css" 
	   :href "/static/css/style.css")
   (<:link :rel "stylesheet" :href "/static/css/blog.css")
;   (<:link :rel "stylesheet" :href "/static/css/blog-old-ie.css")
   (<:title title)))

(defun add-sidebar (context)
    (<:div :class "sidebar pure-u-1 pure-u-md-1-4"
      (<:div :class "header"
	(<:a :href (genurl 'home)
          (<:h1 :class "brand-title" (getf context :blog-title))
	  (<:h2 :class "brand-tagline" (getf context :blog-subtitle))))))

(defun add-main-content (content)
    (<:div :class "content pure-u-1 pure-u-md-3-4" 
      (<:div content
        (<:div :class "footer" (make-footer) ))))

(defun make-footer ()
  (<:div :class "footer" "David Romero 2016 - Todos los Derechos reservados"))

(defun add-posts (posts-with-users)
  (<:div :class "posts"
    (<:h1 :class "content-subhead" "Entradas Recientes")
    (loop
       for post-with-user in posts-with-users
	 collect (add-post-excerpt post-with-user))
    ))

(defun add-post-excerpt(post-with-user)
    (<:section :class "posts"
      (<:header :class "post-header"
      (<:img :class "post-avatar" :alt "Avatar Image" :height "48" :width "48"
        :src "")
      (<:h2 :class "post-title" (getf post-with-user :title))
      (<:p :class "post-meta" (concatenate 'string 
				"Por "
			        (<:a :href "#" "David Romero") 
				" en "
				(<:a :href "#" "blogging"))
       (<:div :class "post-description" 
         (<:p (getf post-with-user :content)) 
	      )))
  ))

(defun login-form ()
  (<:form :class "pure-form pure-form-stacked" :action (genurl 'login/post) :method "post"
	  (<:fieldset
	    (<:legend "Login")
	    (<:label :for "username" "User name:")
	    (<:input :id "username" :name "username" :type "text" :placeholder "Username")
	    (<:label :for "password" "Password:")
	    (<:input :id "password" :name "password" :type "password" :placeholder "Password")
	    (<:button :type "submit" :class "pure-button pure-button-primary" "Register"))))

(defun register-form ()
  (<:form :class "pure-form pure-form-stacked" :action (genurl 'register/post) :method "post"
	  (<:fieldset
	    (<:legend "User Registry")
	    (<:label :for "username" "User name:")
	    (<:input :id "username" :name "username" :type "text" :placeholder "Username")
	    (<:label :for "password" "Password:")
	    (<:input :id "password" :name "password" :type "password" :placeholder "Password")
	    (<:button :type "submit" :class "pure-button pure-button-primary" "Register"))))

(defun post-new-form ()
  (<:form :class "pure-form pure-form-stacked" :method "post"
    (<:fieldset
      (<:legend "User Registry")
      (<:label :for "title" "Post Title")
      (<:input :id "title" :name "title" :type "text" :placeholder "Post Title")
      (<:label :for "post-content" "Content")
      (<:textarea :id "content" :name "content" :placeholder "Broadcast your thoughts")
      (<:button :type "submit" :class "pure-button pure-button-primary" "Guardar"))))

