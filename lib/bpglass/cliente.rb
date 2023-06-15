require "yaml"

module BPGlass

  # provides an interface to the clientes YAML database
  module Clientes
    CLIENTE_DB_FILENAME = "./lib/data/clientes.yml"
    DB = YAML.load_file(CLIENTE_DB_FILENAME)

    def self.alias(cliente_name)
      cliente_name = cliente_name.strip

      cliente = DB.find { |hash| hash[:nombre].eql? cliente_name }

      raise ArgumentError.new("Can't find #{cliente_name} in #{CLIENTE_DB_FILENAME}") if cliente.nil?

      cliente[:alias]
    end
  end
end
