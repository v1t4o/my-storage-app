require 'rails_helper'

describe 'Usuário vê estoque modelo de produto' do
  it 'e consegue voltar para tela inicial' do
    category = Category.create!(name: 'Brinquedos')
    supplier = Supplier.create!(fantasy_name: 'Fábrica Geek', legal_name: 'Geek Comercio de Ceramicas LTDA', eni: '32.451.879/0001-77', address: 'Av Geek', email: 'contato@geek.com', phone: '51 3456-7890')
    p1 = ProductModel.create!(name: 'Pelúcia Dumbo', height: '50', width: '40', length: '20', weight: 400, supplier: supplier, category: category)
    
    visit root_path
    click_on 'Visualizar modelos de produtos'
    click_on 'Pelúcia Dumbo'
    click_on 'Voltar'

    expect(current_path).to eq product_models_path
  end

  it 'e vê todos os dados cadastrados' do
    category = Category.create!(name: 'Brinquedos')
    supplier = Supplier.create!(fantasy_name: 'Fábrica Geek', legal_name: 'Geek Comercio de Ceramicas LTDA', eni: '32.451.879/0001-77', address: 'Av Geek', email: 'contato@geek.com', phone: '51 3456-7890')
    p1 = ProductModel.create!(name: 'Pelúcia Dumbo', height: '50', width: '40', length: '20', weight: 400, supplier: supplier, category: category)
    
    visit root_path
    click_on 'Visualizar modelos de produtos'
    click_on 'Pelúcia Dumbo'

    expect(page).to have_content 'Pelúcia Dumbo'
    expect(page).to have_content '50 x 40 x 20'
    expect(page).to have_content '400 gramas'
    expect(page).to have_content 'Fábrica Geek'
    expect(page).to have_content 'Brinquedos'
    expect(page).to have_content 'Ativo'
  end

  it 'e vê quantidade de produtos cadastrados' do
    category = Category.create!(name: 'Brinquedos')
    w1 = Warehouse.create!(name: 'Guarulhos', code: 'GRU', description: 'Ótimo galpão numa linda cidade',
                      address: 'Av Fernandes Lima', city: 'São Paulo', state: 'SP',
                      postal_code: '57050-021', total_area: 10000, useful_area: 8000, category_ids: [category.id])
    w2 = Warehouse.create!(name: 'Porto Alegre', code: 'POA', description: 'Ótimo galpão numa linda cidade',
                      address: 'Av Josias Souza', city: 'Porto Alegre', state: 'RS',
                      postal_code: '57050-050', total_area: 10000, useful_area: 8000, category_ids: [category.id])
    supplier = Supplier.create!(fantasy_name: 'Fábrica Geek', legal_name: 'Geek Comercio de Ceramicas LTDA', eni: '32.451.879/0001-77', address: 'Av Geek', email: 'contato@geek.com', phone: '51 3456-7890')
    p1 = ProductModel.create!(name: 'Pelúcia Dumbo', height: '50', width: '40', length: '20', weight: 400, supplier: supplier, category: category)
    pe1 = ProductEntry.new(quantity: '5', product_model_id: p1.id, warehouse_id: w1.id)
    pe1.process()
    pe2 = ProductEntry.new(quantity: '10', product_model_id: p1.id, warehouse_id: w2.id)
    pe2.process()
    
    visit root_path
    click_on 'Visualizar modelos de produtos'
    click_on 'Pelúcia Dumbo'
    
    expect(page).to have_content 'Pelúcia Dumbo'
    expect(page).to have_content '400 gramas'
    expect(page).to have_content "#{p1.dimensions}"
    expect(page).to have_content "#{p1.sku}"
    expect(page).to have_content 'Fábrica Geek'
    expect(page).to have_css('h4', text: 'Estoques')
    within("tr#warehouse-#{w1.id}") do
      expect(page).to have_content('Guarulhos')
      expect(page).to have_content('5')
    end
    within("tr#warehouse-#{w2.id}") do
      expect(page).to have_content('Porto Alegre')
      expect(page).to have_content('10')
    end
  end

  it 'não existente' do
    visit product_model_path(777)

    expect(page).to have_content('Objeto não encontrado')
  end
end