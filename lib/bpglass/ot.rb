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

        total_posiciones = ot.piezas_tp + ot.piezas_dim

        1.upto(total_posiciones) do |i|
          idx = 9 + i #offset
          ot.posiciones << Posicion.new(foo.row(idx))
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

    %W[
      cristal_especial
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
