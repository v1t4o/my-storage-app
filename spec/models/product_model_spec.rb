require 'rails_helper'

RSpec.describe ProductModel, type: :model do
  it '.dimensions' do
    product_model = ProductModel.new(height: '14', width: '10', length: '12')

    result = product_model.dimensions()

    expect(result).to eq '14 x 10 x 12'
  end

  it 'name é obrigatório' do
    supplier = Supplier.create!(fantasy_name: 'Fábrica Geek', legal_name: 'Geek Comercio de Ceramicas LTDA', eni: '32.451.879/0001-77', address: 'Av Geek', email: 'contato@geek.com', phone: '51 3456-7890')
    category = Category.create!(name: 'Brinquedos')
    product_model = ProductModel.new(name: '', height: '50', width: '40', length: '20', weight: 400, supplier: supplier, category: category)

    result = product_model.valid?

    expect(result).to eq false
  end

  it 'weight é obrigatório' do
    supplier = Supplier.create!(fantasy_name: 'Fábrica Geek', legal_name: 'Geek Comercio de Ceramicas LTDA', eni: '32.451.879/0001-77', address: 'Av Geek', email: 'contato@geek.com', phone: '51 3456-7890')
    category = Category.create!(name: 'Utensílios')
    product_model = ProductModel.new(name: 'Pelúcia Dumbo', height: '50', width: '40', length: '20', weight: '', supplier: supplier, category: category)

    result = product_model.valid?

    expect(result).to eq false
  end

  it 'weight é igual a zero' do
    supplier = Supplier.create!(fantasy_name: 'Fábrica Geek', legal_name: 'Geek Comercio de Ceramicas LTDA', eni: '32.451.879/0001-77', address: 'Av Geek', email: 'contato@geek.com', phone: '51 3456-7890')
    category = Category.create!(name: 'Utensílios')
    product_model = ProductModel.new(name: 'Pelúcia Dumbo', height: '50', width: '40', length: '20', weight: 0, supplier: supplier, category: category)

    result = product_model.valid?

    expect(result).to eq false
  end

  it 'height é obrigatório' do
    supplier = Supplier.create!(fantasy_name: 'Fábrica Geek', legal_name: 'Geek Comercio de Ceramicas LTDA', eni: '32.451.879/0001-77', address: 'Av Geek', email: 'contato@geek.com', phone: '51 3456-7890')
    category = Category.create!(name: 'Utensílios')
    product_model = ProductModel.new(name: 'Pelúcia Dumbo', height: '', width: '40', length: '20', weight: 400, supplier: supplier, category: category)

    result = product_model.valid?

    expect(result).to eq false
  end

  it 'height é igual a zero' do
    supplier = Supplier.create!(fantasy_name: 'Fábrica Geek', legal_name: 'Geek Comercio de Ceramicas LTDA', eni: '32.451.879/0001-77', address: 'Av Geek', email: 'contato@geek.com', phone: '51 3456-7890')
    category = Category.create!(name: 'Utensílios')
    product_model = ProductModel.new(name: 'Pelúcia Dumbo', height: '0', width: '40', length: '20', weight: 400, supplier: supplier, category: category)

    result = product_model.valid?

    expect(result).to eq false
  end

  it 'length é obrigatório' do
    supplier = Supplier.create!(fantasy_name: 'Fábrica Geek', legal_name: 'Geek Comercio de Ceramicas LTDA', eni: '32.451.879/0001-77', address: 'Av Geek', email: 'contato@geek.com', phone: '51 3456-7890')
    category = Category.create!(name: 'Utensílios')
    product_model = ProductModel.new(name: 'Pelúcia Dumbo', height: '30', width: '40', length: '', weight: 400, supplier: supplier, category: category)

    result = product_model.valid?

    expect(result).to eq false
  end

  it 'length é igual a zero' do
    supplier = Supplier.create!(fantasy_name: 'Fábrica Geek', legal_name: 'Geek Comercio de Ceramicas LTDA', eni: '32.451.879/0001-77', address: 'Av Geek', email: 'contato@geek.com', phone: '51 3456-7890')
    category = Category.create!(name: 'Utensílios')
    product_model = ProductModel.new(name: 'Pelúcia Dumbo', height: '30', width: '40', length: '0', weight: 400, supplier: supplier, category: category)

    result = product_model.valid?

    expect(result).to eq false
  end

  it 'width é obrigatório' do
    supplier = Supplier.create!(fantasy_name: 'Fábrica Geek', legal_name: 'Geek Comercio de Ceramicas LTDA', eni: '32.451.879/0001-77', address: 'Av Geek', email: 'contato@geek.com', phone: '51 3456-7890')
    category = Category.create!(name: 'Utensílios')
    product_model = ProductModel.new(name: 'Pelúcia Dumbo', height: '30', width: '', length: '10', weight: 400, supplier: supplier, category: category)

    result = product_model.valid?

    expect(result).to eq false
  end

  it 'width é obrigatório' do
    supplier = Supplier.create!(fantasy_name: 'Fábrica Geek', legal_name: 'Geek Comercio de Ceramicas LTDA', eni: '32.451.879/0001-77', address: 'Av Geek', email: 'contato@geek.com', phone: '51 3456-7890')
    category = Category.create!(name: 'Utensílios')
    product_model = ProductModel.new(name: 'Pelúcia Dumbo', height: '30', width: '0', length: '10', weight: 400, supplier: supplier, category: category)

    result = product_model.valid?

    expect(result).to eq false
  end

  it 'código sku é gerado' do
    supplier = Supplier.create!(fantasy_name: 'Fábrica Geek', legal_name: 'Geek Comercio de Ceramicas LTDA', eni: '32.451.879/0001-77', address: 'Av Geek', email: 'contato@geek.com', phone: '51 3456-7890')
    category = Category.create!(name: 'Utensílios')
    product_model = ProductModel.new(name: 'Pelúcia Dumbo', height: '30', width: '10', length: '10', weight: 400, supplier: supplier, category: category)
    
    product_model.save()

    expect(product_model.sku).not_to eq nil
    expect(product_model.sku.length).to eq 20
  end

  it 'código sku é gerado randomicamente' do
    supplier = Supplier.create!(fantasy_name: 'Fábrica Geek', legal_name: 'Geek Comercio de Ceramicas LTDA', eni: '32.451.879/0001-77', address: 'Av Geek', email: 'contato@geek.com', phone: '51 3456-7890')
    category = Category.create!(name: 'Utensílios')
    product_model = ProductModel.new(name: 'Pelúcia Dumbo', height: '30', width: '10', length: '10', weight: 400, supplier: supplier, category: category)
    allow(SecureRandom).to receive(:alphanumeric).with(20).and_return 'T5eMsmZ8MYRUqhtMfCBj'

    product_model.save()

    expect(product_model.sku).to eq 'T5EMSMZ8MYRUQHTMFCBJ'
  end

  it 'código sku não é atualizado' do
    supplier = Supplier.create!(fantasy_name: 'Fábrica Geek', legal_name: 'Geek Comercio de Ceramicas LTDA', eni: '32.451.879/0001-77', address: 'Av Geek', email: 'contato@geek.com', phone: '51 3456-7890')
    category = Category.create!(name: 'Utensílios')
    product_model = ProductModel.new(name: 'Pelúcia Dumbo', height: '30', width: '10', length: '10', weight: 400, supplier: supplier, category: category)
    
    product_model.save()
    sku = product_model.sku

    product_model.update(name: 'Ursinho Poo')

    expect(product_model.name).to eq 'Ursinho Poo'
    expect(product_model.sku).to eq sku
  end

  it 'código sku é único' do
    supplier = Supplier.create!(fantasy_name: 'Fábrica Geek', legal_name: 'Geek Comercio de Ceramicas LTDA', eni: '32.451.879/0001-77', address: 'Av Geek', email: 'contato@geek.com', phone: '51 3456-7890')
    category = Category.create!(name: 'Utensílios')
    product_model = ProductModel.new(name: 'Pelúcia Dumbo', height: '30', width: '10', length: '10', weight: 400, supplier: supplier, category: category)
    product_model2 = ProductModel.new(name: 'Ursinho Poo', height: '30', width: '10', length: '10', weight: 400, supplier: supplier, category: category)

    product_model.save()
    sku = product_model.sku
    allow(SecureRandom).to receive(:alphanumeric).with(20).and_return sku.downcase!
    product_model2.save()

    expect(product_model2.sku).not_to eq sku
  end

end
