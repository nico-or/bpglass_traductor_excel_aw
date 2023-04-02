module BPGlass
  ID_VIDRIO = {
    100 => "Incoloro 04 mm",
    260 => "Saten 04 mm",
    350 => "Laminado 3+3.1 Inc",

  }

  ESPECIAL_ID = {
    "saten" => [260],
    "laminado" => [350],
    "clear" => [280],
  }

  ESPECIAL_ALIAS = {
    "saten" => "SAT",
    "laminado" => "LAM",
    "clear" => "CLEAR",
  }

  CLIENTE_ALIAS = {
    "FABRICA DE PUERTAS Y VENTANAS RENOVA TEK LIMITADA" => "RENOVATEK",
    "BARRA & STROBEL LIMITADA" => "BASTRO",
    "VENTANAS SOLVEN LTDA" => "SOLVEN",
    "SOCIEDAD TECNOLOGICA EN FABRICACION DE ALUMINIOS LTDA" => "TEFALUM",
  }
end
