class Survey < ActiveRecord::Base
  belongs_to :user
  belongs_to :provincia
  belongs_to :municipio

  SINO = ['s', 'n']
  TAN = ['todas', 'alguna', 'ninguna']

  EDIFICIO_PERIODO = ['antes1950', 'de1901a1940', 'de1941a1960', 'de1961a1980', 'de1981a2006', 'post2006']

  VIVIENDA_TIPO_EDIFICIO = ['bloque', 'aislado', 'adosado', 'pareado']
  VIVIENDA_PLANTA = ['planta_baja', 'planta_intermedia', 'planta_ultima']
  VIVIENDA_TEJADO = ['tejado_plano', 'tejado_inclinado']
  VIVIENDA_REFORMAS = %w(aistejado aisparedes toldos doblevidrio asisuelo)
  VIVIENDA_REFORMA_ULTIMA = ['menos5', 'entre5y10', 'mas10']

  EQUIP_SERVICIOS = %w(calef aire agua)
  EQUIP_FUENTES = %w(electr gasnat gasoleo gasbutprop solar madera otros)

  EQUIP_CALE_TIPO = ['caldera', 'radiador', 'bomba', 'acumulad']
  EQUIP_AGUA_DISP = ['caldera', 'termo', 'bomba']
  EQUIP_TIPO_IC =['individual', 'centralizada']
  EQUIP_TIPO =['individual', 'centralizada', 'notengo']
  EQUIP_DISPOSITIVOS = ['lavadora', 'secadora', 'lavavajillas', 'frigo', 'congelador', 'hornoel', 'hornonoel', 'microondas',
    'tele', 'ordenador', 'portatil' ]
  EQUIP_ILUMINACION = ['incan', 'bajocon', 'fluor', 'leds']
  EQUIP_DONDE = ['salas', 'dormitorios']
  EQUIP_AC_TIPO = ['caldera', 'bomba', 'radiador', 'acumulad']
  EQUIP_AC_INDIVIDUAL = ['ventana', 'split']
  EQUIP_AC_INDEPENDIENTES = ['unovarios', 'variosvarios']
  EQUIP_BOMBA_TIPO = ['uneq', 'varioseq']
end
