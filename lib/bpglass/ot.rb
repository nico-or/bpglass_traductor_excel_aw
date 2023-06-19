module BPGlass
  class OT
    def self.from_excel_import(filepath)
      file = BPGlass::ExcelParser::BPGlassParser.new(filepath)
      file.ot
    end

    def self.from_bastro(filepath)
      file = BPGlass::ExcelParser::BastroParser.new(filepath)
      file.ot
    end

    attr_reader(
      :posiciones,
      :id,
      :obra,
      :fecha_despacho,
    )

    def initialize(
      id:,
      obra:,
      cliente:,
      fecha_despacho:
    )
      @id = id
      @obra = obra
      @cliente = cliente
      @fecha_despacho = fecha_despacho
      @posiciones = []
    end

    def cliente
      BPGlass::Clientes.alias(@cliente)
    end

    def piezas_tp
      @piezas_tp ||= posiciones_tp.sum(&:cantidad)
    end

    def piezas_dim
      @piezas_dim ||= posiciones_dim.sum(&:cantidad)
    end

    def metros_cuadrados_tp
      @metros_cuadrados_tp ||= posiciones_tp.sum(&:metros_cuadrados)
    end

    def metros_cuadrados_dim
      @metros_cuadrados_dim ||= posiciones_dim.sum(&:metros_cuadrados)
    end

    def metros_lineales_tp
      @metros_lineales_tp ||= posiciones_tp.sum(&:metros_lineales)
    end

    def metros_lineales_dim
      @metros_lineales_dim ||= posiciones_dim.sum(&:metros_lineales)
    end

    def cristal_especial
      short_names = []

      posiciones_tp.each do |posicion|
        posicion.cantidad.times do
          [posicion.vidrio_1, posicion.vidrio_2].each do |vidrio|
            short_names << vidrio.short_name
          end
        end
      end

      short_names
        .compact
        .tally
        .map { |short_name, count| "#{short_name}(#{count})" }
        .sort
        .join(" ")
    end

    def forma
      count = posiciones_tp
        .select(&:forma?)
        .sum(&:cantidad)

      count.zero? ? "" : "FORMA(#{count})"
    end

    def palillaje
      count = posiciones_tp
        .select(&:palillaje?)
        .sum(&:cantidad)

      count.zero? ? "" : "PALILLAJE(#{count})"
    end

    def fecha_ingreso
      Date.today.strftime("%d-%m-%Y")
    end

    private

    def posiciones_tp
      @posiciones_tp ||= posiciones.select(&:tp?)
    end

    def posiciones_dim
      @posiciones_dim ||= posiciones.select(&:dim?)
    end
  end
end
