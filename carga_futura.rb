#! /bin/ruby

require_relative 'lib/bpglass'

DEFAULT_DIR_PATH = Pathname.new('./Archivos AW')

# matches filenames like 30180-AW-27-06-2023.xlsx
BPGLASS_FILENAME_REGEX = /\d{5}-AW-\d{2}[-_]\d{2}[-_]\d{4}\.xlsx/.freeze

AW_FILENAMES = Dir.children(DEFAULT_DIR_PATH)
                  .select { |filename| filename.match? BPGLASS_FILENAME_REGEX }
                  .map { |filename| DEFAULT_DIR_PATH.join(filename) }.sort

# file where OT output will be written
OUTPUT_FILENAME = 'carga_futura.txt'

File.open(OUTPUT_FILENAME, 'w') do |output_file|
  AW_FILENAMES.each do |aw_file|
    puts "Processing: #{aw_file}"
    begin
      ot = BPGlass::OT.from_excel_import(aw_file)
      writer = BPGlass::CsvWriter::CargaFuturaWriter.new(ot)
      output_file.write(writer.to_csv)
    rescue StandardError => e
      puts "Error while processing: #{aw_file}"
      puts e
    end
  end
end
