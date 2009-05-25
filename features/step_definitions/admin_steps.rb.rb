Dado /^un administrador con email "([^\"]*)" y con contraseña "([^\"]*)"$/ do |email, password|
  admin = Factory(:admin, :email => email, :password => password, :password_confirmation => password)
  admin.save!
end
