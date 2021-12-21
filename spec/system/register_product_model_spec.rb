require 'rails_helper'

describe 'Usuário cadastra um modelo de produto' do
  it 'com sucesso' do
    Supplier.create(fantasy_name: 'Cerâmicas Geek', legal_name: 'Geek Comercio de Ceramicas LTDA', eni: '32.451.879/0001-77', email: 'contato@geek.com')
    Supplier.create(fantasy_name: 'Fábrica de Camisetas', legal_name: 'Camisas BR ME')

    visit root_path
    click_on 'Cadastrar modelo de produto'
    fill_in 'Nome', with: 'Caneca Star Wars'
    fill_in 'Peso', with: 300
    fill_in 'Altura', with: '12'
    fill_in 'Largura', with: '8'
    fill_in 'Produndidade', with: '14'
    fill_in 'Código SKU', with: 'CN203040ABC'
    select 'Cerâmicas Geek', from: 'Fornecedor'
    click_on 'Gravar'

    expect(page).to have_content 'Modelo de produto registrado com sucesso'
    expect(page).to have_content 'Caneca Star Wars'
    expect(page).to have_content '300 gramas'
    expect(page).to have_content 'Dimensões: 12 x 8 x 14'
    expect(page).to have_content 'SKU: CN203040ABC'
    expect(page).to have_content 'Fornecedor: Cerâmicas Geek'
  end
end