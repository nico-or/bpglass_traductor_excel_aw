describe BPGlass::Clientes do
  it "returns the alias if the YAML entry record exists" do
    fullname = "FABRICA DE PUERTAS Y VENTANAS RENOVA TEK LIMITADA"
    cliente_alias = "RENOVATEK"

    expect(described_class.alias(fullname)).to eq(cliente_alias)
  end

  it "returns the fullname if the YAML entry doesn't exists" do
    fullname = "not a real client name"

    expect(described_class.alias(fullname)).to eq(fullname)
  end
end
