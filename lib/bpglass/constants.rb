module BPGlass
  ID_VIDRIO = {
    100 => "Incoloro 04 mm",
    110 => "Incoloro 05 mm",
    120 => "Incoloro 06 mm",
    170 => "Bronce 04 mm",
    180 => "Bronce 05 mm",
    230 => "Semilla 04 mm",
    260 => "Saten 04 mm",
    280 => "Ecl. Adv . Clear 06 mm",
    350 => "Laminado 3+3.1 Inc",
    360 => "Laminado 4+4.1 Inc",
    390 => "Laminado 3+3.1 Acustico",
    460 => "Low-e 06 mm",
  }

  ID_SEPARADOR = {
    11 => "Sep. 9.5 mm BR OSC",
    12 => "Sep. 11.5 mm BR OSC",
    13 => "Sep. 14.5 mm BR OSC",
    10 => "Sep. 7.5 mm BR OSC",
  }

  ESPECIAL_ID = {
    "bronce_4" => [170],
    "bronce_5" => [180],
    "clear" => [280],
    "green" => [],
    "gris" => [],
    "laminado_acustico_6" => [390],
    "laminado_6" => [350],
    "laminado_8" => [360],
    "lowe" => [460],
    "saten" => [260],
    "semilla" => [230],
  }

  ESPECIAL_ALIAS = {
    "bronce_4" => "BRC4",
    "bronce_5" => "BRC5",
    "clear" => "CLEAR",
    "green" => "GREEN",
    "gris" => "GRIS",
    "laminado_acustico_6" => "LAMAC6",
    "laminado_6" => "LAM6",
    "laminado_8" => "LAM8",
    "lowe" => "LOWE",
    "saten" => "SAT",
    "semilla" => "SEM",
  }

  CLIENTE_ALIAS = {
    "BARRA & STROBEL LIMITADA" => "BASTRO",
    "FABRICA DE PUERTAS Y VENTANAS RENOVA TEK LIMITADA" => "RENOVATEK",
    "VENTANAS SOLVEN LTDA" => "SOLVEN",
    "SOCIEDAD TECNOLOGICA EN FABRICACION DE ALUMINIOS LTDA" => "TEFALUM",
    "TALAMARGO VENTANAS LIMITADA" => "TALAMARGO VENTANAS",
    "EUROSYSTEM SPA" => "EUROSYSTEM",
    "ROLAND ANDRES CASTILLO BUSTOS" => "ROLAND CASTILLO",
    "PATRICIO ESPINOZA SOZA" => "PATRICIO ESPINOZA",
    "SOCIEDAD COMERCIALIZADORA ZUVA LIMITADA" => "ZUVA LTDA",
    "RODRÍGUEZ Y RIVEROS SPA" => "RODRÍGUEZ Y RIVEROS",
    "SEDICON LTDA" => "SEDICON",
    "SOTO Y COMPANIA LIMITADA" => "SOTO Y CIA LTDA",
    "TECNIALUM LTDA" => "TECNIALUM",
    "SYS PROYECGLASS" => "",
    "CESAR ANTONIO ANABALON VALDIVIA" => "CESAR ANABALON",
    "TERMOPLUS CHILE SPA" => "TERMOPLUS",
    "FONSTER SPA" => "FONSTER",
    "ALUMINUN ROLLER SPA" => "ALUMINUN ROLLER",
    "VIDRIERIA ANDRES GUILLERMO DONOSO ACOSTA EIRL" => "VIDRIERIA ANDRES DONOSO",
    "MARIA PAZ NORABUENA ZAMUDIO" => "MARIA PAZ NORABUENA",
    "PASMIÑO LTDA" => "PASMIÑO",

  }
end
