#! /bin/ruby

require "csv"
require_relative "lib/bpglass"

BASE_PATH = Pathname.new("./Archivos AW")
aw_files = Dir.children(BASE_PATH).map { |xlsx_file| BASE_PATH.join(xlsx_file) }.sort!

OUTPUT_FILENAME = "out.csv"
OUTPUT_FILE = CSV.open(OUTPUT_FILENAME, "w") do |output_file|
  aw_files.each do |xlsx|
    puts "Processing: #{xlsx}"
    ot = BPGlass::OT.from_xlsx(xlsx)
    ot.output_arrays.each do |array|
      output_file << array
    end
  end
end
