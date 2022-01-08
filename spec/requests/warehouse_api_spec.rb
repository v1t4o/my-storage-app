require 'rails_helper'

describe 'Warehouse API' do
  it 'GET /warehouses' do
    Warehouse.create(name: 'Guarulhos', code: 'GRU', description: 'Ótimo galpão numa linda cidade',
                     address: 'Av Fernandes Lima', city: 'São Paulo', state: 'SP',
                     postal_code: '57050-021', total_area: 10000, useful_area: 8000)
    Warehouse.create(name: 'Porto Alegre', code: 'POA', description: 'Ótimo galpão numa linda cidade',
                     address: 'Av Fernandes Lima', city: 'Porto Alegre', state: 'RS',
                     postal_code: '57050-050', total_area: 10000, useful_area: 8000)


    get '/api/warehouses'

    expect(response).to have_http_status(200)
    expect(response.content_type).to include('application/json')
    expect(response.body).to include 'Guarulhos'
    expect(response.body).to include 'Porto Alegre'
  end
end