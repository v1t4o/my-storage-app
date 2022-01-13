require 'rails_helper'

describe 'Usuário edita galpão' do
  it 'através de um link da página do galpão' do
    user = User.create!(email: 'joao@email.com', password: '12345678')
    Warehouse.create(name: 'Maceió', code: 'MCZ', description: 'Ótimo galpão numa linda cidade',
                     address: 'Av Fernandes Lima', city: 'Maceió', state: 'AL',
                     postal_code: '57050-000', total_area: 10000, useful_area: 8000)

    login_as(user, :scope => :user)
    visit root_path
    click_on 'Visualizar galpões'
    click_on 'Maceió'
    click_on 'Editar'

    expect(page).to have_css('h2', text: 'Editar Galpão')
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
    Warehouse.create(name: 'Maceió', code: 'MCZ', description: 'Ótimo galpão numa linda cidade',
                     address: 'Av Fernandes Lima', city: 'Maceió', state: 'AL',
                     postal_code: '57050-000', total_area: 10000, useful_area: 8000)

    login_as(user, :scope => :user)
    visit root_path
    click_on 'Visualizar galpões'
    click_on 'Maceió'
    click_on 'Editar'
    fill_in 'Nome', with: 'Maceió'
    fill_in 'Código', with: 'MCZ'
    fill_in 'Endereço', with: 'Av Rio Branco'
    fill_in 'Cidade', with: 'Maceió'
    fill_in 'Estado', with: 'AL'
    fill_in 'CEP', with: '36000-000'
    fill_in 'Descrição', with: 'Um galpão nordestino'
    fill_in 'Área Total', with: '10000'
    fill_in 'Área Útil', with: '9000'
    click_on 'Gravar'
    
    expect(page).to have_css('h1', text: 'Maceió')
    expect(page).to have_css('h2', text: 'MCZ')
    expect(page).to have_css('dt', text: 'Descrição:')
    expect(page).to have_css('dd', text: 'Um galpão nordestino')
    expect(page).to have_css('dt', text: 'Endereço:')
    expect(page).to have_css('dd', text: 'Av Rio Branco - Maceió/AL')
    expect(page).to have_css('dt', text: 'CEP:')
    expect(page).to have_css('dd', text: '36000-000')
    expect(page).to have_css('dt', text: 'Área Total:')
    expect(page).to have_css('dd', text: '10000 m2')
    expect(page).to have_css('dt', text: 'Área Útil:')
    expect(page).to have_css('dd', text: '9000 m2')
    expect(page).to have_content 'Galpão alterado com sucesso'
  end

  it 'e todos campos são obrigatórios' do
    user = User.create!(email: 'joao@email.com', password: '12345678')
    
    login_as(user, :scope => :user)
    visit root_path
    click_on 'Visualizar galpões'
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