# frozen_string_literal: true

require_relative 'lib/bpglass'

INPUT_DIR = 'input'
OUTPUT_DIR = 'output'

DEFAULT_EXTENSION = '*.xls'

INPUT_FILENAMES = Dir.glob(File.join(INPUT_DIR, DEFAULT_EXTENSION))

INPUT_FILENAMES.each do |filename|
  ot = BPGlass::ExcelParser::BastroParser.new(filename)
  writer = BPGlass::CsvWriter::CargaMasivaWriter.new(ot)

  basename = File.basename(filename, '.*')
  output_filename = File.join(OUTPUT_DIR, "#{basename}.tsv")

  File.open(output_filename, 'w') { |file| file.write(writer.to_csv) }
end
