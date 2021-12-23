require 'rails_helper'

describe 'Usuário vê os detalhes de um fornecedor' do
  it 'com sucesso' do
    supplier = Supplier.create(fantasy_name: 'Cerâmicas Geek', legal_name: 'Geek Comercio de Ceramicas LTDA',
                               eni: '32.451.879/0001-77', address: 'Avenida Spider Man, 3',
                               email: 'geekceramicas@gmail.com', phone: '31 3456-7890')
    visit root_path
    click_on 'Visualizar fornecedores'
    click_on 'Cerâmicas Geek'

    expect(page).to have_content 'Cerâmicas Geek'
    expect(page).to have_content 'Razão Social: Geek Comercio de Ceramicas LTDA'
    expect(page).to have_content 'Avenida Spider Man, 3'
    expect(page).to have_content 'geekceramicas@gmail.com'
    expect(page).to have_content '31 3456-7890'
  end

  it 'e vê os produtos do fornecedor' do
    supplier = Supplier.create(fantasy_name: 'Cerâmicas Geek', legal_name: 'Geek Comercio de Ceramicas LTDA',
                               eni: '32.451.879/0001-77', address: 'Avenida Spider Man, 3',
                               email: 'geekceramicas@gmail.com', phone: '31 3456-7890')
    ProductModel.create!(name: 'Caneca Star Wars', height: '14', width: '10', length: '8', weight: 300, supplier: supplier)
    ProductModel.create!(name: 'Pelúcia Dumbo', height: '50', width: '40', length: '20', weight: 400, supplier: supplier)

    visit root_path
    click_on 'Visualizar fornecedores'
    click_on 'Cerâmicas Geek'

    expect(page).to have_css('h1', text: 'Cerâmicas Geek')
    expect(page).to have_css('h2', text: 'Produtos deste fornecedor:')
    expect(page).to have_content('Caneca Star Wars')
    expect(page).to have_content('Pelúcia Dumbo')
  end
end