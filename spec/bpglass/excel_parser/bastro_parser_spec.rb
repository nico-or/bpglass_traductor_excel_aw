describe BPGlass::ExcelParser::BastroParser do
  let(:parser) do
    filepath = './spec/fixtures/excel_parser/pedido_bastro.xls'
    described_class.new(filepath)
  end

  describe '#posiciones' do
    let(:posiciones) { parser.posiciones }

    it 'has the correct amount of posiciones' do
      expect(posiciones.count).to eq(44)
    end

    it 'has the correct amount of TPs' do
      expect(posiciones.sum(&:cantidad)).to eq(48)
    end

    it 'has the correct amount of formas' do
      formas = posiciones.select(&:forma?)

      expect(formas.count).to eq(7)
      expect(formas.sum(&:cantidad)).to eq(8)
    end
  end

  describe '#ot' do
    let(:ot) { parser.ot }

    it 'has the correct obra name' do
      expect(ot.obra).to eq('BST 19066 CONDO. PARQUE CACHAGUA')
    end
  end
end
