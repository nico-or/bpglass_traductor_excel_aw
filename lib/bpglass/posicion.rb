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
      @tipo = array[15]
      @vidrio_1 = array[1].match(/\d+/)[0].to_i
      @separador = array[2].match(/\d+/)[0].to_i if is_tp?
      @vidrio_2 = array[3].match(/\d+/)[0].to_i if is_tp?
      @producto = array[4].to_i
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
    end

    def is_tp?
      @tipo.eql? "TP"
    end

    def is_dim?
      @tipo.eql? "DIM"
    end

    BPGlass::ESPECIAL_ID.keys.each do |tipo_cristal|
      define_method("#{tipo_cristal}?") do
        [vidrio_1, vidrio_2].any? { BPGlass::ESPECIAL_ID[tipo_cristal].include? _1 }
      end
    end
  end
end
