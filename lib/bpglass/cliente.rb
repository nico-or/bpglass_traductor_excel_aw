require "yaml"

module BPGlass

  # provides an interface to the clientes YAML database
  module Clientes
    DB_FILENAME = "./lib/data/clientes.yml"
    DB = YAML.load_file(DB_FILENAME)

    def self.alias(cliente_name)
      cliente_name = cliente_name.strip

      cliente = DB.find { |hash| hash[:nombre].eql? cliente_name }

      if cliente.nil?
        puts "Could not find \"#{cliente_name}\" in #{DB_FILENAME}"
        return cliente_name
      end

      cliente[:alias]
    end
  end
end
