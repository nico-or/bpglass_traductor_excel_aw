require "yaml"

module BPGlass
  module Cristales
    Cristal = Struct.new("Cristal", :id, :cotizador, :especial, :short_name, keyword_init: true)

    DB = YAML.load_file("./lib/data/cristales.yml").map { Cristal.new(_1) }

    def self.[](cristal_id)
      DB.find { |cristal| cristal.id.eql?(cristal_id) }
    end
  end
end
