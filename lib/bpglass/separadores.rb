require "yaml"

require_relative "separadores/separador"

module BPGlass
  module Separadores
    DB = YAML.load_file("./lib/data/separadores.yml").map do |hash|
      Separador.new(hash)
    end

    def self.[](query)
      return if query.eql?("")

      separador = DB.find { |separador| separador.id.eql?(query) } ||
                  DB.find { |separador| separador.alternative_names.include?(query) }

      raise ArgumentError.new("Unsupported Separador: #{query}") unless separador

      separador
    end
  end
end
