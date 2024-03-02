module BPGlass
  module CsvWriter
    class CargaFuturaWriter
      CSV_HEADERS = [
        'Fecha Ingreso',
        'Pedido',
        'Cliente 1',
        'Cliente 2',
        'ORM SRU',
        'ORM SRU Duplicado',
        'BST',
        'BST Duplicado',
        'OBRA',
        'Fabricar',
        'CANT TP',
        'CANT DIM',
        'Palillos',
        'Formas',
        'Fecha Retiro Original',
        'Fecha Retiro',
        'Fecha Retiro2',
        'Retrocede x dias',
        'Fecha Produccion',
        'Fecha Produccion2',
        'Cotizacion',
        'Cotizacion duplicada',
        'OT',
        'OT DUPLICADA',
        'Color Palillo',
        'Tipo Palillo',
        'Fecha Fabricacion'
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
          csv << hash_comun
        end
      end

      private

      def hash_comun
        {
          'OT' => ot.id,
          'OBRA' => ot.obra,
          'BST' => ot.obra.scan(/BST (\d+)/).dig(0, 0),
          'ORM SRU' => [/ORM (\d+)/, /SRU (\d+)/].flat_map { |regex| ot.obra.scan(regex) }.dig(0, 0),
          'Cliente 1' => cliente_1(ot.cliente),
          'Cliente 2' => ot.cliente,
          'Fecha Retiro' => ot.fecha_despacho,
          'Retrocede x dias' => 1,
          'Palillos' => prevent_zero_string(ot.piezas_palillaje),
          'Formas' => prevent_zero_string(ot.piezas_forma)
        }
      end

      def prevent_zero_string(number)
        number.zero? ? nil : number
      end

      def cliente_1(cliente)
        case cliente
        when 'BASTRO' then 'Socios'
        when 'RENOVATEK' then 'Socios'
        else 'Terceros'
        end
      end
    end
  end
end
