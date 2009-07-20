ActionController::Routing::Routes.draw do |map|

  map.root :controller => 'about'

  map.resource :consumption
  map.resource :user_sessions, :as => 'sesion'
  map.login "/entrar", :controller => "user_sessions", :action => "new"
  map.logout "/salir", :controller => "user_sessions", :action => "destroy"

  map.what '/que_es', :controller => 'about', :action => 'what'
  map.who '/quienes', :controller => 'about', :action => 'who'
  map.mission '/paraque', :controller => 'about', :action => 'mission'
  map.development '/admin/desarrollo', :controller => 'about', :action => 'development'
  map.statistics '/admin/estadisticas', :controller => 'about', :action => 'statistics'

  map.resource :gas, :as => 'gas', :controller => 'gas'
  map.resource :electricidad, :as => 'electricidad', :controller => 'electricidad'
  map.resources(:users, :as => 'usuarios') do |user|
    user.resource :survey, :as => 'encuesta'
  end
  map.resource :survey, :as => 'encuesta'
  map.resource :invoice, :as => 'factura'
  map.resource :report, :as => 'informe'
  map.resources :admins


  map.resources :admin_sessions, :as => 'administracion'
  map.admin_login "/admin", :controller => 'admin_sessions', :action => 'new'
  map.admin_logout "admin/cerrar", :controller => 'admin_sessions', :action => 'destroy'


  map.connect ':controller/:action/:id'
  map.connect ':controller/:action/:id.:format'
end
