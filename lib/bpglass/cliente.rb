require "yaml"

module BPGlass

  # provides an interface to the clientes YAML database
  module Clientes
    DB = YAML.load_file("./lib/data/clientes.yml")

    def self.alias(cliente_name)
      cliente_name = cliente_name.strip

      cliente = DB.find { |hash| hash[:nombre].eql? cliente_name }

      return cliente_name if cliente.nil?

      cliente[:alias]
    end
  end
end
