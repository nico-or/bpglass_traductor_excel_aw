module BPGlass
  class OT
    def self.from_xlsx(filepath)
      foo = Roo::Excelx.new(filepath)

      self.new do |ot|
        ot.id = foo.cell(*Roo::Utils.extract_coordinate("J2"))
        ot.obra = foo.cell(*Roo::Utils.extract_coordinate("C6"))
        ot.cliente = foo.cell(*Roo::Utils.extract_coordinate("C4"))

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
          break if [nil, ""].include? row[2]
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

    def to_a
      [
        id,
        obra,
        cristal_especial,
        forma,
        cliente,
        piezas_tp, #tp_original,
        piezas_dim, #dim_original,
        piezas_tp, #tp_original,
        piezas_dim, #dim_original,
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
        metros_lineales_dim, #metros_lineales_dim_programados,
      ]
    end

    def fecha_ingreso
      Date.today.strftime("%d-%m-%y")
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

    %W[
      forma
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
