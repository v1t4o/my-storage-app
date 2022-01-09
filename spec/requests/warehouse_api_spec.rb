require 'rails_helper'

describe 'Warehouse API' do
  context 'GET /api/v1/warehouses' do
    it 'com sucesso' do
      Warehouse.create(name: 'Guarulhos', code: 'GRU', description: 'Ótimo galpão numa linda cidade',
                      address: 'Av Fernandes Lima', city: 'São Paulo', state: 'SP',
                      postal_code: '57050-021', total_area: 10000, useful_area: 8000)
      Warehouse.create(name: 'Porto Alegre', code: 'POA', description: 'Ótimo galpão numa linda cidade',
                      address: 'Av Josias Souza', city: 'Porto Alegre', state: 'RS',
                      postal_code: '57050-050', total_area: 10000, useful_area: 8000)


      get '/api/v1/warehouses'

      parsed_response = JSON.parse(response.body)
      expect(response.status).to eq 200
      expect(response.content_type).to include('application/json')
      expect(parsed_response[0]["name"]).to eq 'Guarulhos'
      expect(parsed_response[1]["name"]).to eq 'Porto Alegre'
      expect(response.body).not_to include 'Av Fernandes Lima'
      expect(response.body).not_to include 'Av Josias Souza'
    end

    it 'quando retorna sem dados' do
      get '/api/v1/warehouses'

      parsed_response = JSON.parse(response.body)
      expect(response.status).to eq 200
      expect(response.content_type).to include('application/json')
      expect(parsed_response).to eq []
    end
  end
end