
Before do
  # Authlogic::Session::Base.controller = Authlogic::ControllerAdapters::RailsAdapter.new(self) #activate_authlogic
  User.destroy_all
end