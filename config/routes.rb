ActionController::Routing::Routes.draw do |map|
  map.resources :admins

  map.resources :admin_sessions

  map.root :controller => 'about'

  map.login "entrar", :controller => "user_sessions", :action => "new"
  map.logout "salir", :controller => "user_sessions", :action => "destroy"

  map.about '/', :controller => 'about', :action => 'index'
  map.who '/quienes', :controller => 'about', :action => 'who'
  map.mission '/paraque', :controller => 'about', :action => 'mission'

  map.resource :user_sessions, :as => 'sesion'
  map.resources :users, :as => 'usuario'
  map.resource :survey, :as => 'encuesta'

  map.connect ':controller/:action/:id'
  map.connect ':controller/:action/:id.:format'
end
