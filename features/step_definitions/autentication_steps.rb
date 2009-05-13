Dado /^que estoy autenticado con "([^\"]*)" y "([^\"]*)"$/ do |email, pass|
  Dado %(una cresta con email "#{email}" y con contraseña "#{pass}")
  Dado %(voy a entrar)
  Dado %(relleno "user_session_username" con "#{email}")
  Dado %(relleno "user_session_password" con "#{pass}")
  Dado %(pulso "Entrar")
end

Dado /^que no estoy autenticado$/ do
  session = UserSession.find
  session.destroy if session
end

