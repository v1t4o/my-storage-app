require 'rails_helper'

describe 'Usuário cadastra um modelo de produto' do
  it 'com sucesso' do
    Supplier.create(fantasy_name: 'Cerâmicas Geek', legal_name: 'Geek Comercio de Ceramicas LTDA', eni: '32.451.879/0001-77', email: 'contato@geek.com')
    Supplier.create(fantasy_name: 'Fábrica de Camisetas', legal_name: 'Camisas BR ME')
    Category.create!(name: 'Utensílios')

    visit root_path
    click_on 'Cadastrar modelo de produto'
    fill_in 'Nome', with: 'Caneca Star Wars'
    fill_in 'Peso', with: 300
    fill_in 'Altura', with: '12'
    fill_in 'Largura', with: '8'
    fill_in 'Profundidade', with: '14'
    select 'Cerâmicas Geek', from: 'Fornecedor'
    select 'Utensílios', from: 'Categoria'
    click_on 'Gravar'

    expect(page).to have_content 'Modelo de produto registrado com sucesso'
    expect(page).to have_content 'Caneca Star Wars'
    expect(page).to have_content '300 gramas'
    expect(page).to have_content 'Dimensões: 12 x 8 x 14'
    expect(page).to have_content 'Fornecedor: Cerâmicas Geek'
  end

  it 'e não vê os produtos de outro fornecedor' do
    supplier = Supplier.create!(fantasy_name: 'Fábrica Geek', legal_name: 'Geek Comercio de Ceramicas LTDA', eni: '32.451.879/0001-77', address: 'Av Geek', email: 'contato@geek.com', phone: '51 3456-7890')
    other_supplier = Supplier.create!(fantasy_name: 'Canecas e Copos', legal_name: 'A Fantastica Fabrica de Canecas LTDA', eni: '45.896.325/0001-88', address: 'Av das Canecas', email: 'contato@canecas.com', phone: '11 4578-9986')
    category = Category.create!(name: 'Utensílios')

    ProductModel.create!(name: 'Pelúcia Dumbo', height: '50', width: '40', length: '20', weight: 400, supplier: supplier, category: category)
    ProductModel.create!(name: 'Caneca Star Wars', height: '14', width: '10', length: '8', weight: 300, supplier: other_supplier, category: category)

    visit root_path
    click_on 'Visualizar fornecedores'
    click_on 'Fábrica Geek'
    
    expect(page).to have_content 'Fábrica Geek'
    expect(page).to have_content 'Produtos deste fornecedor:'
    expect(page).to have_content 'Pelúcia Dumbo'
    expect(page).not_to have_content 'Caneca Star Wars'
  end
end