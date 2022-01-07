require 'rails_helper'

describe 'Usuário edita um fornecedor' do
  it 'através de um link na index de fornecedor' do
    user = User.create!(email: 'joao@email.com', password: '12345678')
    
    supplier1 = Supplier.create!(fantasy_name: 'Samsung', legal_name: 'Samsung do BR LTDA',
                            eni: '32.451.879/0001-77', address: 'Av Industrial, 1000, São Paulo',
                            email: 'financeiro@samsung.com.br', phone: '11 1234-5678')

    supplier2 = Supplier.create!(fantasy_name: 'Xiaomi', legal_name: 'Xiaomi do BR LTDA',
                              eni: '45.125.895/0001-88', address: 'Av Industrial, 1000, São Paulo',
                              email: 'financeiro@xiaomi.com.br', phone: '11 1234-5678')
    
    login_as(user, :scope => :user)
    visit root_path
    click_on 'Visualizar fornecedores'
    click_on 'Editar', id: "edit-#{supplier1.id}"

    expect(current_path).to eq edit_supplier_path(supplier1.id)
    expect(page).to have_css('h2', text: 'Edição de fornecedor')
    expect(page).to have_field 'Nome Fantasia'
    expect(page).to have_field 'Razão Social'
    expect(page).to have_field 'CNPJ'
    expect(page).to have_field 'Endereço'
    expect(page).to have_field 'E-mail'
    expect(page).to have_field 'Telefone'
  end

  it 'com sucessso' do
    user = User.create!(email: 'joao@email.com', password: '12345678')
    supplier = Supplier.create!(fantasy_name: 'Samsung', legal_name: 'Samsung do BR LTDA',
                            eni: '32.451.879/0001-77', address: 'Av Industrial, 1000, São Paulo',
                            email: 'financeiro@samsung.com.br', phone: '11 1234-5678')

    login_as(user, :scope => :user)
    visit root_path
    click_on 'Visualizar fornecedores'
    click_on 'Editar', id: "edit-#{supplier.id}"
    fill_in 'Nome Fantasia', with: 'Samsung Infinity'
    fill_in 'Razão Social', with: 'Samsung Infinity LTDA'
    fill_in 'CNPJ', with: '32.451.879/0001-77'
    fill_in 'Endereço', with: 'Av Rio Branco, 1022 - São Paulo/SP'
    fill_in 'E-mail', with: 'contato@samsung.com.br'
    fill_in 'Telefone', with: '(11) 4186-9866'
    click_on 'Gravar'

    expect(page).to have_css('h1', text: 'Samsung Infinity')
    expect(page).to have_css('h2', text: 'Samsung Infinity LTDA')
    expect(page).to have_content '32.451.879/0001-77'
    expect(page).to have_content 'Av Rio Branco, 1022 - São Paulo/SP'
    expect(page).to have_content 'contato@samsung.com.br'
    expect(page).to have_content '(11) 4186-9866'
    expect(page).to have_content 'Fornecedor alterado com sucesso'
  end

  it 'e todos os campos são obrigatórios' do
    user = User.create!(email: 'joao@email.com', password: '12345678')
    supplier = Supplier.create!(fantasy_name: 'Samsung', legal_name: 'Samsung do BR LTDA',
                            eni: '32.451.879/0001-77', address: 'Av Industrial, 1000, São Paulo',
                            email: 'financeiro@samsung.com.br', phone: '11 1234-5678')

    login_as(user, :scope => :user)
    visit root_path
    click_on 'Visualizar fornecedores'
    click_on 'Editar', id: "edit-#{supplier.id}"
    fill_in 'Nome Fantasia', with: ''
    fill_in 'Razão Social', with: ''
    fill_in 'CNPJ', with: ''
    fill_in 'Endereço', with: ''
    fill_in 'E-mail', with: ''
    fill_in 'Telefone', with: ''
    click_on 'Gravar'

    expect(page).not_to have_content 'Fornecedor registrado com sucesso'
    expect(page).to have_content 'Não foi possível alterar o fornecedor'
    expect(page).to have_content "Nome Fantasia não pode ficar em branco"
    expect(page).to have_content "Razão Social não pode ficar em branco"
    expect(page).to have_content "CNPJ não pode ficar em branco"
    expect(page).to have_content "E-mail não pode ficar em branco"
  end
end