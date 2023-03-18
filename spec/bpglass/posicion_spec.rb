describe BPGlass::Posicion do
  let(:posicion_dimensionado) do
    array = [13,
             "230 - Semilla 04 mm",
             "",
             "",
             "1300104",
             "1",
             "600",
             "595",
             "V9.2C74",
             "5705",
             "DIM SEMILLA 4",
             "",
             "0.4",
             "2.4",
             "3.6",
             "DIM"]
    described_class.new(array)
  end
  let (:posicion_laminado) do
    array = [44,
             "100 - Incoloro 04 mm",
             "12 - Sep. 11.5 mm BR OSC",
             "350 - Laminado 3+3.1 Inc",
             "10012350",
             "1",
             "773",
             "254",
             "V01D205 TB.F2.A",
             "13775",
             "INC 4//Sep 11,5 BR OSC//LAM 6",
             "",
             "0.2",
             "2.1",
             "5.1",
             "TP"]

    described_class.new(array)
  end
  let(:posicion_saten) do
    array = [1,
             "100 - Incoloro 04 mm",
             "11 - Sep. 9.5 mm BR OSC",
             "260 - Saten 04 mm",
             "10011260",
             "1",
             "977",
             "825",
             "Depto 304",
             "43990",
             "INC 4//Sep 9,5 BR OSC//SATEN 4",
             "",
             "0.8",
             "3.6",
             "16.5",
             "TP"]

    described_class.new(array)
  end

  describe "#metros_cuadrados" do
    it { expect(posicion_saten.metros_cuadrados).to eq(0.8) }
  end

  describe "#metros_lineales" do
    it { expect(posicion_saten.metros_lineales).to eq(3.6) }
  end

  describe "#peso" do
    it { expect(posicion_saten.peso).to eq(16.5) }
  end

  describe "#piezas" do
    it { expect(posicion_saten.piezas).to eql(1) }
  end

  describe "#saten?" do
    it { expect(posicion_saten.saten?).to eq(true) }
    it { expect(posicion_laminado.saten?).to eq(false) }
  end

  describe "#laminado?" do
    it { expect(posicion_saten.laminado?).to eq(false) }
    it { expect(posicion_laminado.laminado?).to eq(true) }
  end
end
