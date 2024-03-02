module BPGlass
  module CsvWriter
    class PlanificacionWriter
      CSV_HEADERS = [
        # "TAREA",
        'OT',
        'PROYECTO',
        'CRISTAL ESPECIAL',
        'CRISTAL CON FORMA',
        'CLIENTE',
        'TP ORIGINAL',
        'DIM ORIGINAL',
        'TP PROGRAMADOS',
        'DIM PROGRAMADOS',
        'TP FABRICADOS',
        'DIM FABRICADOS',
        'MINUTOS',
        'M2',
        'FECHA INGRESO',
        'FECHA FABRICACION REAL',
        'FECHA FABRICACION PLANIFICADA',
        'FECHA DESPACHO',
        'CONTROL DE CALIDAD',
        'ESTADO ACTUAL PRODUCCION',
        'MTL TP PROGRAMADO',
        'MTL TP FABRICADOS',
        'MTL DIM PROGRAMADO'
        # "MTL DIM FABRICADOS",
      ]

      CSV_OPTIONS = {
        headers: CSV_HEADERS,
        col_sep: "\t"
      }

      attr_reader(:ot)

      def initialize(ot)
        @ot = ot
      end

      def to_csv
        CSV.generate('', **CSV_OPTIONS) do |csv|
          csv << hash_tp unless ot.piezas_tp.zero?
          csv << hash_dim unless ot.piezas_dim.zero?
        end
      end

      def hash_comun
        {
          'OT' => ot.id,
          'PROYECTO' => ot.obra,
          'CLIENTE' => ot.cliente,
          'FECHA INGRESO' => ot.fecha_ingreso,
          'FECHA DESPACHO' => ot.fecha_despacho
        }
      end

      def hash_tp
        hash_comun.merge(
          {
            'CRISTAL ESPECIAL' => prevent_empty_strings(cristal_especial_string),
            'CRISTAL CON FORMA' => prevent_empty_strings(cristal_forma),
            'TP ORIGINAL' => ot.piezas_tp,
            'TP PROGRAMADOS' => ot.piezas_tp,
            'M2' => Utilities.number_to_excel_string(ot.metros_cuadrados_tp),
            'MTL TP PROGRAMADO' => Utilities.number_to_excel_string(ot.metros_lineales_tp)
          }
        )
      end

      def hash_dim
        hash_comun.merge(
          {
            'CRISTAL ESPECIAL' => 'DIMENSIONADO',
            'DIM ORIGINAL' => ot.piezas_dim,
            'DIM PROGRAMADOS' => ot.piezas_dim,
            'M2' => Utilities.number_to_excel_string(ot.metros_cuadrados_dim),
            'MTL DIM PROGRAMADO' => Utilities.number_to_excel_string(ot.metros_lineales_dim)
          }
        )
      end

      private

      def cristal_especial_string
        ot.posiciones_tp
          .flat_map { |pos| [pos.vidrio_1, pos.vidrio_2].map(&:short_name).uniq.compact * pos.cantidad }
          .tally
          .map { |short, count| "#{short}(#{count})" }
          .sort
          .join(' ')
      end

      def palillaje_string
        count = ot.posiciones_palillaje.sum(&:cantidad)
        count.zero? ? nil : "PALILLAJE(#{count})"
      end

      def forma_string
        count = ot.posiciones_forma.sum(&:cantidad)
        count.zero? ? nil : "FORMA(#{count})"
      end

      def plantilla_string
        count = ot.posiciones_plantilla.sum(&:cantidad)
        count.zero? ? nil : "PLANTILLA(#{count})"
      end

      def cristal_forma
        [
          palillaje_string,
          forma_string,
          plantilla_string
        ].compact.join(' ')
      end

      def prevent_empty_strings(string)
        string.empty? ? nil : string
      end
    end
  end
end
