require 'rails_helper'

describe 'Visitante vê um galpão' do
  it 'e consegue voltar para a tela inicial' do
    warehouse = Warehouse.create!(name: 'Maceió', code: 'MCZ', description: 'Ótimo galpão numa linda cidade',
                     address: 'Av Fernandes Lima', city: 'Maceió', state: 'AL',
                     postal_code: '57050-000',
                     total_area: 10000, useful_area: 8000)

    visit root_path
    click_on 'Visualizar galpões'
    within("tr#warehouse-#{warehouse.id}") do
      click_on 'Maceió'
    end
    click_on 'Voltar'

    expect(current_path).to eq warehouses_path
  end

  it 'e vê todos os dados cadastrados' do
    warehouse = Warehouse.create!(name: 'Maceió', code: 'MCZ', description: 'Ótimo galpão numa linda cidade',
                     address: 'Av Fernandes Lima', city: 'Maceió', state: 'AL',
                     postal_code: '57050-000', total_area: 10000, useful_area: 8000)

    visit root_path
    click_on 'Visualizar galpões'
    within("tr#warehouse-#{warehouse.id}") do
      click_on 'Maceió'
    end

    expect(page).to have_css('h2', text: 'Maceió')
    expect(page).to have_css('h4', text: 'MCZ')
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

  it 'não existente' do
    visit warehouse_path(777)

    expect(page).to have_content('Objeto não encontrado')
  end
end