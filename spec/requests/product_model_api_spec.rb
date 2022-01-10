require 'rails_helper'

describe 'ProductModel API' do
  context 'GET /api/v1/product_models' do
    it 'com sucesso' do
      supplier = Supplier.create!(fantasy_name: 'Fábrica Geek', legal_name: 'Geek Comercio de Ceramicas LTDA', eni: '32.451.879/0001-77', address: 'Av Geek', email: 'contato@geek.com', phone: '51 3456-7890')
      other_supplier = Supplier.create!(fantasy_name: 'Canecas e Copos', legal_name: 'A Fantastica Fabrica de Canecas LTDA', eni: '45.896.325/0001-88', address: 'Av das Canecas', email: 'contato@canecas.com', phone: '11 4578-9986')
      category = Category.create!(name: 'Geek')
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
    it 'com sucesso' do
      supplier = Supplier.create!(fantasy_name: 'Fábrica Geek', legal_name: 'Geek Comercio de Ceramicas LTDA', eni: '32.451.879/0001-77', address: 'Av Geek', email: 'contato@geek.com', phone: '51 3456-7890')
      category = Category.create!(name: 'Geek')
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

    it 'fornecedor não existe' do
      get '/api/v1/product_models/777'

      expect(response.status).to eq 404
    end
  end
end