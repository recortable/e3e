Característica: administración de e3e
  Para poder analizar los resultados de la encuesta
  Como administrador
  Quiero poder ver los datos de los usuarios

  Escenario: hacer login como administrador
    Dado un administrador con email "epa@epa.org" y con contraseña "pass"
    Cuando voy a entrar administradores
    Y relleno "admin_session_email" con "epa@epa.org"
    Y relleno "admin_session_password" con "pass"
    Entonces debería ver el mensaje :flash :admin_session :created
    Y debería estar en lista de usuarios

  Escenario: acceder a zonas reservadas para administración
    Dado que no estoy autenticado como administrador
    Cuando voy a usuarios
    Entonces debería ver el mensaje :flash :require_admin



