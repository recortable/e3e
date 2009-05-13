ActionController::Routing::Routes.draw do |map|

  map.root :controller => 'about'

  map.login "login", :controller => "user_sessions", :action => "new"
  map.logout "logout", :controller => "user_sessions", :action => "destroy"

  map.about '/', :controller => 'about', :action => 'index'
  map.who '/quienes', :controller => 'about', :action => 'who'
  map.mission '/paraque', :controller => 'about', :action => 'mission'

  map.resources :user_sessions
  map.resources :users

  map.connect ':controller/:action/:id'
  map.connect ':controller/:action/:id.:format'
end
