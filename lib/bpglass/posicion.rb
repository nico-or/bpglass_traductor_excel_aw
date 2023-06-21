module BPGlass
  class Posicion
    def self.from_hash(hash)
      Posicion.new(
        vidrio_1: hash[:vidrio_1],
        vidrio_2: hash[:vidrio_2],
        separador: hash[:separador],
        cantidad: hash[:cantidad],
        ancho: hash[:ancho],
        alto: hash[:alto],
        referencia: hash[:referencia],
        forma: hash[:forma],
      )
    end

    def initialize(
      cantidad:,
      vidrio_1:,
      vidrio_2: nil,
      separador: nil,
      ancho:,
      alto:,
      referencia: nil,
      forma: nil
    )
      @vidrio_1 = vidrio_1
      @vidrio_2 = vidrio_2
      @separador = separador
      @cantidad = cantidad
      @ancho = ancho
      @alto = alto
      @referencia = referencia
      @forma = forma
    end

    def vidrio_1
      BPGlass::Cristales[@vidrio_1]
    end

    def vidrio_2
      return if @vidrio_2.nil?

      BPGlass::Cristales[@vidrio_2]
    end

    def separador
      BPGlass::Separadores[@separador]
    end

    def cantidad
      @cantidad.to_i
    end

    def alto
      @alto.to_i
    end

    def ancho
      @ancho.to_i
    end

    def metros_cuadrados
      cantidad * (ancho * alto / 1e6)
    end

    def metros_lineales
      cantidad * (2 * (ancho + alto) / 1e3)
    end

    def tp?
      !vidrio_2.nil?
    end

    def dim?
      vidrio_2.nil?
    end

    def forma
      @forma
    end

    def forma?
      ["F1", "F2"].include?(forma)
    end

    def plantilla?
      ["F3"].include?(forma)
    end

    def palillaje?
      @referencia.match? /PALILLAJE/
    end
  end
end
