Característica: completar encuestas
  Para poder obtener los datos de consumo
  Como usuario registrado
  Quiero poder rellenar las encuestas

  Escenario: ver encuesta sin autenticarse
    Dado que no estoy autenticado
    Cuando voy a la encuesta
    Entonces debería ver el mensaje :require_user

  Escenario: seleccionar una provincia
    Dado que estoy autenticado como "pepito"
    Y que existen las provincias "Córdoba, Almería, Granada"
    Cuando voy a la encuesta
    Y selecciono "Córdoba" de "survey[provincia_id]"
    Y pulso "Guardar"
    Entonces debería ver "Córdoba"
