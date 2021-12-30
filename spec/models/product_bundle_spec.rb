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
end
