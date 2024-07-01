# frozen_string_literal: true

module BPGlass
  module JsonWriter
    class JsonWriter
      attr_reader(:ot)

      def initialize(ot)
        @ot = ot
      end

      def to_json()
        JSON.generate(ot_to_hash(ot))
      end

      private

      def ot_to_hash(ot)
        {
          id: ot.id,
          obra: ot.obra,
          cliente: ot.cliente,
          fecha_despacho: ot.fecha_despacho,
          posiciones: ot.posiciones.map { |pos| posicion_to_hash(pos) }
        }
      end

      def posicion_to_hash(posicion)
        {
          vidrio_1: posicion.vidrio_1&.carga_masiva_name,
          vidrio_2: posicion.vidrio_2&.carga_masiva_name,
          separador: separador_to_hash(posicion.separador),
          cantidad: posicion.cantidad,
          ancho: posicion.ancho,
          alto: posicion.alto
        }
      end

      def separador_to_hash(separador)
        return unless separador

        {
            medida: separador.medida,
            color: separador.color
        }
      end
    end
  end
end
