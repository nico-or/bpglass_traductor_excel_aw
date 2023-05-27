require_relative "bpglass/constants"
require_relative "bpglass/ot"
require_relative "bpglass/posicion"
require_relative "bpglass/cliente"
require_relative "bpglass/excel_import"
require_relative "bpglass/numeric"
require_relative "bpglass/cristales"

module BPGlass
  def self.load_files(dir_path = "./Archivos AW")
    filepaths = Dir.glob("#{dir_path}/*.xlsx")
    filepaths.map { |filepath| OT.from_excel_import(filepath) }
  end
end
