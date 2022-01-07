require 'rails_helper'

RSpec.describe ProductBundle, type: :model do
  it 'name é obrigatório' do
    supplier = Supplier.create!(fantasy_name: 'Fábrica Geek', legal_name: 'Geek Comercio de Ceramicas LTDA', eni: '32.451.879/0001-77', address: 'Av Geek', email: 'contato@geek.com', phone: '51 3456-7890')
    category = Category.create!(name: 'Bebidas')

    product_model = ProductModel.create!(name: 'Vinho Tinto', height: '50', width: '40', length: '20', weight: 400, supplier: supplier, category: category)

    product_bundle = ProductBundle.new(name: '', product_model_ids: [product_model.id])

    result = product_bundle.valid?

    expect(result).to eq false
  end

  it 'código sku é gerado' do
    supplier = Supplier.create!(fantasy_name: 'Fábrica Geek', legal_name: 'Geek Comercio de Ceramicas LTDA', eni: '32.451.879/0001-77', address: 'Av Geek', email: 'contato@geek.com', phone: '51 3456-7890')
    category = Category.create!(name: 'Bebidas')
    product_model = ProductModel.create!(name: 'Vinho Tinto', height: '50', width: '40', length: '20', weight: 400, supplier: supplier, category: category)
    product_bundle = ProductBundle.new(name: 'Kit Vinho Miolo', product_model_ids: [product_model.id])

    product_bundle.save()

    expect(product_bundle.sku).not_to eq nil
    expect(product_bundle.sku.length).to eq 21
  end

  it 'código sku é gerado randomicamente' do
    supplier = Supplier.create!(fantasy_name: 'Fábrica Geek', legal_name: 'Geek Comercio de Ceramicas LTDA', eni: '32.451.879/0001-77', address: 'Av Geek', email: 'contato@geek.com', phone: '51 3456-7890')
    category = Category.create!(name: 'Bebidas')
    product_model = ProductModel.create!(name: 'Vinho Tinto', height: '50', width: '40', length: '20', weight: 400, supplier: supplier, category: category)
    product_bundle = ProductBundle.new(name: 'Kit Vinho Miolo', product_model_ids: [product_model.id])

    allow(SecureRandom).to receive(:alphanumeric).with(20).and_return 'T5eMsmZ8MYRUqhtMfCBj'

    product_bundle.save()

    expect(product_bundle.sku).to eq 'KT5EMSMZ8MYRUQHTMFCBJ'
  end

  it 'código sku não é atualizado' do
    supplier = Supplier.create!(fantasy_name: 'Fábrica Geek', legal_name: 'Geek Comercio de Ceramicas LTDA', eni: '32.451.879/0001-77', address: 'Av Geek', email: 'contato@geek.com', phone: '51 3456-7890')
    category = Category.create!(name: 'Bebidas')
    product_model = ProductModel.create!(name: 'Vinho Tinto', height: '50', width: '40', length: '20', weight: 400, supplier: supplier, category: category)
    product_bundle = ProductBundle.new(name: 'Kit Vinho Miolo', product_model_ids: [product_model.id])

    product_bundle.save()
    sku = product_bundle.sku()

    product_bundle.update(name: 'Kit Vinho de Inverno')

    expect(product_bundle.name).to eq 'Kit Vinho de Inverno'
    expect(product_bundle.sku).to eq sku
  end

  it 'código sku é único' do
    supplier = Supplier.create!(fantasy_name: 'Fábrica Geek', legal_name: 'Geek Comercio de Ceramicas LTDA', eni: '32.451.879/0001-77', address: 'Av Geek', email: 'contato@geek.com', phone: '51 3456-7890')
    category = Category.create!(name: 'Bebidas')
    product_model = ProductModel.create!(name: 'Vinho Tinto', height: '50', width: '40', length: '20', weight: 400, supplier: supplier, category: category)
    product_bundle1 = ProductBundle.new(name: 'Kit Vinho Miolo', product_model_ids: [product_model.id])
    product_bundle2 = ProductBundle.new(name: 'Kit Vinho de Inverno', product_model_ids: [product_model.id])

    product_bundle1.save()
    sku = product_bundle1.sku.downcase!
    sku.slice!(0)
    allow(SecureRandom).to receive(:alphanumeric).with(20).and_return sku
    product_bundle2.save()

    expect(product_bundle2.sku).not_to eq product_bundle1.sku
  end
end
