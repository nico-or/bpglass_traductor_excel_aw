describe BPGlass::CsvWriter::PlanificacionWriter do
  context 'pedido con dimensionado' do
    let(:csv_writer) do
      filepath = './spec/fixtures/27138-AW-23-01-2023.xlsx'
      ot = BPGlass::OT.from_excel_import(filepath)
      described_class.new(ot)
    end

    it 'returns the correct CSV lines' do
      expected_output = [
        '27138',
        'HC LOS NOGALES, CASTAÑOS, CASAS 4,52,48,46',
        'SAT4(2)', nil,
        'RENOVATEK',
        44, nil, 44, nil,
        nil, nil, nil,
        '31,0', Date.today.strftime('%d-%m-%Y'), nil, nil, '23-01-2023',
        nil, nil,
        '159,3', nil, nil
      ].to_csv(col_sep: "\t") << [
        '27138',
        'HC LOS NOGALES, CASTAÑOS, CASAS 4,52,48,46',
        'DIMENSIONADO', nil,
        'RENOVATEK',
        nil, 8, nil, 8,
        nil, nil, nil,
        '2,1', Date.today.strftime('%d-%m-%Y'), nil, nil, '23-01-2023',
        nil, nil,
        nil, nil, '16,5'
      ].to_csv(col_sep: "\t")

      csv = csv_writer.to_csv
      expect(csv).to eq(expected_output)
    end
  end

  context 'pedido con forma' do
    let(:csv_writer) do
      filepath = './spec/fixtures/25766-AW-03-11-2022.xlsx'
      ot = BPGlass::OT.from_excel_import(filepath)
      described_class.new(ot)
    end

    it 'returns the correct CSV lines' do
      expected_output = [
        '25766',
        'RTK 5558 HC AYLEEN DUARTE',
        'CLEAR(3)', 'FORMA(3)',
        'RENOVATEK',
        13, nil, 13, nil,
        nil, nil, nil,
        '8,2', Date.today.strftime('%d-%m-%Y'), nil, nil, '03-11-2022',
        nil, nil,
        '37,8', nil, nil
      ].to_csv(col_sep: "\t")

      csv = csv_writer.to_csv
      expect(csv).to eq(expected_output)
    end
  end

  context 'pedido con palillaje' do
    let(:csv_writer) do
      filepath = './spec/fixtures/28665-AW-11-04-2023.xlsx'
      ot = BPGlass::OT.from_excel_import(filepath)
      described_class.new(ot)
    end

    it 'returns the correct CSV lines' do
      expected_output = [
        '28665',
        'BST 15784 PIRQUE PALILLO VEKA NEGRO SPECTRAL',
        'SAT4(7)', 'PALILLAJE(8)',
        'BASTRO',
        45, nil, 45, nil,
        nil, nil, nil,
        '79,4', Date.today.strftime('%d-%m-%Y'), nil, nil, '11-04-2023',
        nil, nil,
        '244,7', nil, nil
      ].to_csv(col_sep: "\t")

      csv = csv_writer.to_csv
      expect(csv).to eq(expected_output)
    end
  end

  context 'pedido con doble cristal especial' do
    let(:csv_writer) do
      filepath = './spec/fixtures/bpglass_doble_especial.xlsx'
      ot = BPGlass::OT.from_excel_import(filepath)
      described_class.new(ot)
    end

    describe '#to_csv' do
      it 'returns the correct output' do
        expected_output = [
          '30211',
          'RES. BRITANICA',
          'LAM6(12)', nil,
          'PATRICIO ESPINOSA',
          12, nil, 12, nil,
          nil, nil, nil,
          '18,3', Date.today.strftime('%d-%m-%Y'), nil, nil, '23-06-2023',
          nil, nil,
          '71,4', nil, nil
        ].to_csv(col_sep: "\t")

        csv = csv_writer.to_csv
        expect(csv).to eq(expected_output)
      end
    end
  end

  context 'pedido con formas y plantillas' do
    let(:csv_writer) do
      filepath = './spec/fixtures/bpglass_forma_plantilla.xlsx'
      ot = BPGlass::OT.from_excel_import(filepath)
      described_class.new(ot)
    end

    it 'returns the correct CSV lines' do
      expected_output = [
        '25766',
        'RTK 5558 HC AYLEEN DUARTE',
        nil, 'FORMA(3) PLANTILLA(2)',
        'RENOVATEK',
        13, nil, 13, nil,
        nil, nil, nil,
        '8,2', Date.today.strftime('%d-%m-%Y'), nil, nil, '03-11-2022',
        nil, nil,
        '37,8', nil, nil
      ].to_csv(col_sep: "\t")

      csv = csv_writer.to_csv
      expect(csv).to eq(expected_output)
    end
  end
end
