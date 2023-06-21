module BPGlass
  module Cristales
    Cristal = Struct.new(
      "Cristal",
      :id,
      :alternative_names,
      :short_name,
      :especial,
      :carga_masiva_name,
      keyword_init: true,
    ) do
      def especial?
        especial
      end

      def to_carga_masiva
        carga_masiva_name
      end
    end
  end
end
