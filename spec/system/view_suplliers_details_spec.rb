require 'rails_helper'

describe 'Usuário vê um fornecedor' do
  it 'e consegue voltar para tela inicial' do
    supplier = Supplier.create(fantasy_name: 'Cerâmicas Geek', legal_name: 'Geek Comercio de Ceramicas LTDA',
                               eni: '32.451.879/0001-77', address: 'Avenida Spider Man, 3',
                               email: 'geekceramicas@gmail.com', phone: '31 3456-7890')
    
    visit root_path
    click_on 'Visualizar fornecedores'
    click_on 'Cerâmicas Geek'
    click_on 'Voltar'

    expect(current_path).to eq suppliers_path
  end

  it 'e vê todos os dados cadastrados' do
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
    category = Category.create!(name: 'Utensílios')
    ProductModel.create!(name: 'Caneca Star Wars', height: '14', width: '10', length: '8', weight: 300, supplier: supplier, category: category)
    ProductModel.create!(name: 'Pelúcia Dumbo', height: '50', width: '40', length: '20', weight: 400, supplier: supplier, category: category)

    visit root_path
    click_on 'Visualizar fornecedores'
    click_on 'Cerâmicas Geek'

    expect(page).to have_css('h2', text: 'Cerâmicas Geek')
    expect(page).to have_css('h4', text: 'Produtos deste fornecedor:')
    expect(page).to have_content('Caneca Star Wars')
    expect(page).to have_content('Pelúcia Dumbo')
  end

  it 'não existente' do
    visit supplier_path(777)

    expect(page).to have_content('Objeto não encontrado')
  end
end