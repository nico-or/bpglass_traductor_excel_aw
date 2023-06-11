require "yaml"

module BPGlass
  module Cristales
    Cristal = Struct.new("Cristal", :id, :alias, :especial, :short_name, keyword_init: true)

    DB = YAML.load_file("./lib/data/cristales.yml").map { Cristal.new(_1) }

    def self.[](query)
      cristal = DB.find { |cristal| cristal.id.eql?(query) } ||
                DB.find { |cristal| cristal.alias.include?(query) }

      raise ArgumentError.new("Unsupported Cristal: #{query}") unless cristal

      cristal
    end
  end
end
