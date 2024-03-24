# frozen_string_literal: true

module BPGlass
  module Separadores
    Separador = Struct.new(
      'Separador',
      :id,
      :medida,
      :color,
      :alternative_names,
      keyword_init: true
    )
  end
end
