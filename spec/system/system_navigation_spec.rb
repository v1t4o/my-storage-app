require 'rails_helper'

describe 'Visitante navega pelo site' do
  it 'usa o menu' do
    visit root_path

    expect(page).to have_css('nav a', text: 'Início')
    expect(page).to have_css('nav a', text: 'Visualizar fornecedores')
    expect(page).to have_css('nav a', text: 'Visualizar modelos de produtos')
    expect(page).to have_css('nav a', text: 'Visualizar categorias')

    within('nav') do
      expect(page).to have_link('Início', href: root_path)
    end
  end
end