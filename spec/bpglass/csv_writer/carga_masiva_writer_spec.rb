describe BPGlass::CsvWriter::CargaMasivaWriter do
  context "pedido BPGlass simple" do
    let(:csv_writer) do
      filepath = "./spec/fixtures/27153-AW-18-01-2023.xlsx"
      ot = BPGlass::OT.from_excel_import(filepath)
      described_class.new(ot)
    end

    it "returns the correct CSV lines" do
      expected_output = [
        described_class::CSV_HEADERS,
        [1,
         977,
         825,
         "INC 4",
         "SATEN 4",
         nil,
         "Sep 9,5",
         "BR OSC",
         nil,
         nil,
         nil,
         nil,
         nil,
         nil,
         "Depto 304"],
      ].map { _1.to_csv(col_sep: "\t") }.join

      csv = csv_writer.to_csv

      expect(csv).to eq(expected_output)
    end
  end
end
