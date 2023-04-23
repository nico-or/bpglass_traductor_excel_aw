describe BPGlass::ExcelImport do
  describe "#ot" do
    it "generates an OT object" do
      filepath = "spec/fixtures/25766-AW-03-11-2022.xlsx"
      ot = described_class.ot(filepath)
      expect(ot).to be_an(BPGlass::OT)
    end
  end
end
