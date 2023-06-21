require "roo"

module BPGlass
  module ExcelParser
    class BPGlassParser
      ROO_MATCHER = {
        vidrio_1: "Vidrio 1",
        vidrio_2: "Vidrio 2",
        separador: "Separador",
        cantidad: "Pzas.",
        ancho: "Ancho",
        alto: "Alto",
        referencia: "Referencia",
        forma: "Forma",
      }

      attr_reader :filepath

      def initialize(filepath)
        @filepath = filepath
      end

      def file
        @file ||= Roo::Excelx.new(filepath)
      end

      def posiciones
        @posiciones ||= entries.map { BPGlass::Posicion.from_hash(_1) }
      end

      def ot
        xlsx = Roo::Excelx.new(filepath)

        ot = BPGlass::OT.new(
          id: xlsx.cell(*Roo::Utils.extract_coordinate("J2")),
          obra: xlsx.cell(*Roo::Utils.extract_coordinate("C6")),
          cliente: xlsx.cell(*Roo::Utils.extract_coordinate("C4")),
          fecha_despacho: xlsx.cell(*Roo::Utils.extract_coordinate("N4")),
        )

        posiciones.each { |pos| ot.posiciones << pos }

        ot
      end

      private

      def entries
        @entries ||= file.parse(ROO_MATCHER)
          .reject { |hash| ["", nil].include?(hash[:vidrio_1]) }
      end
    end
  end
end
