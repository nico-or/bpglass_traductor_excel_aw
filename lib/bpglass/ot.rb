module BPGlass
  class OT
    def self.from_excel_import(filepath)
      file = BPGlass::ExcelParser::BPGlassParser.new(filepath)
      file.ot
    end

    attr_reader(
      :posiciones,
      :id,
      :obra,
      :cliente,
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

    def piezas_tp
      @piezas_tp ||= posiciones_tp.sum(&:cantidad)
    end

    def piezas_dim
      @piezas_tp ||= posiciones_dim.sum(&:cantidad)
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

    def tp_array
      [
        id,
        obra,
        cristal_especial,
        [palillaje, forma].join(" ").strip,
        BPGlass::Clientes.alias(cliente),
        piezas_tp, #tp_original,
        "", #dim_original,
        piezas_tp, #tp_original,
        "", #dim_original,
        tps_fabricados,
        dims_fabricados,
        minutos,
        to_excel_string(metros_cuadrados_tp), #metros_cuadrados,
        fecha_ingreso,
        fecha_fabricacion_real,
        fecha_fabricacion_planificada,
        fecha_despacho,
        control_calidad,
        estado_actual_produccion,
        to_excel_string(metros_lineales_tp), #metros_lineales_programados,
        metros_lineales_tp_fabricados,
        "", #metros_lineales_dim_programados,
      ]
    end

    def dim_array
      [
        id,
        obra,
        "DIMENSIONADO",
        forma,
        BPGlass::Clientes.alias(cliente),
        "", #tp_original,
        piezas_dim, #dim_original,
        "", #tp_original,
        piezas_dim, #dim_original,
        tps_fabricados,
        dims_fabricados,
        minutos,
        to_excel_string(metros_cuadrados_dim), #metros_cuadrados,
        fecha_ingreso,
        fecha_fabricacion_real,
        fecha_fabricacion_planificada,
        fecha_despacho,
        control_calidad,
        estado_actual_produccion,
        "", #metros_lineales_programados,
        metros_lineales_tp_fabricados,
        to_excel_string(metros_lineales_dim), #metros_lineales_dim_programados,
      ]
    end

    def output_arrays
      out = []
      out << tp_array unless piezas_tp.zero?
      out << dim_array unless piezas_dim.zero?
      out
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

    %W[
      tps_fabricados
      dims_fabricados
      minutos
      fecha_fabricacion_real
      fecha_fabricacion_planificada
      control_calidad
      estado_actual_produccion
      metros_lineales_tp_fabricados
      metros_lineales_dim_fabricados
    ].each do |method|
      define_method(method) do
        ""
      end
    end

    private

    def to_excel_string(number)
      number.round(1).to_s.gsub(".", ",")
    end

    def posiciones_tp
      @posiciones_tp ||= posiciones.select(&:tp?)
    end

    def posiciones_dim
      @posiciones_dim ||= posiciones.select(&:dim?)
    end
  end
end
