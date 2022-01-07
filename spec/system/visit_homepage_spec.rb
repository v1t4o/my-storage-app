require 'rails_helper'

describe 'Visitante abre a tela inicial' do
  it 'e vê uma mensagem de boas vindas' do
    visit root_path

    expect(page).to have_css('h1', text: 'My Storage App')
    expect(page).to have_css('h2', text: 'Boas vindas ao sistema de gestão de estoques')
  end

  it 'e vê os galpões cadastrados' do
    Warehouse.create(name: 'Guarulhos', code: 'GRU', description: 'Ótimo galpão numa linda cidade',
    address: 'Av Fernandes Lima', city: 'São Paulo', state: 'SP',
    postal_code: '57050-021', total_area: 10000, useful_area: 8000)
    Warehouse.create(name: 'Porto Alegre', code: 'POA', description: 'Ótimo galpão numa linda cidade',
    address: 'Av Fernandes Lima', city: 'Porto Alegre', state: 'RS',
    postal_code: '57050-050', total_area: 10000, useful_area: 8000)
    Warehouse.create(name: 'São Luís', code: 'SLZ', description: 'Ótimo galpão numa linda cidade',
    address: 'Av Fernandes Lima', city: 'São Luís', state: 'MA',
    postal_code: '57050-060', total_area: 10000, useful_area: 8000)
    Warehouse.create(name: 'Vitória', code: 'VIX', description: 'Ótimo galpão numa linda cidade',
    address: 'Av Fernandes Lima', city: 'Vitória', state: 'ES',
    postal_code: '57050-102', total_area: 10000, useful_area: 8000)

    visit root_path

    expect(page).to have_css('h3', text: 'Galpões cadastrados')
    expect(page).to have_css('td', text: 'Guarulhos')
    expect(page).to have_css('td', text: 'GRU')
    expect(page).to have_css('td', text: 'Porto Alegre')
    expect(page).to have_css('td', text: 'POA')
    expect(page).to have_css('td', text: 'São Luís')
    expect(page).to have_css('td', text: 'SLZ')
    expect(page).to have_css('td', text: 'Vitória')
    expect(page).to have_css('td', text: 'VIX')
  end

  it 'e não vê todos os detalhes de um galpão' do
    Warehouse.create(name: 'Maceió', code: 'MCZ', description: 'Ótimo galpão numa linda cidade',
                     address: 'Av Fernandes Lima', city: 'Maceió', state: 'AL',
                     postal_code: '57050-000',
                     total_area: 10000, useful_area: 8000)

    visit root_path

    expect(page).to have_css('td', text: 'Maceió')
    expect(page).to have_css('td', text: 'MCZ')
    expect(page).not_to have_content('Ótimo galpão numa linda cidade')
    expect(page).not_to have_content('Av Fernandes Lima - Maceió/AL')
    expect(page).not_to have_content('57050-000')
    expect(page).not_to have_content('10000 m2')
    expect(page).not_to have_content('8000 m2')
  end
end