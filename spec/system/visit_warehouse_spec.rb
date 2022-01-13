require 'rails_helper'

describe 'Visitante vê um galpão' do
  it 'e vê todos os dados cadastrados' do
    Warehouse.create(name: 'Maceió', code: 'MCZ', description: 'Ótimo galpão numa linda cidade',
                     address: 'Av Fernandes Lima', city: 'Maceió', state: 'AL',
                     postal_code: '57050-000', total_area: 10000, useful_area: 8000)

    visit root_path
    click_on 'Visualizar galpões'
    click_on 'Maceió'

    expect(page).to have_css('h1', text: 'Maceió')
    expect(page).to have_css('h2', text: 'MCZ')
    expect(page).to have_css('dt', text: 'Descrição:')
    expect(page).to have_css('dd', text: 'Ótimo galpão numa linda cidade')
    expect(page).to have_css('dt', text: 'Endereço:')
    expect(page).to have_css('dd', text: 'Av Fernandes Lima - Maceió/AL')
    expect(page).to have_css('dt', text: 'CEP:')
    expect(page).to have_css('dd', text: '57050-000')
    expect(page).to have_css('dt', text: 'Área Total:')
    expect(page).to have_css('dd', text: '10000 m2')
    expect(page).to have_css('dt', text: 'Área Útil:')
    expect(page).to have_css('dd', text: '8000 m2')

  end
  
  it 'e consegue voltar para a tela inicial' do
    Warehouse.create(name: 'Maceió', code: 'MCZ', description: 'Ótimo galpão numa linda cidade',
                     address: 'Av Fernandes Lima', city: 'Maceió', state: 'AL',
                     postal_code: '57050-000',
                     total_area: 10000, useful_area: 8000)

    visit root_path
    click_on 'Visualizar galpões'
    click_on 'Maceió'
    click_on 'Voltar'

    expect(current_path).to eq warehouses_path
  end

  it 'e consegue pesquisar um galpão pelo nome' do
    Warehouse.create(name: 'Maceió', code: 'MCZ', description: 'Ótimo galpão numa linda cidade',
                     address: 'Av Fernandes Lima', city: 'Maceió', state: 'AL',
                     postal_code: '57050-000',
                     total_area: 10000, useful_area: 8000)
    Warehouse.create(name: 'Guarulhos', code: 'GRU', description: 'Ótimo galpão numa linda cidade',
                     address: 'Av Fernandes Lima', city: 'Maceió', state: 'AL',
                     postal_code: '57050-000',
                     total_area: 10000, useful_area: 8000)
    Warehouse.create(name: 'Dutra', code: 'GUA', description: 'Ótimo galpão numa linda cidade',
                     address: 'Av Fernandes Lima', city: 'Guarulhos', state: 'AL',
                     postal_code: '57050-000',
                     total_area: 10000, useful_area: 8000)

    visit root_path
    click_on 'Visualizar galpões'
    fill_in 'Busca:', with: 'Guarulhos'
    click_on 'Filtrar'

    expect(current_path).to eq warehouses_path
    expect(page).to have_content('Guarulhos')
    expect(page).to have_content('Dutra')
    expect(page).not_to have_content('Maceió')
  end
end