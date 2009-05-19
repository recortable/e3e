ActionController::Routing::Routes.draw do |map|
  map.resources :admins

  map.root :controller => 'about'

  map.resource :user_sessions, :as => 'sesion'
  map.login "/entrar", :controller => "user_sessions", :action => "new"
  map.logout "/salir", :controller => "user_sessions", :action => "destroy"

  map.about '/', :controller => 'about', :action => 'index'
  map.who '/quienes', :controller => 'about', :action => 'who'
  map.mission '/paraque', :controller => 'about', :action => 'mission'
  map.development '/admin/desarrollo', :controller => 'about', :action => 'development'
  map.statistics '/admin/estadisticas', :controller => 'about', :action => 'statistics'

  map.resources :users, :as => 'usuarios'
  map.resource :survey, :as => 'encuesta'

  map.resources :admin_sessions, :as => 'administracion'
  map.admin "/admin", :controller => 'admin_sessions', :action => 'index'
  map.admin_login "/admin/entrar", :controller => 'admin_sessions', :action => 'new'
  map.admin_logout "admin/cerrar", :controller => 'admin_sessions', :action => 'destroy'


  map.connect ':controller/:action/:id'
  map.connect ':controller/:action/:id.:format'
end
