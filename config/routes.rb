ActionController::Routing::Routes.draw do |map|
  map.resources :admins

  map.root :controller => 'about'

  map.resource :user_sessions, :as => 'sesion'
  map.login "/entrar", :controller => "user_sessions", :action => "new"
  map.logout "/salir", :controller => "user_sessions", :action => "destroy"

  map.about '/', :controller => 'about', :action => 'index'
  map.who '/quienes', :controller => 'about', :action => 'who'
  map.mission '/paraque', :controller => 'about', :action => 'mission'

  map.resources :users, :as => 'usuario'
  map.resource :survey, :as => 'encuesta'

  map.resources :admin_sessions, :as => 'administracion'
  map.login_admin "/admin", :controller => 'admin_sessions', :action => 'new'
  map.logout_admin "/cerrar", :controller => 'admin_sessions', :action => 'destroy'


  map.connect ':controller/:action/:id'
  map.connect ':controller/:action/:id.:format'
end
