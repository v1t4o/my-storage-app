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
      expect(parsed_response["address"]).to eq 'Av Fernandes Lima'
      expect(parsed_response["postal_code"]).to eq '57050-021'
      expect(parsed_response["total_area"]).to eq 10000
      expect(parsed_response["useful_area"]).to eq 8000
      expect(parsed_response.keys).not_to include 'created_at'
      expect(parsed_response.keys).not_to include 'updated_at'
    end

    it 'galpão não existe' do
      get '/api/v1/warehouses/777'

      expect(response.status).to eq 404
    end
  end

  context 'POST /api/v1/warehouses' do
    it 'com sucesso' do
      headers = { "CONTENT_TYPE" => "application/json" }
      post '/api/v1/warehouses', params: '{"name":"Juiz de Fora",
                                           "code":"JDF",
                                           "description":"Ótimo Galpão",
                                           "address":"Av Rio Branco",
                                           "city":"Juiz de Fora",
                                           "state":"MG",
                                           "postal_code":"36000-000",
                                           "total_area":5000,
                                           "useful_area":3000}',
                                           headers: headers

      expect(response.status).to eq 201
      parsed_response = JSON.parse(response.body)
      expect(parsed_response["name"]).to eq 'Juiz de Fora'
      expect(parsed_response["code"]).to eq 'JDF'
      expect(parsed_response["id"]).to be_a_kind_of(Integer)
    end

    it 'e todos os campos são obrigatórios' do
      headers = { "CONTENT_TYPE" => "application/json" }
      post '/api/v1/warehouses', params:'{"name":"",
                                          "code":"",
                                          "description":"",
                                          "address":"",
                                          "city":"",
                                          "state":"",
                                          "postal_code":"",
                                          "total_area":"",
                                          "useful_area":""}',
                                          headers: headers

      expect(response.status).to eq 422
      expect(response.body).to include "Nome não pode ficar em branco"
      expect(response.body).to include "Código não pode ficar em branco"
      expect(response.body).to include "Descrição não pode ficar em branco"
      expect(response.body).to include "Endereço não pode ficar em branco"
      expect(response.body).to include "Cidade não pode ficar em branco"
      expect(response.body).to include "Estado não pode ficar em branco"
      expect(response.body).to include "CEP não pode ficar em branco"
      expect(response.body).to include "Área Total não pode ficar em branco"
      expect(response.body).to include "Área Útil não pode ficar em branco"
    end

    it 'código solicitado já está sendo utilizado' do
      Warehouse.create!(name: 'Guarulhos', code: 'GRU', description: 'Ótimo galpão numa linda cidade',
                        address: 'Av Fernandes Lima', city: 'São Paulo', state: 'SP',
                        postal_code: '57050-021', total_area: 10000, useful_area: 8000)
      
      headers = { "CONTENT_TYPE" => "application/json" }
      post '/api/v1/warehouses', params: '{"name":"Grupo Dutra Galpões",
                                           "code":"GRU",
                                           "description":"Ótimo Galpão",
                                           "address":"Av Rio Branco",
                                           "city":"Guarulhos",
                                           "state":"SP",
                                           "postal_code":"36000-000",
                                           "total_area":10000,
                                           "useful_area":7000}',
                                           headers: headers
      
      expect(response.status).to eq 422
      expect(response.body).to include "Código já está em uso"
    end
  end
end