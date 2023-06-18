#! /bin/ruby

require "csv"
require "logger"
require_relative "lib/bpglass"

DEFAULT_DIR_PATH = Pathname.new("./Archivos AW")

# matches filenames like 30180-AW-27-06-2023.xlsx
BPGLASS_FILENAME_REGEX = /\d{5}-AW-\d{2}-\d{2}-\d{4}\.xlsx/

AW_FILENAMES = Dir.children(DEFAULT_DIR_PATH)
  .select { |filename| filename.match? BPGLASS_FILENAME_REGEX }
  .map { |filename| DEFAULT_DIR_PATH.join(filename) }.sort!

# file where OT output will be written
OUTPUT_FILENAME = "out.txt"

OUTPUT_FILE = CSV.open(OUTPUT_FILENAME, "w", col_sep: "\t") do |output_file|
  AW_FILENAMES.each do |aw_file|
    begin
      puts "Processing: #{aw_file}"
      ot = BPGlass::OT.from_excel_import(aw_file)
      ot.output_arrays.each do |array|
        output_file << array
      end
    rescue => exception
      puts exception
      puts "Error while processing #{aw_file}"
    end
  end
end
