# frozen_string_literal: true

require 'roo'

module BPGlass
  module ExcelParser
    class BPGlassParser
      ROO_MATCHER = {
        vidrio_1: 'Vidrio 1',
        vidrio_2: 'Vidrio 2',
        separador: 'Separador',
        cantidad: 'Pzas.',
        ancho: 'Ancho',
        alto: 'Alto',
        referencia: 'Referencia',
        forma: 'Forma'
      }.freeze

      attr_reader :filepath

      def initialize(filepath)
        @filepath = filepath
      end

      def posiciones
        @posiciones ||= entries.map { BPGlass::Posicion.from_hash(_1) }
      end

      def ot
        BPGlass::OT.new(
          id: file.cell(*Roo::Utils.extract_coordinate('J2')),
          obra: file.cell(*Roo::Utils.extract_coordinate('C6')),
          cliente: file.cell(*Roo::Utils.extract_coordinate('C4')),
          fecha_despacho: file.cell(*Roo::Utils.extract_coordinate('N4'))
        ).tap do |ot|
          posiciones.each { |pos| ot.posiciones << pos }
        end
      end

      private

      def file
        @file ||= Roo::Excelx.new(filepath)
      end

      def entries
        @entries ||= file.parse(ROO_MATCHER)
                         .reject { |hash| ['', nil].include?(hash[:vidrio_1]) }
      end
    end
  end
end
