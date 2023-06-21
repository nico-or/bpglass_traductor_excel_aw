require "yaml"

require_relative "cristales/cristal"

module BPGlass
  module Cristales
    DB = YAML.load_file("./lib/data/cristales.yml").map do |hash|
      Cristal.new(hash)
    end

    def self.[](query)
      return if query.eql?("")

      cristal = DB.find { |cristal| cristal.id.eql?(query) } ||
                DB.find { |cristal| cristal.alternative_names.include?(query) }

      raise ArgumentError.new("Unsupported Cristal: #{query}") unless cristal

      cristal
    end
  end
end
