require 'rails_helper'

describe 'Usuário faz login' do
  it 'com sucesso' do
    User.create!(email: 'joao@email.com', password: '12345678')
    
    visit root_path
    click_on 'Entrar'
    within('form#new_user') do
      fill_in 'E-mail', with: 'joao@email.com'
      fill_in 'Senha', with: '12345678'
      click_on 'Entrar'
    end

    expect(current_path).to eq root_path    
    expect(page).to have_content 'Olá joao@email.com'
    expect(page).to have_content 'Login efetuado com sucesso'
    expect(page).not_to have_link 'Entrar'
    expect(page).to have_link 'Sair'
  end

  it 'e faz logout' do
    User.create!(email: 'joao@email.com', password: '12345678')

    visit root_path
    click_on 'Entrar'
    within('form#new_user') do
      fill_in 'E-mail', with: 'joao@email.com'
      fill_in 'Senha', with: '12345678'
      click_on 'Entrar'
    end
    click_on 'Sair'

    expect(current_path).to eq root_path
    expect(page).to have_content 'Logout efetuado com sucesso'
    expect(page).to have_link 'Entrar'
    expect(page).not_to have_link 'Sair'
    expect(page).not_to have_content 'Olá joao@email.com'
  end
end