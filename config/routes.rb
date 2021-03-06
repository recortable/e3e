ActionController::Routing::Routes.draw do |map|

  map.root :controller => 'about', :action => 'welcome'

  map.login "/entrar", :controller => "user_sessions", :action => "new"
  map.logout "/salir", :controller => "user_sessions", :action => "destroy"

  map.feedback "/contacto", :controller => 'about', :action => 'feedback'
#  map.what '/que_es', :controller => 'about', :action => 'what'
#  map.who '/quienes', :controller => 'about', :action => 'who'
#  map.mission '/paraque', :controller => 'about', :action => 'mission'

  map.admin_login "/admin", :controller => 'admin_sessions', :action => 'new'
  map.admin_logout "admin/cerrar", :controller => 'admin_sessions', :action => 'destroy'
  map.development '/admin/desarrollo', :controller => 'about', :action => 'development'
  map.statistics '/admin/estadisticas', :controller => 'about', :action => 'statistics'


  map.resources :provincias, :only => [:index, :show]
  map.resource :consumption
  map.resource :user_sessions, :as => 'sesion'
  map.resource :gas, :as => 'gas', :controller => 'gas'
  map.resource :electricidad, :as => 'electricidad', :controller => 'electricidad'
  map.resource :password_reminders, :as => 'recordar', :only => [:new, :create, :show], :collection => {:new => :post}
  map.resources(:users, :as => 'usuarios') do |user|
    user.resource :survey, :as => 'encuesta'
  end
  map.resource :survey, :as => 'encuesta'
  map.resource :invoice, :as => 'factura'
  map.resource :report, :as => 'informe'
  map.resources :admins


  map.resources :admin_sessions, :as => 'administracion'


end
