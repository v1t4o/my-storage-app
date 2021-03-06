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
    p1 = ProductModel.create!(name: 'Pelúcia Dumbo', height: '50', width: '40', length: '20', weight: 400, supplier: supplier, category: category)
    p2 = ProductModel.create!(name: 'Caneca Star Wars', height: '14', width: '10', length: '8', weight: 300, supplier: other_supplier, category: category)
    
    visit root_path
    click_on 'Visualizar modelos de produtos'
    
    expect(page).to have_content 'Pelúcia Dumbo'
    expect(page).to have_content "#{p1.sku}"
    expect(page).to have_content 'Fábrica Geek'
    expect(page).to have_content 'Caneca Star Wars'
    expect(page).to have_content "#{p2.sku}"
    expect(page).to have_content 'Canecas e Copos'
  end

  it 'e não vê todos os detalhes de um modelo de produto' do
    supplier = Supplier.create!(fantasy_name: 'Fábrica Geek', legal_name: 'Geek Comercio de Ceramicas LTDA', eni: '32.451.879/0001-77', address: 'Av Geek', email: 'contato@geek.com', phone: '51 3456-7890')
    category = Category.create!(name: 'Utensílios')
    product_model = ProductModel.create!(name: 'Pelúcia Dumbo', height: '50', width: '40', length: '20', weight: 400, supplier: supplier, category: category)
    

    visit root_path
    click_on 'Visualizar modelos de produtos'

    expect(page).to have_css('td', text: 'Pelúcia Dumbo')
    expect(page).to have_css('td', text: "#{product_model.sku}")
    expect(page).to have_content('Fábrica Geek')
    expect(page).not_to have_content('50 x 40 x 20')
    expect(page).not_to have_content('400 gramas')
    expect(page).not_to have_content('Utensílios')
  end

  it 'busca os modelos de produto por nome' do
    supplier = Supplier.create!(fantasy_name: 'Fábrica Geek', legal_name: 'Geek Comercio de Ceramicas LTDA', eni: '32.451.879/0001-77', address: 'Av Geek', email: 'contato@geek.com', phone: '51 3456-7890')
    other_supplier = Supplier.create!(fantasy_name: 'Canecas e Copos', legal_name: 'A Fantastica Fabrica de Canecas LTDA', eni: '45.896.325/0001-88', address: 'Av das Canecas', email: 'contato@canecas.com', phone: '11 4578-9986')
    category = Category.create!(name: 'Utensílios')
    p1 = ProductModel.create!(name: 'Pelúcia Dumbo', height: '50', width: '40', length: '20', weight: 400, supplier: supplier, category: category)
    p2 = ProductModel.create!(name: 'Caneca Star Wars', height: '14', width: '10', length: '8', weight: 300, supplier: other_supplier, category: category)
    
    visit root_path
    click_on 'Visualizar modelos de produtos'
    fill_in 'Busca:', with: 'Pelúcia'
    click_on 'Filtrar'
    
    expect(page).to have_content 'Pelúcia Dumbo'
    expect(page).to have_content 'Fábrica Geek'
    expect(page).to have_content "#{p1.sku}"
    expect(page).not_to have_content 'Caneca Star Wars'
    expect(page).not_to have_content 'Canecas e Copos'
    expect(page).not_to have_content "#{p2.sku}"
  end

  it 'e busca um modelo de produto não existente' do
    supplier = Supplier.create!(fantasy_name: 'Fábrica Geek', legal_name: 'Geek Comercio de Ceramicas LTDA', eni: '32.451.879/0001-77', address: 'Av Geek', email: 'contato@geek.com', phone: '51 3456-7890')
    other_supplier = Supplier.create!(fantasy_name: 'Canecas e Copos', legal_name: 'A Fantastica Fabrica de Canecas LTDA', eni: '45.896.325/0001-88', address: 'Av das Canecas', email: 'contato@canecas.com', phone: '11 4578-9986')
    category = Category.create!(name: 'Utensílios')
    p1 = ProductModel.create!(name: 'Pelúcia Dumbo', height: '50', width: '40', length: '20', weight: 400, supplier: supplier, category: category)
    p2 = ProductModel.create!(name: 'Caneca Star Wars', height: '14', width: '10', length: '8', weight: 300, supplier: other_supplier, category: category)
    
    visit root_path
    click_on 'Visualizar modelos de produtos'
    fill_in 'Busca:', with: 'Vinho Tinto'
    click_on 'Filtrar'
    
    expect(current_path).to eq product_models_path
    expect(page).to have_content('Nenhum modelo de produto cadastrado')
    expect(page).not_to have_content 'Pelúcia Dumbo'
    expect(page).not_to have_content 'Fábrica Geek'
    expect(page).not_to have_content "#{p1.sku}"
    expect(page).not_to have_content 'Caneca Star Wars'
    expect(page).not_to have_content 'Canecas e Copos'
    expect(page).not_to have_content "#{p2.sku}"
  end

  it 'e não existem modelos de produtos cadastrados' do
    visit root_path
    click_on 'Visualizar modelos de produtos'
    
    expect(page).to have_content 'Nenhum modelo de produto cadastrado'
  end
end