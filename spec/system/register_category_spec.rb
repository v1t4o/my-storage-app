require 'rails_helper'

describe 'Usuário cadastra categoria de produto' do
  it 'através de um link na tela inicial' do
    visit root_path
    click_on 'Cadastrar categoria'

    expect(current_path).to eq new_category_path
    expect(page).to have_content 'Nova categoria'
    expect(page).to have_field 'Nome'
  end

  it 'com sucesso' do
    visit root_path
    click_on 'Cadastrar categoria'

    fill_in 'Nome', with: 'Eletrônicos'
    click_on 'Gravar'

    expect(page).to have_content 'Eletrônicos'
    expect(page).to have_content 'Categoria cadastrada com sucesso'
  end

  it 'e todos campos são obrigatórios' do
    
    visit root_path

    click_on 'Cadastrar categoria'

    fill_in 'Nome', with: ''

    click_on 'Gravar'

    expect(page).not_to have_content 'Categoria cadastrada com sucesso'
    expect(page).to have_content "Nome não pode ficar em branco"
    expect(page).to have_content "Não foi possível cadastrar categoria"
  end
end