require 'rails_helper'

describe 'Usuário cadastra um fornecedor' do
  it 'visitante não vê no menu' do
    visit root_path
    expect(page).not_to have_link('Cadastrar novo fornecedor')
  end

  it 'visitante não acessa diretamente o formulário de cadastro de fornecedor' do
    visit new_supplier_path
    expect(current_path).to eq new_user_session_path
  end

  it 'através de um link na tela inicial' do
    user = User.create!(email: 'joao@email.com', password: '12345678')

    login_as(user, :scope => :user)
    visit root_path
    click_on 'Cadastrar novo fornecedor'

    expect(page).to have_css('h2', text: 'Novo fornecedor')
    expect(page).to have_field 'Nome Fantasia'
    expect(page).to have_field 'Razão Social'
    expect(page).to have_field 'CNPJ'
    expect(page).to have_field 'Endereço'
    expect(page).to have_field 'E-mail'
    expect(page).to have_field 'Telefone'
  end

  it 'com sucesso' do
    user = User.create!(email: 'joao@email.com', password: '12345678')

    login_as(user, :scope => :user)
    visit root_path
    click_on 'Cadastrar novo fornecedor'
    fill_in 'Nome Fantasia', with: 'Storage Box'
    fill_in 'Razão Social', with: 'Storage Box Armazenamento LTDA'
    fill_in 'CNPJ', with: '32.451.879/0001-77'
    fill_in 'Endereço', with: 'Av Rio Branco, 1022 - São Paulo/SP'
    fill_in 'E-mail', with: 'contato@storagebox.com.br'
    fill_in 'Telefone', with: '(11) 4186-9866'
    click_on 'Gravar'

    expect(page).to have_css('h2', text: 'Storage Box')
    expect(page).to have_css('h4', text: 'Storage Box Armazenamento LTDA')
    expect(page).to have_content '32.451.879/0001-77'
    expect(page).to have_content 'Av Rio Branco, 1022 - São Paulo/SP'
    expect(page).to have_content 'contato@storagebox.com.br'
    expect(page).to have_content '(11) 4186-9866'
    expect(page).to have_content 'Fornecedor registrado com sucesso'
  end

  it 'e alguns campos são obrigatórios' do
    user = User.create!(email: 'joao@email.com', password: '12345678')

    login_as(user, :scope => :user)
    visit root_path
    click_on 'Cadastrar novo fornecedor'
    fill_in 'Nome Fantasia', with: ''
    fill_in 'Razão Social', with: ''
    fill_in 'CNPJ', with: ''
    fill_in 'E-mail', with: ''
    click_on 'Gravar'

    expect(page).not_to have_content 'Fornecedor registrado com sucesso'
    expect(page).to have_content 'Não foi possível gravar o fornecedor'
    expect(page).to have_content "Nome Fantasia não pode ficar em branco"
    expect(page).to have_content "Razão Social não pode ficar em branco"
    expect(page).to have_content "CNPJ não pode ficar em branco"
    expect(page).to have_content "E-mail não pode ficar em branco"
  end
end