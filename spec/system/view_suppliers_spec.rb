require 'rails_helper'

describe 'Usuário vê fornecedores' do
  it 'através de um link na tela inicial' do
    visit root_path

    expect(page).to have_link('Visualizar fornecedores', href: suppliers_path)
  end

  it 'cadastrados previamente' do
    Supplier.create(fantasy_name: 'Samsung', legal_name: 'Samsung do BR LTDA',
                    eni: '32.451.879/0001-77', address: 'Av Industrial, 1000, São Paulo',
                    email: 'financeiro@samsung.com.br', phone: '11 1234-5678')
    Supplier.create(fantasy_name: 'LG', legal_name: 'LG do Brasil LTDA',
                    eni: '32.451.458/0001-77', address: 'Av Industrial, 2000, São Paulo',
                    email: 'vendas@lg.com.br', phone: '21 9876-4321')

    visit root_path
    click_on 'Visualizar fornecedores'

    expect(page).to have_content 'Samsung'
    expect(page).to have_content '32.451.879/0001-77'
    expect(page).to have_content 'LG'
    expect(page).to have_content '32.451.458/0001-77'
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

    expect(page).to have_css('h2', text: 'Fábrica Geek')
    expect(page).to have_css('h4', text: 'Produtos deste fornecedor:')
    expect(page).to have_content('Pelúcia Dumbo')
    expect(page).not_to have_content('Caneca Star Wars')
  end

  it 'e não vê todos os detalhes de um fornecedor' do
    Supplier.create!(fantasy_name: 'Fábrica Geek', legal_name: 'Geek Comercio de Ceramicas LTDA', eni: '32.451.879/0001-77', address: 'Av Geek', email: 'contato@geek.com', phone: '51 3456-7890')


    visit root_path
    click_on 'Visualizar fornecedores'

    expect(page).to have_css('td', text: 'Fábrica Geek')
    expect(page).to have_css('td', text: '32.451.879/0001-77')
    expect(page).not_to have_content('Geek Comercio de Ceramicas LTDA')
    expect(page).not_to have_content('Av Geek')
    expect(page).not_to have_content('contato@geek.com')
    expect(page).not_to have_content('51 3456-7890')
  end

  it 'e consegue pesquisar um fornecedor pelo nome' do
    Supplier.create!(fantasy_name: 'Fábrica Geek', legal_name: 'Geek Comercio de Ceramicas LTDA', eni: '32.451.879/0001-77', address: 'Av Geek', email: 'contato@geek.com', phone: '51 3456-7890')
    Supplier.create!(fantasy_name: 'Canecas e Copos', legal_name: 'A Fantastica Fabrica de Canecas LTDA', eni: '45.896.325/0001-88', address: 'Av das Canecas', email: 'contato@canecas.com', phone: '11 4578-9986')

    visit root_path
    click_on 'Visualizar fornecedores'
    fill_in 'Busca:', with: 'Fáb'
    click_on 'Filtrar'

    expect(current_path).to eq suppliers_path
    expect(page).to have_content('Fábrica Geek')
    expect(page).not_to have_content('Canecas e Copos')
  end

  it 'e pesquisa por um fornecedor não existente' do
    Supplier.create!(fantasy_name: 'Fábrica Geek', legal_name: 'Geek Comercio de Ceramicas LTDA', eni: '32.451.879/0001-77', address: 'Av Geek', email: 'contato@geek.com', phone: '51 3456-7890')
    Supplier.create!(fantasy_name: 'Canecas e Copos', legal_name: 'A Fantastica Fabrica de Canecas LTDA', eni: '45.896.325/0001-88', address: 'Av das Canecas', email: 'contato@canecas.com', phone: '11 4578-9986')

    visit root_path
    click_on 'Visualizar fornecedores'
    fill_in 'Busca:', with: 'Vinícola'
    click_on 'Filtrar'

    expect(current_path).to eq suppliers_path
    expect(page).to have_content('Nenhum fornecedor cadastrado')
    expect(page).not_to have_content('Fábrica Geek')
    expect(page).not_to have_content('Canecas e Copos')
  end

  it 'e não existem fornecedores' do
    visit root_path
    click_on 'Visualizar fornecedores'
    
    expect(page).to have_content 'Nenhum fornecedor cadastrado'
  end
end