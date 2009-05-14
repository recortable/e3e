Dado /^un usuario con nombre "([^\"]*)" y con contraseña "([^\"]*)"$/ do |name, password|
  user = Factory(:user, :username => name, :password => password, :password_confirmation => password)
  user.save!
end

Dado /^que existen los usuarios "([^\"]*)"$/ do |lista|
  lista.split(', ').each do |name|
    User.create!(:username => name, :login => name, :password => 'secreto', :password_confirmation => 'secreto')
  end
end

