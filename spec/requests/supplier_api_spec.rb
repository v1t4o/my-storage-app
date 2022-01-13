require 'rails_helper'

describe 'Supplier API' do
  context 'GET /api/v1/suppliers' do
    it 'com sucesso' do
      supplier = Supplier.create!(fantasy_name: 'Fábrica Geek', legal_name: 'Geek Comercio de Ceramicas LTDA', eni: '32.451.879/0001-77', address: 'Av Geek', email: 'contato@geek.com', phone: '51 3456-7890')
      other_supplier = Supplier.create!(fantasy_name: 'Canecas e Copos', legal_name: 'A Fantastica Fabrica de Canecas LTDA', eni: '45.896.325/0001-88', address: 'Av das Canecas', email: 'contato@canecas.com', phone: '11 4578-9986')

      get '/api/v1/suppliers'

      parsed_response = JSON.parse(response.body)
      expect(response.status).to eq 200
      expect(response.content_type).to include('application/json')
      expect(parsed_response[0]["fantasy_name"]).to eq 'Fábrica Geek'
      expect(parsed_response[1]["fantasy_name"]).to eq 'Canecas e Copos'
    end

    it 'retorna resposta vazia quando não há fornecedores cadastrados' do
      get '/api/v1/suppliers'

      parsed_response = JSON.parse(response.body)
      expect(response.status).to eq 200
      expect(response.content_type).to include('application/json')
      expect(parsed_response).to eq []
    end
  end

  context 'GET /api/v1/warehouses/:id' do
    it 'com sucesso' do
      supplier = Supplier.create!(fantasy_name: 'Fábrica Geek', legal_name: 'Geek Comercio de Ceramicas LTDA', eni: '32.451.879/0001-77', address: 'Av Geek', email: 'contato@geek.com', phone: '51 3456-7890')
      
      get "/api/v1/suppliers/#{supplier.id}"

      parsed_response = JSON.parse(response.body)
      expect(response.status).to eq 200
      expect(response.content_type).to include('application/json')
      expect(parsed_response["fantasy_name"]).to eq 'Fábrica Geek'
      expect(parsed_response["legal_name"]).to eq 'Geek Comercio de Ceramicas LTDA'
      expect(parsed_response["eni"]).to eq '32.451.879/0001-77'
      expect(parsed_response["address"]).to eq 'Av Geek'
      expect(parsed_response["email"]).to eq 'contato@geek.com'
      expect(parsed_response["phone"]).to eq '51 3456-7890'
      expect(parsed_response.keys).not_to include 'created_at'
      expect(parsed_response.keys).not_to include 'updated_at'
    end

    it 'fornecedor não existe' do
      get '/api/v1/suppliers/777'

      expect(response.content_type).to include('application/json')
      parsed_response = JSON.parse(response.body)
      expect(parsed_response["error"]).to eq 'Objeto não encontrado'
      expect(response.status).to eq 404    end
  end

  context 'POST /api/v1/suppliers' do
    it 'com sucesso' do
      headers = { "CONTENT_TYPE" => "application/json" }
      post '/api/v1/suppliers', params: '{"fantasy_name":"Yoki Alimentos",
                                           "legal_name":"Yoki Alimentos LTDA",
                                           "eni":"32.245.145/0001-77",
                                           "address":"Av Rio Amarelo",
                                           "email":"contato@yoki.com.br",
                                           "phone":"11 4875-5488"}',
                                           headers: headers

      expect(response.status).to eq 201
      parsed_response = JSON.parse(response.body)
      expect(parsed_response["fantasy_name"]).to eq 'Yoki Alimentos'
      expect(parsed_response["legal_name"]).to eq 'Yoki Alimentos LTDA'
      expect(parsed_response["eni"]).to eq '32.245.145/0001-77'
      expect(parsed_response["address"]).to eq 'Av Rio Amarelo'
      expect(parsed_response["email"]).to eq 'contato@yoki.com.br'
      expect(parsed_response["phone"]).to eq '11 4875-5488'
      expect(parsed_response["id"]).to be_a_kind_of(Integer)
    end

    it 'e todos os campos são obrigatórios' do
      headers = { "CONTENT_TYPE" => "application/json" }
      post '/api/v1/suppliers', params:'{"fantasy_name":"",
                                          "legal_name":"",
                                          "eni":"",
                                          "address":"Av Rio Amarelo",
                                          "email":"",
                                          "phone":"11 4875-5488"}',
                                          headers: headers

      expect(response.status).to eq 422
      expect(response.body).to include "Nome Fantasia não pode ficar em branco"
      expect(response.body).to include "Razão Social não pode ficar em branco"
      expect(response.body).to include "CNPJ não pode ficar em branco"
      expect(response.body).to include "E-mail não pode ficar em branco"
    end

    it 'código solicitado já está sendo utilizado' do
      Supplier.create!(fantasy_name: 'Fábrica Geek', legal_name: 'Geek Comercio de Ceramicas LTDA', eni: '32.451.879/0001-77', address: 'Av Geek', email: 'contato@geek.com', phone: '51 3456-7890')

      
      headers = { "CONTENT_TYPE" => "application/json" }
      post '/api/v1/suppliers', params:'{"fantasy_name":"Yoki Alimentos",
                                          "legal_name":"Yoki Alimentos LTDA",
                                          "eni":"32.451.879/0001-77",
                                          "address":"Av Rio Amarelo",
                                          "email":"yoki@yoki.com.br",
                                          "phone":"11 4875-5488"}',
                                          headers: headers
      
      expect(response.status).to eq 422
      expect(response.body).to include "CNPJ já está em uso"
    end
  end
end