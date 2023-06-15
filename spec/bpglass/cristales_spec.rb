describe BPGlass::Cristales do
  describe ".[]" do
    it "parses the BPGlass nomenclature" do
      id = "280 - Ecl. Adv . Clear 06 mm"
      cristal = BPGlass::Cristales[id]

      expect(cristal.id).to eq(280)
    end

    it "parses Bastro nomenclature" do
      id = "INC 4"
      cristal = BPGlass::Cristales[id]

      expect(cristal.id).to eq(100)
    end

    it "it returns the Cristal when quering with an integer" do
      id = 130
      cristal = BPGlass::Cristales[id]

      expect(cristal.id).to eq(130)
    end

    it "raises an ArgumentError when a string query has no match" do
      id = "foo"
      expect { BPGlass::Cristales[id] }.to raise_error(ArgumentError)
    end

    it "raises an ArgumentError when an integer query has no match" do
      id = 999
      expect { BPGlass::Cristales[id] }.to raise_error(ArgumentError)
    end

    it "returns nil for an empty string query" do
      id = ""
      expect(described_class[id]).to eq(nil)
    end
  end
end
