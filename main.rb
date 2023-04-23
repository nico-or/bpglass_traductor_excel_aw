#! /bin/ruby

require "csv"
require_relative "lib/bpglass"

BASE_PATH = Pathname.new("./Archivos AW")
aw_files = Dir.children(BASE_PATH).map { |xlsx_file| BASE_PATH.join(xlsx_file) }.sort!

OUTPUT_FILENAME = "out.txt"
OUTPUT_FILE = CSV.open(OUTPUT_FILENAME, "w", col_sep: "\t") do |output_file|
  aw_files.each do |xlsx|
    puts "Processing: #{xlsx}"
    ot = BPGlass::OT.from_excel_import(xlsx)
    ot.output_arrays.each do |array|
      output_file << array
    end
  end
end
