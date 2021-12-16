require 'rails_helper'

describe 'Visitante abre a tela inicial' do
  it 'e vê uma mensagem de boas vindas' do
    visit root_path

    expect(page).to have_css('h1', text: 'My Storage App')
    expect(page).to have_css('h2', text: 'Boas vindas ao sistema de gestão de estoques')
  end

  it 'e vê os galpões cadastrados' do
    Warehouse.create(name: 'Guarulhos', code: 'GRU')
    Warehouse.create(name: 'Porto Alegre', code: 'POA')
    Warehouse.create(name: 'São Luís', code: 'SLZ')
    Warehouse.create(name: 'Vitória', code: 'VIX')

    visit root_path

    expect(page).to have_css('h3', text: 'Galpões cadastrados')
<<<<<<< HEAD
=======
    
>>>>>>> 9a44b163675293f2bf902c11476da9f339f7e44d
    expect(page).to have_css('td', text: 'Guarulhos')
    expect(page).to have_css('td', text: 'GRU')
    expect(page).to have_css('td', text: 'Porto Alegre')
    expect(page).to have_css('td', text: 'POA')
    expect(page).to have_css('td', text: 'São Luís')
    expect(page).to have_css('td', text: 'SLZ')
    expect(page).to have_css('td', text: 'Vitória')
    expect(page).to have_css('td', text: 'VIX')
  end
end