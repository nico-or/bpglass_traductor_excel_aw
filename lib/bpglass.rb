require "roo"

require_relative "bpglass/constants"
require_relative "bpglass/ot"
require_relative "bpglass/posicion"

module BPGlass
  def self.load_files(dir_path = "./Archivos AW")
    filepaths = Dir.glob("#{dir_path}/*.xlsx")
    filepaths.map { |filepath| OT.from_xlsx(filepath) }
  end
end
