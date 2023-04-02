#! /bin/ruby

require_relative "lib/bpglass"

BASE_PATH = Pathname.new("./Archivos AW")

filenames = Dir.children(BASE_PATH).map { |xlsx_file| BASE_PATH.join(xlsx_file) }

OUTPUT_FILENAME = "out.tsv"
OUTPUT_FILE = File.open(OUTPUT_FILENAME, "w") do |output_file|
  lines = filenames.first(10).each do |xlsx|
    puts "Processing: #{xlsx}"
    ot = BPGlass::OT.from_xlsx(xlsx)
    ot.to_tsv.each do |line|
      output_file.write(line + "\n")
    end
  end
end
