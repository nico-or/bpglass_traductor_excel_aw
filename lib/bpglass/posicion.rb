module BPGlass
  class Posicion
    attr_reader(
      :posicion,
      :vidrio_1,
      :separador,
      :vidrio_2,
      :producto,
      :piezas,
      :ancho,
      :alto,
      :referencia,
      :precio_unitario,
      :descripcion,
      :forma,
      :metros_cuadrados,
      :metros_lineales,
      :peso,
      :tipo
    )

    def initialize(array)
      @posicion = array[0]
      @vidrio_1 = array[1]
      @separador = array[2]
      @vidrio_2 = array[3]
      @producto = array[4]
      @piezas = array[5].to_i
      @ancho = array[6].to_f
      @alto = array[7].to_f
      @referencia = array[8]
      @precio_unitario = array[9].to_f
      @descripcion = array[10]
      @forma = array[11]
      @metros_cuadrados = array[12].to_f
      @metros_lineales = array[13].to_f
      @peso = array[14].to_f
      @tipo = array[15]
    end

    %W[saten laminado].each do |glass_type|
      define_method("#{glass_type}?") do
        [vidrio_1, vidrio_2].any? { _1.downcase.include? glass_type }
      end
    end
  end
end
