describe BPGlass::OT do
  context "when creating from sample XLSX file" do
    let(:ot) { described_class.from_xlsx("./spec/fixtures/27153-AW-18-01-2023.xlsx") }

    describe "#id" do
      it "returns the OT number" do
        expect(ot.id).to eq("27153")
      end
    end

    describe "#obra" do
      it "returns the 'obra' name" do
        expect(ot.obra).to eq("San Eugenio. Depto. 304 URGENTE")
      end
    end

    describe "#cliente" do
      it "returns the 'cliente' name" do
        pending "TODO: Alias table for clientes"
        expect(ot.cliente).to eq("RENOVATEK")
      end
    end

    describe "#to_a" do
      it "returns the correct array structure" do
        output = [
          "27153",
          "San Eugenio. Depto. 304 URGENTE",
          "SAT(1)", "",
          "RENOVATEK",
          1, "", 1, "",
          "", "", "",
          0.8, Date.today.strftime("%d-%m-%y"), "", "", "18-01-2023", # "area", "today", "", "", "entrega",
          "", "",
          3.6, "", "", #"mtl tp", "", "mtl dim"
        ]

        expect(ot.to_a).to eq(output)
      end
    end
  end
end
