module BPGlass
  class OT
    def self.from_excel_import(filepath)
      ExcelImport.ot(filepath)
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
      @piezas_tp = piezas_tp
      @piezas_dim = piezas_dim
      @metros_lineales_tp = metros_lineales_tp
      @metros_lineales_dim = metros_lineales_dim
      @metros_cuadrados_tp = metros_cuadrados_tp
      @metros_cuadrados_dim = metros_cuadrados_dim
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
        metros_cuadrados_tp.to_excel_string, #metros_cuadrados,
        fecha_ingreso,
        fecha_fabricacion_real,
        fecha_fabricacion_planificada,
        fecha_despacho,
        control_calidad,
        estado_actual_produccion,
        metros_lineales_tp.to_excel_string, #metros_lineales_programados,
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
        metros_cuadrados_dim.to_excel_string, #metros_cuadrados,
        fecha_ingreso,
        fecha_fabricacion_real,
        fecha_fabricacion_planificada,
        fecha_despacho,
        control_calidad,
        estado_actual_produccion,
        "", #metros_lineales_programados,
        metros_lineales_tp_fabricados,
        metros_lineales_dim.to_excel_string, #metros_lineales_dim_programados,
      ]
    end

    def output_arrays
      out = []
      out << tp_array unless piezas_tp.zero?
      out << dim_array unless piezas_dim.zero?
      out
    end

    def cristal_especial
      output = []

      BPGlass::ESPECIAL_ID.keys.each do |tipo_cristal|
        count = posiciones
          .select(&:tp?)
          .select { |posicion| posicion.send("#{tipo_cristal}?".to_sym) }
          .sum(&:piezas)

        unless count.zero?
          output << "#{BPGlass::ESPECIAL_ALIAS[tipo_cristal]}(#{count})"
        end
      end

      output.sort.join(" ")
    end

    def forma
      count = posiciones
        .select(&:tp?)
        .select(&:forma?)
        .sum(&:piezas)

      count.zero? ? "" : "FORMA(#{count})"
    end

    def palillaje
      count = posiciones
        .select(&:tp?)
        .select(&:palillaje?)
        .sum(&:piezas)

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
  end
end
