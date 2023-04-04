describe BPGlass do
  describe "#load_files" do
    let(:file_path) { "./spec/fixtures/Archivos AW" }
    it "loads all the files the target directory" do
      ots = BPGlass.load_files(file_path)
      expect(ots.count).to eq(30)
    end
  end

  context "sanity checks" do
    let(:ots) { BPGlass.load_files.sort_by!(&:id) }
    it "all OTs have a cliente" do
      expect(ots.map(&:cliente).none?(nil)).to eq(true)
    end
  end
end
