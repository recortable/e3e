Dado /^que estoy autenticado con "([^\"]*)" y "([^\"]*)"$/ do |email, pass|
    Dado %(una cresta con email "#{email}" y con contraseña "#{pass}")
    Dado %(voy a entrar)
    Dado %(relleno "user_session_login" con "#{email}")
    Dado %(relleno "user_session_password" con "#{pass}")
    Dado %(pulso "Entrar")
  end
