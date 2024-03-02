describe BPGlass::Clientes do
  it 'returns the alias if the YAML entry record exists' do
    fullname = 'FABRICA DE PUERTAS Y VENTANAS RENOVA TEK LIMITADA'
    cliente_alias = 'RENOVATEK'

    expect(described_class.alias(fullname)).to eq(cliente_alias)
  end

  it "returns the raw cliente name if the YAML entry doesn't exists" do
    cliente_name = 'not found'
    expect(described_class.alias(cliente_name)).to eq(cliente_name)
  end
end
