require "roo"

module BPGlass
  module ExcelImport
    def self.ot(filepath)
      xlsx = Roo::Excelx.new(filepath)

      ot = BPGlass::OT.new(
        id: xlsx.cell(*Roo::Utils.extract_coordinate("J2")),
        obra: xlsx.cell(*Roo::Utils.extract_coordinate("C6")),
        cliente: xlsx.cell(*Roo::Utils.extract_coordinate("C4")),
        fecha_despacho: xlsx.cell(*Roo::Utils.extract_coordinate("N4")),
        metros_cuadrados_tp: xlsx.cell(*Roo::Utils.extract_coordinate("H6")),
        metros_cuadrados_dim: xlsx.cell(*Roo::Utils.extract_coordinate("I6")),
        metros_lineales_tp: xlsx.cell(*Roo::Utils.extract_coordinate("H5")),
        metros_lineales_dim: xlsx.cell(*Roo::Utils.extract_coordinate("I5")),
        piezas_tp: xlsx.cell(*Roo::Utils.extract_coordinate("H4")),
        piezas_dim: xlsx.cell(*Roo::Utils.extract_coordinate("I4")),
      )

      idx = 10
      loop do
        row = xlsx.row(idx)
        break if [nil, ""].include? row[1]
        ot.posiciones << Posicion.new(row)
        idx += 1
      end

      ot
    end
  end
end
