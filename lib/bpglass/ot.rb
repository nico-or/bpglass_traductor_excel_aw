module BPGlass
  class OT
    def self.from_xlsx(filepath)
      foo = Roo::Excelx.new(filepath)

      self.new do |ot|
        ot.id = foo.cell(*Roo::Utils.extract_coordinate("J2"))
        ot.obra = foo.cell(*Roo::Utils.extract_coordinate("C6"))

        original_name = foo.cell(*Roo::Utils.extract_coordinate("C4"))
        alias_name = BPGlass::CLIENTE_ALIAS[original_name.strip] || original_name
        ot.cliente = alias_name

        ot.fecha_despacho = foo.cell(*Roo::Utils.extract_coordinate("N4"))

        ot.metros_cuadrados_tp = foo.cell(*Roo::Utils.extract_coordinate("H6"))
        ot.metros_cuadrados_dim = foo.cell(*Roo::Utils.extract_coordinate("I6"))

        ot.metros_lineales_tp = foo.cell(*Roo::Utils.extract_coordinate("H5"))
        ot.metros_lineales_dim = foo.cell(*Roo::Utils.extract_coordinate("I5"))

        ot.piezas_tp = foo.cell(*Roo::Utils.extract_coordinate("H4"))
        ot.piezas_dim = foo.cell(*Roo::Utils.extract_coordinate("I4"))

        idx = 10
        loop do
          row = foo.row(idx)
          break if [nil, ""].include? row[1]
          ot.posiciones << Posicion.new(row)
          idx += 1
        end
      end
    end

    attr_accessor(
      :id,
      :obra,
      :cliente,
      :fecha_despacho,
      :piezas_tp, :piezas_dim,
      :metros_lineales_tp, :metros_lineales_dim,
      :metros_cuadrados_tp, :metros_cuadrados_dim,
    )

    attr_reader :posiciones

    def initialize
      @posiciones = []

      yield self
    end

    def tp_array
      [
        id,
        obra,
        cristal_especial,
        forma,
        cliente,
        piezas_tp, #tp_original,
        "", #dim_original,
        piezas_tp, #tp_original,
        "", #dim_original,
        tps_fabricados,
        dims_fabricados,
        minutos,
        metros_cuadrados_tp, #metros_cuadrados,
        fecha_ingreso,
        fecha_fabricacion_real,
        fecha_fabricacion_planificada,
        fecha_despacho,
        control_calidad,
        estado_actual_produccion,
        metros_lineales_tp, #metros_lineales_programados,
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
        cliente,
        "", #tp_original,
        piezas_dim, #dim_original,
        "", #tp_original,
        piezas_dim, #dim_original,
        tps_fabricados,
        dims_fabricados,
        minutos,
        metros_cuadrados_dim, #metros_cuadrados,
        fecha_ingreso,
        fecha_fabricacion_real,
        fecha_fabricacion_planificada,
        fecha_despacho,
        control_calidad,
        estado_actual_produccion,
        "", #metros_lineales_programados,
        metros_lineales_tp_fabricados,
        metros_lineales_dim, #metros_lineales_dim_programados,
      ]
    end

    def to_tsv
      out = []
      out << tp_array unless piezas_tp.zero?
      out << dim_array unless piezas_dim.zero?
      out.map { _1.join("\t") }
    end

    def cristal_especial
      output = []

      BPGlass::ESPECIAL_ID.keys.each do |tipo_cristal|
        count = posiciones
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
        .select(&:forma?)
        .sum(&:piezas)

      count.zero? ? "" : "FORMA(#{count})"
    end

    %W[
      tps_fabricados
      dims_fabricados
      minutos
      fecha_ingreso
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
