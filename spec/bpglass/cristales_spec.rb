describe BPGlass::Cristales do
  describe ".[]" do
    it " returns a Cristal object" do
      id = 350
      cristal = BPGlass::Cristales[id]

      expect(cristal.class).to eq(Struct::Cristal)
    end
  end
end
