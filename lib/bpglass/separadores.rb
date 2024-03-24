# frozen_string_literal: true

require 'yaml'

require_relative 'separadores/separador'

module BPGlass
  module Separadores
    DB = YAML.load_file('./lib/data/separadores.yml').map do |hash|
      Separador.new(hash)
    end

    def self.[](query)
      query = Utilities.normalize_text(query.to_s) if query.instance_of?(String)
      return if query.eql?('')

      separador = DB.find { |separador| separador.id.eql?(query) } ||
                  DB.find { |separador| separador.alternative_names.include?(query) }

      raise ArgumentError, "Unsupported Separador: #{query}" unless separador

      separador
    end
  end
end
