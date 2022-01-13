require 'rails_helper'

describe 'ProductModel API' do
  context 'GET /api/v1/product_models' do
    it 'com sucesso' do
      supplier = Supplier.create!(fantasy_name: 'Fábrica Geek', legal_name: 'Geek Comercio de Ceramicas LTDA', eni: '32.451.879/0001-77', address: 'Av Geek', email: 'contato@geek.com', phone: '51 3456-7890')
      other_supplier = Supplier.create!(fantasy_name: 'Canecas e Copos', legal_name: 'A Fantastica Fabrica de Canecas LTDA', eni: '45.896.325/0001-88', address: 'Av das Canecas', email: 'contato@canecas.com', phone: '11 4578-9986')
      category = Category.create!(name: 'Brinquedos')
      ProductModel.create!(name: 'Pelúcia Dumbo', height: '50', width: '40', length: '20', weight: 400, supplier: supplier, category: category)
      ProductModel.create!(name: 'Caneca Star Wars', height: '14', width: '10', length: '8', weight: 300, supplier: other_supplier, category: category)

      get '/api/v1/product_models'

      parsed_response = JSON.parse(response.body)
      expect(response.status).to eq 200
      expect(response.content_type).to include('application/json')
      expect(parsed_response[0]["name"]).to eq 'Pelúcia Dumbo'
      expect(parsed_response[1]["name"]).to eq 'Caneca Star Wars'
    end

    it 'retorna resposta vazia quando não há modelos de produtos cadastrados' do
      get '/api/v1/product_models'

      parsed_response = JSON.parse(response.body)
      expect(response.status).to eq 200
      expect(response.content_type).to include('application/json')
      expect(parsed_response).to eq []
    end
  end

  context 'GET /api/v1/product_models/:id' do
    it 'com sucesso - 200' do
      supplier = Supplier.create!(fantasy_name: 'Fábrica Geek', legal_name: 'Geek Comercio de Ceramicas LTDA', eni: '32.451.879/0001-77', address: 'Av Geek', email: 'contato@geek.com', phone: '51 3456-7890')
      category = Category.create!(name: 'Brinquedos')
      product_model = ProductModel.create!(name: 'Caneca Star Wars', height: '14', width: '10', length: '8', weight: 300, supplier: supplier, category: category)
      
      get "/api/v1/product_models/#{product_model.id}"

      parsed_response = JSON.parse(response.body)
      expect(response.status).to eq 200
      expect(response.content_type).to include('application/json')
      expect(parsed_response["name"]).to eq 'Caneca Star Wars'
      expect(parsed_response["height"]).to eq 14
      expect(parsed_response["width"]).to eq 10
      expect(parsed_response["length"]).to eq 8
      expect(parsed_response["weight"]).to eq 300
      expect(parsed_response.keys).not_to include 'created_at'
      expect(parsed_response.keys).not_to include 'updated_at'
    end

    it 'fornecedor não existe - 404' do
      get '/api/v1/product_models/777'

      expect(response.content_type).to include('application/json')
      parsed_response = JSON.parse(response.body)
      expect(parsed_response["error"]).to eq 'Objeto não encontrado'
      expect(response.status).to eq 404
    end

    it 'parâmetro inválido - 412' do
      
    end

    it 'erro de base de dados - 500' do
      supplier = Supplier.create!(fantasy_name: 'Fábrica Geek', legal_name: 'Geek Comercio de Ceramicas LTDA', eni: '32.451.879/0001-77', address: 'Av Geek', email: 'contato@geek.com', phone: '51 3456-7890')
      category = Category.create!(name: 'Brinquedos')
      pm = ProductModel.create!(name: 'Pelúcia Dumbo', height: '50', width: '40', length: '20', weight: 400, supplier: supplier, category: category)
      allow(ProductModel).to receive(:find).with(pm.id.to_s).and_raise ActiveRecord::ConnectionNotEstablished

      get "/api/v1/product_models/#{pm.id}"

      expect(response.content_type).to include('application/json')
      parsed_response = JSON.parse(response.body)
      expect(parsed_response["error"]).to eq 'Não foi possível conectar no banco de dados'
      expect(response.status).to eq 500
    end
  end

  context 'POST /api/v1/product_models' do
    it 'com sucesso' do
      supplier = Supplier.create!(fantasy_name: 'Fábrica Geek', legal_name: 'Geek Comercio de Ceramicas LTDA', eni: '32.451.879/0001-77', address: 'Av Geek', email: 'contato@geek.com', phone: '51 3456-7890')
      category = Category.create!(name: 'Brinquedos')
      headers = { "CONTENT_TYPE" => "application/json" }
      post '/api/v1/product_models', params: '{"name":"Pelúcia Dumbo",
                                               "weight":"200",
                                               "height":"18",
                                               "length":"8",
                                               "width":"10",
                                               "supplier_id":"' + supplier.id.to_s + '",
                                               "category_id":"' + category.id.to_s + '"}',
                                                headers: headers

      expect(response.status).to eq 201
      parsed_response = JSON.parse(response.body)
      expect(parsed_response["name"]).to eq 'Pelúcia Dumbo'
      expect(parsed_response["weight"]).to eq 200
      expect(parsed_response["height"]).to eq 18
      expect(parsed_response["length"]).to eq 8
      expect(parsed_response["width"]).to eq 10
      expect(parsed_response["supplier"]["fantasy_name"]).to eq 'Fábrica Geek'
      expect(parsed_response["category"]["name"]).to eq 'Brinquedos'
      expect(parsed_response["id"]).to be_a_kind_of(Integer)
    end
    
    it 'e todos os campos são obrigatórios' do
      headers = { "CONTENT_TYPE" => "application/json" }
      post '/api/v1/product_models', params:'{"name":"",
                                              "weight":"",
                                              "height":"",
                                              "length":"",
                                              "width":"",
                                              "supplier_id":"",
                                              "category_id":""}',
                                              headers: headers

      expect(response.status).to eq 422
      expect(response.body).to include "Nome não pode ficar em branco"
      expect(response.body).to include "Peso não pode ficar em branco"
      expect(response.body).to include "Altura não pode ficar em branco"
      expect(response.body).to include "Profundidade não pode ficar em branco"
      expect(response.body).to include "Largura não pode ficar em branco"
      expect(response.body).to include "Fornecedor não pode ficar em branco"
      expect(response.body).to include "Categoria não pode ficar em branco"
    end
  end
end