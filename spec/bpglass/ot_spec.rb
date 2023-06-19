describe BPGlass::OT do
  context "pedido simple" do
    let(:ot) { described_class.from_excel_import("./spec/fixtures/27153-AW-18-01-2023.xlsx") }

    describe "#id" do
      it "returns the OT number" do
        expect(ot.id).to eq("27153")
      end
    end

    describe "#cliente" do
      it "returnts the cliente alias" do
        expect(ot.cliente).to eq("RENOVATEK")
      end
    end

    describe "#obra" do
      it "returns the 'obra' name" do
        expect(ot.obra).to eq("San Eugenio. Depto. 304 URGENTE")
      end
    end

    describe "#posiciones" do
      it "has correct position count" do
        expect(ot.posiciones.count).to eq(1)
      end

      it do
        ot.posiciones.each do |posicion|
          expect(posicion.class).to eq(BPGlass::Posicion)
        end
      end
    end

    describe "#cristal_especial" do
      it do
        expect(ot.cristal_especial).to eq("SAT(1)")
      end
    end

    describe "#metros_cuadrados_tp" do
      it { expect(ot.metros_cuadrados_tp).to be_within(0.1).of(0.8) }
    end

    describe "#metros_lineales_tp" do
      it { expect(ot.metros_lineales_tp).to be_within(0.1).of(3.6) }
    end
  end

  context "pedido grande" do
    let(:ot) { described_class.from_excel_import("./spec/fixtures/27135-AW-02-02-2023.xlsx") }

    describe "#from_excel_import" do
      it { expect(ot.piezas_tp).to eq(108) }
      it { expect(ot.piezas_dim).to eq(0) }
      it { expect(ot.posiciones.count).to eq(78) }
    end

    describe "#cristal_especial" do
      it do
        output = "LAM6(31) SAT(4)"
        expect(ot.cristal_especial).to eq(output)
      end
    end
  end

  context "pedido con dimensionado" do
    let(:ot) { described_class.from_excel_import("./spec/fixtures/27138-AW-23-01-2023.xlsx") }

    describe "#initialize" do
      it "creates the correct amount of posiciones" do
        expect(ot.posiciones.count).to eq(48)
      end
    end
  end
end
