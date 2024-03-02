describe BPGlass::ExcelParser::BPGlassParser do
  context 'reading a simple file' do
    let(:parser) do
      filepath = './spec/fixtures/27153-AW-18-01-2023.xlsx'
      described_class.new(filepath)
    end

    it 'returns the correct amount of posiciones' do
      expect(parser.posiciones.count).to eq(1)
    end

    it 'returns an Array of BPGlass::Posicion' do
      posiciones = parser.posiciones

      expect(posiciones).to be_an(Array)
      expect(posiciones).to all(be_a(BPGlass::Posicion))
    end
  end

  context 'reading a mixed TP and DIM file' do
    let(:parser) do
      filepath = './spec/fixtures/28586-AW-10-04-2023.xlsx'
      described_class.new(filepath)
    end

    it 'returns the correct amount of posiciones' do
      tp_position_count = 11
      dim_position_count = 2
      total_position_count = tp_position_count + dim_position_count

      expect(parser.posiciones.count).to eq(total_position_count)
    end
  end
end
