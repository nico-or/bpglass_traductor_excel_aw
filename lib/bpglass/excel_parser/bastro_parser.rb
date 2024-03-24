# frozen_string_literal: true

require 'roo-xls'

module BPGlass
  module ExcelParser
    class BastroParser
      ROO_MATCHER = {
        vidrio_1: 'Cristal 1',
        vidrio_2: 'Cristal 2',
        separador: 'Separador',
        cantidad: 'Cantidad',
        ancho: 'Ancho',
        alto: 'Alto',
        referencia: 'Referencia Item'
      }.freeze

      attr_reader :filepath

      def initialize(filepath)
        @filepath = filepath
      end

      def posiciones
        @posiciones = entries.map do |hash|
          BPGlass::Posicion.new(
            vidrio_1: hash[:vidrio_1],
            vidrio_2: hash[:vidrio_2],
            separador: hash[:separador],
            cantidad: hash[:cantidad],
            ancho: hash[:ancho].instance_of?(String) ? nil : hash[:ancho],
            alto: hash[:alto],
            referencia: hash[:referencia],
            forma: hash[:ancho].instance_of?(String) ? 'F1' : nil
          )
        end
      end

      def ot
        BPGlass::OT.new(
          id: nil,
          obra: excel_file.cell(*Roo::Utils.extract_coordinate('C7')),
          cliente: excel_file.cell(*Roo::Utils.extract_coordinate('C3')),
          fecha_despacho: nil
        ).tap do |ot|
          posiciones.each { |pos| ot.posiciones << pos }
        end
      end

      private

      def excel_file
        @excel_file ||= Roo::Excel.new(filepath)
      end

      def entries
        @entries ||= excel_file.parse(ROO_MATCHER)
                               .reject { |hash| ['', nil].include?(hash[:vidrio_1]) }
      end
    end
  end
end
