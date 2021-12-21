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

  it 'e não existem fornecedores' do
    visit root_path
    click_on 'Visualizar fornecedores'
    expect(page).to have_content 'Nenhum fornecedor cadastrado'
  end
end