require 'rails_helper'

describe 'Usuário vê categorias' do
  
  it 'a partir de um link na tela inicial' do
    visit root_path
    click_on 'Visualizar categorias'

    expect(current_path).to eq categories_path
  end

  it 'e vê todas as categorias cadastradas' do
    Category.create!(name: 'Eletrônicos')
    Category.create!(name: 'Materiais de construção')
    Category.create!(name: 'Materiais escolares')
    Category.create!(name: 'Perfumaria')

    visit root_path
    click_on 'Visualizar categorias'

    expect(page).to have_content 'Eletrônicos'
    expect(page).to have_content 'Materiais de construção'
    expect(page).to have_content 'Materiais escolares'
    expect(page).to have_content 'Perfumaria'
  end

  it 'e vê todos os modelos de produtos da categoria cadastrada' do
    supplier = Supplier.create!(fantasy_name: 'Samsung', legal_name: 'Samsung LTDA', eni: '32.451.879/0001-77', address: 'Av Samsung', email: 'contato@samsung.com', phone: '51 3456-7890')
    category = Category.create!(name: 'Eletrônicos')
    ProductModel.create!(name: 'A21s', height: '50', width: '40', length: '20', weight: 400, supplier: supplier, category: category)
    ProductModel.create!(name: 'A50s', height: '50', width: '40', length: '20', weight: 400, supplier: supplier, category: category)
    ProductModel.create!(name: 'A30s', height: '50', width: '40', length: '20', weight: 400, supplier: supplier, category: category)

    visit root_path
    click_on 'Visualizar categorias'
    click_on 'Eletrônicos'

    expect(page).to have_content 'Modelos de produto'
    expect(page).to have_content 'A21s'
    expect(page).to have_content 'A50s'
    expect(page).to have_content 'A30s'
  end

end