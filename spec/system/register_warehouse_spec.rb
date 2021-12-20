require 'rails_helper'

describe 'Usuário cadastra um galpão' do
  it 'visitante não vê o menu' do
    visit root_path
    expect(page).not_to have_link('Cadastrar novo galpão')
  end

  it 'visitante não acessa diretamente o formulário' do
    visit new_warehouse_path
    expect(current_path).to eq new_user_session_path
  end

  it 'através de um link na tela inicial' do

    user = User.create!(email: 'joao@email.com', password: '12345678')
    login_as(user, :scope => :user)

    visit root_path

    click_on 'Cadastrar novo galpão'

    expect(page).to have_css('h2', text: 'Novo Galpão')
    expect(page).to have_field 'Nome'
    expect(page).to have_field 'Código'
    expect(page).to have_field 'Endereço'
    expect(page).to have_field 'Cidade'
    expect(page).to have_field 'Estado'
    expect(page).to have_field 'CEP'
    expect(page).to have_field 'Descrição'
    expect(page).to have_field 'Área Total'
    expect(page).to have_field 'Área Útil'
    expect(page).to have_button 'Gravar'
  end

  it 'com sucesso' do
    user = User.create!(email: 'joao@email.com', password: '12345678')
    login_as(user, :scope => :user)

    visit root_path

    click_on 'Cadastrar novo galpão'

    fill_in 'Nome', with: 'Juiz de Fora'
    fill_in 'Código', with: 'JDF'
    fill_in 'Endereço', with: 'Av Rio Branco'
    fill_in 'Cidade', with: 'Juiz de Fora'
    fill_in 'Estado', with: 'MG'
    fill_in 'CEP', with: '36000-000'
    fill_in 'Descrição', with: 'Um galpão mineiro com o pé no Rio'
    fill_in 'Área Total', with: '5000'
    fill_in 'Área Útil', with: '3000'
    click_on 'Gravar'

    expect(page).to have_css('h1', text: 'Juiz de Fora')
    expect(page).to have_css('h2', text: 'JDF')
    expect(page).to have_css('dt', text: 'Descrição:')
    expect(page).to have_css('dd', text: 'Um galpão mineiro com o pé no Rio')
    expect(page).to have_css('dt', text: 'Endereço:')
    expect(page).to have_css('dd', text: 'Av Rio Branco - Juiz de Fora/MG')
    expect(page).to have_css('dt', text: 'CEP:')
    expect(page).to have_css('dd', text: '36000-000')
    expect(page).to have_css('dt', text: 'Área Total:')
    expect(page).to have_css('dd', text: '5000 m2')
    expect(page).to have_css('dt', text: 'Área Útil:')
    expect(page).to have_css('dd', text: '3000 m2')
    expect(page).to have_content 'Galpão registrado com sucesso'
  end

  it 'e todos campos são obrigatórios' do
    user = User.create!(email: 'joao@email.com', password: '12345678')
    login_as(user, :scope => :user)

    visit root_path

    click_on 'Cadastrar novo galpão'

    fill_in 'Nome', with: ''
    fill_in 'Código', with: ''
    fill_in 'CEP', with: ''
    click_on 'Gravar'

    expect(page).not_to have_content 'Galpão registrado com sucesso'
    expect(page).to have_content 'Não foi possível gravar o galpão'
    expect(page).to have_content "Nome não pode ficar em branco"
    expect(page).to have_content "Código não pode ficar em branco"
    expect(page).to have_content "Descrição não pode ficar em branco"
    expect(page).to have_content "Endereço não pode ficar em branco"
    expect(page).to have_content "Cidade não pode ficar em branco"
    expect(page).to have_content "Estado não pode ficar em branco"
    expect(page).to have_content "CEP não pode ficar em branco"
    expect(page).to have_content "Área Total não pode ficar em branco"
    expect(page).to have_content "Área Útil não pode ficar em branco"
  end
end