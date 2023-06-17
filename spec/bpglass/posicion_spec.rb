describe BPGlass::Posicion do
  context "single TP" do
    let(:posicion) do
      described_class.new(vidrio_1: "100 - Incoloro 04 mm",
                          vidrio_2: "260 - Saten 04 mm",
                          cantidad: "1",
                          ancho: "977",
                          alto: 825)
    end

    it { expect(posicion.vidrio_1).to eq(BPGlass::Cristales[100]) }
    it { expect(posicion.vidrio_2).to eq(BPGlass::Cristales[260]) }
    it { expect(posicion.cantidad).to eql(1) }
    it { expect(posicion.ancho).to eq(977) }
    it { expect(posicion.alto).to eq(825) }
    it { expect(posicion.metros_cuadrados).to be_within(0.1).of(0.8) }
    it { expect(posicion.metros_lineales).to be_within(0.1).of(3.6) }
    it { expect(posicion.tp?).to eq(true) }
    it { expect(posicion.dim?).to eq(false) }
    it { expect(posicion.forma?).to eq(false) }
  end

  context "multiple TP" do
    let(:posicion) do
      described_class.new(vidrio_1: "100 - Incoloro 04 mm",
                          vidrio_2: "260 - Saten 04 mm",
                          cantidad: 2,
                          ancho: "977",
                          alto: 825)
    end

    it { expect(posicion.cantidad).to eql(2) }
    it { expect(posicion.ancho).to eq(977) }
    it { expect(posicion.alto).to eq(825) }
    it { expect(posicion.metros_cuadrados).to be_within(0.1).of(1.6) }
    it { expect(posicion.metros_lineales).to be_within(0.1).of(7.2) }
  end

  context "DIM" do
    let(:posicion) do
      described_class.new(vidrio_1: "230 - Semilla 04 mm",
                          cantidad: 1,
                          ancho: 600,
                          alto: 605)
    end

    it { expect(posicion.vidrio_1).to eq(BPGlass::Cristales[230]) }
    it { expect(posicion.vidrio_2).to eq(nil) }
    it { expect(posicion.cantidad).to eql(1) }
    it { expect(posicion.ancho).to eq(600) }
    it { expect(posicion.alto).to eq(605) }
    it { expect(posicion.metros_cuadrados).to be_within(0.1).of(0.4) }
    it { expect(posicion.metros_lineales).to be_within(0.1).of(2.4) }
    it { expect(posicion.tp?).to eq(false) }
    it { expect(posicion.dim?).to eq(true) }
    it { expect(posicion.forma?).to eq(false) }
  end

  context "Forma" do
    let(:posicion) do
      described_class.new(vidrio_1: "110 - Incoloro 05 mm",
                          vidrio_2: "280 - Ecl. Adv . Clear 06 mm",
                          separador: "12 - Sep. 11.5 mm BR OSC",
                          cantidad: 2,
                          ancho: 645,
                          alto: 1850,
                          forma: "F1")
    end

    it { expect(posicion.tp?).to eq(true) }
    it { expect(posicion.dim?).to eq(false) }
    it { expect(posicion.forma?).to eq(true) }
  end

  describe ".from_hash" do
    context "TP hash" do
      let(:posicion) do
        hash = {
          vidrio_1: 100,
          vidrio_2: "INC 4",
          separador: "",
          cantidad: 0,
          ancho: 0,
          alto: 0,
        }

        described_class.new(hash)
      end

      it { expect(posicion.vidrio_1).to eq(BPGlass::Cristales[100]) }
      it { expect(posicion.vidrio_1).to eq(BPGlass::Cristales[100]) }
    end
  end
end
