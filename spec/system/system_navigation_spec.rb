require 'rails_helper'

describe 'Visitante navega pelo site' do
  it 'usa o menu' do
    visit root_path

    expect(page).to have_css('ul li a', text: 'Início')
    expect(page).to have_css('ul li a', text: 'Visualizar galpões')
    expect(page).to have_css('ul li a', text: 'Visualizar fornecedores')
    expect(page).to have_css('ul li a', text: 'Visualizar modelos de produtos')
    expect(page).to have_css('ul li a', text: 'Visualizar categorias')

    within('div#nav') do
      expect(page).to have_link('Início', href: root_path)
      expect(page).to have_link('Visualizar galpões', href: warehouses_path)
      expect(page).to have_link('Visualizar fornecedores', href: suppliers_path)
      expect(page).to have_link('Visualizar modelos de produtos', href: product_models_path)
      expect(page).to have_link('Visualizar kits de produtos', href: product_bundles_path)
      expect(page).to have_link('Visualizar categorias', href: categories_path)
    end
  end
end