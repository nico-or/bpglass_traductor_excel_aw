describe BPGlass::Posicion do
  context "TP incoloro" do
    let(:posicion) do
      input = [
        1,
        "100 - Incoloro 04 mm",
        "12 - Sep. 11.5 mm BR OSC",
        "100 - Incoloro 04 mm",
        "10012100",
        "1",
        "773",
        "254",
        "V01D205 TB.F2.A",
        "13775",
        "INC 4//Sep 11,5 BR OSC//INC 4",
        "",
        "0.2",
        "2.1",
        "5.1",
        "TP",
      ]
      described_class.new(input)
    end

    describe "#posicion" do
      it { expect(posicion.posicion).to eq(1) }
    end

    describe "#vidrio_1" do
      it { expect(posicion.vidrio_1).to eq(100) }
    end

    describe "#separador" do
      it { expect(posicion.separador).to eq(12) }
    end

    describe "#vidrio_2" do
      it { expect(posicion.vidrio_2).to eq(100) }
    end

    describe "#producto" do
      it { expect(posicion.producto).to eq(10012100) }
    end

    describe "#piezas" do
      it { expect(posicion.piezas).to eql(1) }
    end

    describe "#ancho" do
      it { expect(posicion.ancho).to eq(773) }
    end

    describe "#alto" do
      it { expect(posicion.alto).to eq(254) }
    end

    describe "#metros_cuadrados" do
      it { expect(posicion.metros_cuadrados).to eq(0.2) }
    end

    describe "#metros_lineales" do
      it { expect(posicion.metros_lineales).to eq(2.1) }
    end
  end
end
