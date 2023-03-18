require "roo"

require_relative "bpglass/ot"
require_relative "bpglass/posicion"

module BPGlass
  ID_VIDRIO = {
    100 => "100 - Incoloro 04 mm",
    260 => "Saten 04 mm",
  }

  ESPECIAL_ID = {
    "saten" => [260],
  }

  ESPECIAL_ALIAS = {
    "saten" => "SAT",
  }
end
