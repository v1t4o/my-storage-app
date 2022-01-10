require 'rails_helper'

describe 'Warehouse API' do
  context 'GET /api/v1/warehouses' do
    it 'com sucesso' do
      Warehouse.create!(name: 'Guarulhos', code: 'GRU', description: 'Ótimo galpão numa linda cidade',
                      address: 'Av Fernandes Lima', city: 'São Paulo', state: 'SP',
                      postal_code: '57050-021', total_area: 10000, useful_area: 8000)
      Warehouse.create!(name: 'Porto Alegre', code: 'POA', description: 'Ótimo galpão numa linda cidade',
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

    it 'retorna resposta vazia quando não há galpões cadastrados' do
      get '/api/v1/warehouses'

      parsed_response = JSON.parse(response.body)
      expect(response.status).to eq 200
      expect(response.content_type).to include('application/json')
      expect(parsed_response).to eq []
    end
  end

  context 'GET /api/v1/warehouses/:id' do
    it 'com sucesso' do
      warehouse = Warehouse.create!(name: 'Guarulhos', code: 'GRU', description: 'Ótimo galpão numa linda cidade',
                      address: 'Av Fernandes Lima', city: 'São Paulo', state: 'SP',
                      postal_code: '57050-021', total_area: 10000, useful_area: 8000)
      
      get "/api/v1/warehouses/#{warehouse.id}"

      parsed_response = JSON.parse(response.body)
      expect(response.status).to eq 200
      expect(response.content_type).to include('application/json')
      expect(parsed_response["name"]).to eq 'Guarulhos'
      expect(parsed_response["code"]).to eq 'GRU'
      expect(parsed_response["description"]).to eq 'Ótimo galpão numa linda cidade'
      expect(parsed_response["city"]).to eq 'São Paulo'
      expect(parsed_response["state"]).to eq 'SP'
      expect(parsed_response["postal_code"]).to eq '57050-021'
      expect(parsed_response["total_area"]).to eq 10000
      expect(parsed_response["useful_area"]).to eq 8000
      expect(parsed_response.keys).not_to include 'created_at'
      expect(parsed_response.keys).not_to include 'updated_at'
      expect(parsed_response.keys).not_to include 'address'
    end

    it 'galpão não existe' do
      get '/api/v1/warehouses/777'

      expect(response.status).to eq 404
    end
  end
end