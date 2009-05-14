Característica: autenticarse en e3e
  Para poder compeltar la encuesta, y recibir información sobre consumo
  Como usuario registrado
  Quiero poder autenticarme en la aplicación

  Escenario: hacer login
    Dado un usuario con nombre "pepe" y con contraseña "secreta"
    Cuando voy a entrar
    Y relleno "user_session_username" con "pepe"
    Y relleno "user_session_password" con "secreta"
    Y pulso "Entrar"
    Entonces debería ver "Bienvenido"

