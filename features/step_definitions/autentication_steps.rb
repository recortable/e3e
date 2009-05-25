
Dado /^que estoy autenticado como "([^\"]*)"$/ do |email|
  pass = "secreto"
  Dado %(un usuario con nombre "#{email}" y con contraseña "#{pass}")
  Dado %(voy a entrar)
  Dado %(relleno "user_session_username" con "#{email}")
  Dado %(relleno "user_session_password" con "#{pass}")
  Dado %(pulso "Entrar")
end

Dado /^que no estoy autenticado$/ do
  session = UserSession.find
  session.destroy if session
end

# FIXME
Dado /^que no estoy autenticado como administrador$/ do
  #  session = AdminSession.find
  #  session.destroy if session
end

Dado /^que estoy autenticado como administrador$/ do
  email = "simple@e3e.org"
  pass = "pass"
  Dado %(un administrador con email "#{email}" y con contraseña "#{pass}")
  Dado %(voy a entrar administradores)
  Dado %(relleno "user_session_username" con "#{email}")
  Dado %(relleno "user_session_password" con "#{pass}")
  Dado %(pulso "Entrar")
end
