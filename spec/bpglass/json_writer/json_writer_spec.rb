# frozen_string_literal: true

describe BPGlass::JsonWriter::JsonWriter do
  context 'pedido con una posicion' do
    let(:json_writer) do
      filepath = './spec/fixtures/27153-AW-18-01-2023.xlsx'
      ot = BPGlass::OT.from_excel_import(filepath)
      described_class.new(ot)
    end

    it 'writes correct json output' do
      output = JSON.generate(
        {
          id: '27153',
          obra: 'San Eugenio. Depto. 304 URGENTE',
          cliente: 'RENOVATEK',
          fecha_despacho: '18-01-2023',
          posiciones: [
            {
              vidrio_1: 'INC 4',
              vidrio_2: 'SATEN 4',
              separador: {
                medida: 9.5,
                color: 'bronce_oscuro'
              },
              cantidad: 1,
              ancho: 977,
              alto: 825
            }
          ]
        }
      )

      expect(json_writer.to_json).to eq(output)
    end
  end
end
