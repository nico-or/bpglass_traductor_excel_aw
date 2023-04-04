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
    "bronce" => [170, 180],
    "clear" => [280],
    "green" => [],
    "gris" => [],
    "laminado_acustico" => [390],
    "laminado" => [350, 360],
    "lowe" => [460],
    "saten" => [260],
    "semilla" => [230],
  }

  ESPECIAL_ALIAS = {
    "bronce" => "BRC",
    "clear" => "CLEAR",
    "green" => "GREEN",
    "gris" => "GRIS",
    "laminado_acustico" => "LAMAC",
    "laminado" => "LAM",
    "lowe" => "LOWE",
    "saten" => "SAT",
    "semilla" => "SEM",
  }

  CLIENTE_ALIAS = {
    "FABRICA DE PUERTAS Y VENTANAS RENOVA TEK LIMITADA" => "RENOVATEK",
    "BARRA & STROBEL LIMITADA" => "BASTRO",
    "VENTANAS SOLVEN LTDA" => "SOLVEN",
    "SOCIEDAD TECNOLOGICA EN FABRICACION DE ALUMINIOS LTDA" => "TEFALUM",
  }
end
