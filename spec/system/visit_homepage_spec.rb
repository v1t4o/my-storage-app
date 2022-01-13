require 'rails_helper'

describe 'Visitante abre a tela inicial' do
  it 'e vê uma mensagem de boas vindas' do
    visit root_path

    expect(page).to have_css('h1', text: 'My Storage App')
    expect(page).to have_css('h2', text: 'Boas vindas ao sistema de gestão de estoques')
  end
end