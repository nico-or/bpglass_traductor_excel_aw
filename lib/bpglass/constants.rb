module BPGlass
  ID_VIDRIO = {
    100 => "Incoloro 04 mm",
    110 => "Incoloro 05 mm",
    120 => "Incoloro 06 mm",
    130 => "Incoloro 08 mm",
    170 => "Bronce 04 mm",
    180 => "Bronce 05 mm",
    200 => "Evergreen 06 mm",
    230 => "Semilla 04 mm",
    260 => "Saten 04 mm",
    280 => "Ecl. Adv. Clear 06 mm",
    290 => "Ecl. Adv. Gris 06 mm",
    350 => "Laminado 3+3.1 Inc",
    360 => "Laminado 4+4.1 Inc",
    379 => "Laminado 2.5+2.6 Satén",
    390 => "Laminado 3+3.1 Acustico",
    400 => "Laminado 4+4.1 Acustico",
    460 => "Low-e 06 mm",
  }

  ID_SEPARADOR = {
    10 => "Sep. 7.5 mm BR OSC",
    11 => "Sep. 9.5 mm BR OSC",
    12 => "Sep. 11.5 mm BR OSC",
    13 => "Sep. 14.5 mm BR OSC",
    14 => "Sep. 19.5 mm BR OSC",
    15 => "Sep. 5.5 mm BR OSC",
    20 => "Sep. 7.5 mm MATE",
    21 => "Sep. 9.5 mm MATE",
    22 => "Sep. 11.5 mm MATE",
    23 => "Sep. 14.5 mm MATE",
    25 => "Sep. 5.5 mm MATE",
    31 => "Sep 9.5 mm TITANIO",
  }

  ESPECIAL_ID = {
    "bronce_4" => [170],
    "bronce_5" => [180],
    "evergreen" => [200],
    "semilla" => [230],
    "saten" => [260],
    "clear" => [280],
    "gris" => [290],
    "laminado_6" => [350],
    "laminado_8" => [360],
    "laminado_saten_5" => [379],
    "laminado_acustico_6" => [390],
    "laminado_acustico_8" => [400],
    "lowe" => [460],
  }

  ESPECIAL_ALIAS = {
    "bronce_4" => "BRC4",
    "bronce_5" => "BRC5",
    "evergreen" => "GREEN",
    "semilla" => "SEM",
    "saten" => "SAT",
    "clear" => "CLEAR",
    "gris" => "GRIS",
    "laminado_6" => "LAM6",
    "laminado_8" => "LAM8",
    "laminado_saten_5" => "LAMSAT5",
    "laminado_acustico_6" => "LAMAC6",
    "laminado_acustico_8" => "LAMAC8",
    "lowe" => "LOWE",
  }
end
