require 'rails_helper'

describe 'Usuário edita um modelo de produto' do
  it 'através de um link na página do produto' do
    user = User.create!(email: 'joao@email.com', password: '12345678')    
    supplier = Supplier.create(fantasy_name: 'Cerâmicas Geek', legal_name: 'Geek Comercio de Ceramicas LTDA', eni: '32.451.879/0001-77', email: 'contato@geek.com')
    other_supplier = Supplier.create!(fantasy_name: 'Canecas e Copos', legal_name: 'A Fantastica Fabrica de Canecas LTDA', eni: '45.896.325/0001-88', address: 'Av das Canecas', email: 'contato@canecas.com', phone: '11 4578-9986')
    category = Category.create!(name: 'Utensílios')
    ProductModel.create!(name: 'Pelúcia Dumbo', height: '50', width: '40', length: '20', weight: 400, supplier: supplier, category: category)
    ProductModel.create!(name: 'Caneca Star Wars', height: '14', width: '10', length: '8', weight: 300, supplier: other_supplier, category: category)

    login_as(user, :scope => :user)
    visit root_path
    click_on 'Visualizar modelos de produtos'
    click_on 'Pelúcia Dumbo'
    click_on 'Editar'

    expect(page).to have_css('h2', text: 'Edição de modelo de produto')
    expect(page).to have_field 'Nome'
    expect(page).to have_field 'Peso'
    expect(page).to have_field 'Altura'
    expect(page).to have_field 'Largura'
    expect(page).to have_field 'Profundidade'
    expect(page).to have_field 'Fornecedor'
    expect(page).to have_field 'Categoria'
    expect(page).to have_button 'Gravar'
  end

  it 'com sucessso' do
    user = User.create!(email: 'joao@email.com', password: '12345678')    
    supplier = Supplier.create!(fantasy_name: 'Fábrica Geek', legal_name: 'Geek Comercio de Ceramicas LTDA', eni: '32.451.879/0001-77', address: 'Av Geek', email: 'contato@geek.com', phone: '51 3456-7890')
    other_supplier = Supplier.create!(fantasy_name: 'Canecas e Copos', legal_name: 'A Fantastica Fabrica de Canecas LTDA', eni: '45.896.325/0001-88', address: 'Av das Canecas', email: 'contato@canecas.com', phone: '11 4578-9986')
    category = Category.create!(name: 'Utensílios')
    ProductModel.create!(name: 'Pelúcia Dumbo', height: '50', width: '40', length: '20', weight: 400, supplier: supplier, category: category)
    ProductModel.create!(name: 'Caneca Star Wars', height: '14', width: '10', length: '8', weight: 300, supplier: other_supplier, category: category)
    
    login_as(user, :scope => :user)
    visit root_path
    click_on 'Visualizar modelos de produtos'
    click_on 'Pelúcia Dumbo'
    click_on 'Editar'

    fill_in 'Nome', with: 'Caneca Dumbo'
    fill_in 'Peso', with: 400
    fill_in 'Altura', with: '10'
    fill_in 'Largura', with: '9'
    fill_in 'Profundidade', with: '20'
    select 'Canecas e Copos', from: 'Fornecedor'
    select 'Utensílios', from: 'Categoria'
    click_on 'Gravar'

    expect(page).to have_content 'Modelo de produto alterado com sucesso'
    expect(page).to have_content 'Caneca Dumbo'
    expect(page).to have_content '400 gramas'
    expect(page).to have_content 'Dimensões: 10 x 9 x 20'
    expect(page).to have_content 'Fornecedor: Canecas e Copos'
  end

  it 'e todos os campos são obrigatórios' do
    user = User.create!(email: 'joao@email.com', password: '12345678')    
    supplier = Supplier.create!(fantasy_name: 'Fábrica Geek', legal_name: 'Geek Comercio de Ceramicas LTDA', eni: '32.451.879/0001-77', address: 'Av Geek', email: 'contato@geek.com', phone: '51 3456-7890')
    other_supplier = Supplier.create!(fantasy_name: 'Canecas e Copos', legal_name: 'A Fantastica Fabrica de Canecas LTDA', eni: '45.896.325/0001-88', address: 'Av das Canecas', email: 'contato@canecas.com', phone: '11 4578-9986')
    category = Category.create!(name: 'Utensílios')
    ProductModel.create!(name: 'Pelúcia Dumbo', height: '50', width: '40', length: '20', weight: 400, supplier: supplier, category: category)
    ProductModel.create!(name: 'Caneca Star Wars', height: '14', width: '10', length: '8', weight: 300, supplier: other_supplier, category: category)
    
    login_as(user, :scope => :user)
    visit root_path
    click_on 'Visualizar modelos de produtos'
    click_on 'Pelúcia Dumbo'
    click_on 'Editar'

    fill_in 'Nome', with: ''
    fill_in 'Peso', with: ''
    fill_in 'Altura', with: ''
    fill_in 'Largura', with: ''
    fill_in 'Profundidade', with: ''
    click_on 'Gravar'

    expect(page).to have_content 'Não foi possível alterar modelo de produto'
    expect(page).to have_content 'Nome não pode ficar em branco'
    expect(page).to have_content 'Peso não pode ficar em branco'
    expect(page).to have_content 'Altura não pode ficar em branco'
    expect(page).to have_content 'Largura não pode ficar em branco'
    expect(page).to have_content 'Profundidade não pode ficar em branco'
    expect(page).not_to have_content 'Modelo de produto alterado com sucesso'
  end
end