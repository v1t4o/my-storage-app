require 'rails_helper'

describe 'Usuário vê modelos de produtos' do
  it 'a partir de um link na tela inicial' do
    visit root_path
    click_on 'Visualizar modelos de produtos'

    expect(current_path).to eq product_models_path
  end

  it 'e vê todos os modelos de produtos cadastrados' do
    supplier = Supplier.create!(fantasy_name: 'Fábrica Geek', legal_name: 'Geek Comercio de Ceramicas LTDA', eni: '32.451.879/0001-77', address: 'Av Geek', email: 'contato@geek.com', phone: '51 3456-7890')
    other_supplier = Supplier.create!(fantasy_name: 'Canecas e Copos', legal_name: 'A Fantastica Fabrica de Canecas LTDA', eni: '45.896.325/0001-88', address: 'Av das Canecas', email: 'contato@canecas.com', phone: '11 4578-9986')
    category = Category.create!(name: 'Utensílios')
    ProductModel.create!(name: 'Pelúcia Dumbo', height: '50', width: '40', length: '20', weight: 400, supplier: supplier, category: category)
    ProductModel.create!(name: 'Caneca Star Wars', height: '14', width: '10', length: '8', weight: 300, supplier: other_supplier, category: category)
    
    visit root_path
    click_on 'Visualizar modelos de produtos'
    
    expect(page).to have_content 'Pelúcia Dumbo'
    expect(page).to have_content 'Fábrica Geek'
    expect(page).to have_content 'Caneca Star Wars'
    expect(page).to have_content 'Canecas e Copos'
  end

  it 'visualiza os modelos de produto de um fornecedor em específico' do
    supplier = Supplier.create!(fantasy_name: 'Fábrica Geek', legal_name: 'Geek Comercio de Ceramicas LTDA', eni: '32.451.879/0001-77', address: 'Av Geek', email: 'contato@geek.com', phone: '51 3456-7890')
    other_supplier = Supplier.create!(fantasy_name: 'Canecas e Copos', legal_name: 'A Fantastica Fabrica de Canecas LTDA', eni: '45.896.325/0001-88', address: 'Av das Canecas', email: 'contato@canecas.com', phone: '11 4578-9986')
    category = Category.create!(name: 'Utensílios')
    ProductModel.create!(name: 'Pelúcia Dumbo', height: '50', width: '40', length: '20', weight: 400, supplier: supplier, category: category)
    ProductModel.create!(name: 'Caneca Star Wars', height: '14', width: '10', length: '8', weight: 300, supplier: other_supplier, category: category)
    
    visit root_path
    click_on 'Visualizar modelos de produtos'
    fill_in 'Buscar por fornecedor:', with: 'Fábrica'
    click_on 'Filtrar'
    
    expect(page).to have_content 'Pelúcia Dumbo'
    expect(page).to have_content 'Fábrica Geek'
    expect(page).not_to have_content 'Caneca Star Wars'
    expect(page).not_to have_content 'Canecas e Copos'
  end
end