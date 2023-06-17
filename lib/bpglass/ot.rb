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
      :piezas_tp,
      :piezas_dim,
      :metros_lineales_tp,
      :metros_lineales_dim,
      :metros_cuadrados_tp,
      :metros_cuadrados_dim
    )

    def initialize(
      id:,
      obra:,
      cliente:,
      fecha_despacho:,
      piezas_tp:,
      piezas_dim:,
      metros_lineales_tp:,
      metros_lineales_dim:,
      metros_cuadrados_tp:,
      metros_cuadrados_dim:
    )
      @id = id
      @obra = obra
      @cliente = cliente
      @fecha_despacho = fecha_despacho
      @piezas_tp = piezas_tp.to_i
      @piezas_dim = piezas_dim.to_i
      @metros_lineales_tp = metros_lineales_tp.to_f
      @metros_lineales_dim = metros_lineales_dim.to_f
      @metros_cuadrados_tp = metros_cuadrados_tp.to_f
      @metros_cuadrados_dim = metros_cuadrados_dim.to_f
      @posiciones = []
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

      posiciones.select(&:tp?).each do |posicion|
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
      count = posiciones
        .select(&:tp?)
        .select(&:forma?)
        .sum(&:cantidad)

      count.zero? ? "" : "FORMA(#{count})"
    end

    def palillaje
      count = posiciones
        .select(&:tp?)
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
  end
end
