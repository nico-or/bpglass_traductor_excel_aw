module BPGlass
  module CsvWriter
    class CargaMasivaWriter
      CSV_HEADERS = [
        "Cantidad",
        "Ancho (mm)",
        "Alto (mm)",
        "Vidrio 1",
        "Vidrio 2",
        "Vidrio 3",
        "Separador 1",
        "Color separador 1",
        "Separador 2",
        "Color separador 2",
        "Forma",
        "Palillo",
        "Cantidad verticales",
        "Cantidad horizontal",
        "Referencia",
      ]

      CSV_OPTIONS = {
        headers: CSV_HEADERS,
        write_headers: true,
        col_sep: "\t",
      }

      attr_reader(:ot)

      def initialize(ot)
        @ot = ot
      end

      def to_csv()
        CSV.generate("", CSV_OPTIONS) do |csv|
          ot.posiciones.each do |posicion|
            csv << hash_posicion(posicion)
          end
        end
      end

      private

      def hash_posicion(pos)
        {
          "Cantidad" => pos.cantidad,
          "Ancho (mm)" => pos.ancho,
          "Alto (mm)" => pos.alto,
          "Vidrio 1" => pos.vidrio_1.to_carga_masiva,
          "Vidrio 2" => pos.vidrio_2.to_carga_masiva,
          "Vidrio 3" => nil,
          "Separador 1" => separador_string(pos.separador),
          "Color separador 1" => separador_color_string(pos.separador),
          "Separador 2" => nil,
          "Color separador 2" => nil,
          "Forma" => pos.forma? ? pos.forma : nil,
          "Palillo" => pos.palillaje? ? 1 : nil,
          "Cantidad verticales" => nil,
          "Cantidad horizontal" => nil,
          "Referencia" => pos.referencia,
        }
      end

      def separador_string(separador)
        "Sep #{Utilities.number_to_excel_string(separador.medida)}"
      end

      def separador_color_string(separador)
        case separador.color
        when :bronce_oscuro
          "BR OSC"
        when :mate
          "MATE"
        end
      end
    end
  end
end
