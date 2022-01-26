require 'rails_helper'

describe 'Usuário edita status de um modelo de produto' do
  it 'e coloca status como inativo' do
    user = User.create!(email: 'joao@email.com', password: '12345678')
    category = Category.create!(name: 'Bebidas')
    warehouse = Warehouse.create!(name: 'Maceió', code: 'MCZ', description: 'Ótimo galpão numa linda cidade',
                                  address: 'Av Fernandes Lima', city: 'Maceió', state: 'AL',
                                  postal_code: '57050-000', total_area: 10000, useful_area: 8000, category_ids: [category.id])
    supplier = Supplier.create!(fantasy_name: 'Vinícola Miolo', legal_name: 'Miolo Fábrica de Bebidas LTDA', eni: '32.451.879/0001-77', address: 'Avenida Cabernet, 100', email: 'contato@miolovinhos.com', phone: '71 1234-5678')
    p1 = ProductModel.create!(name: 'Vinho Tinto Miolo', height: '30', width: '10', length: '10', weight: 800, supplier: supplier, category: category)
    p2 = ProductModel.create!(name: 'Vinho Branco Miolo', height: '30', width: '10', length: '10', weight: 800, supplier: supplier, category: category)

    login_as(user)
    visit root_path
    click_on 'Visualizar modelos de produtos'
    within("tr#product-model-#{p1.id}") do
      click_on 'Editar'
    end
    select 'Inativo', from: 'Status'
    click_button 'Gravar'

    expect(page).to have_content 'Modelo de produto alterado com sucesso'
    expect(page).to have_content 'Vinho Tinto Miolo'
    expect(page).to have_content '800 gramas'
    expect(page).to have_content 'Dimensões: 30 x 10 x 10'
    expect(page).to have_content "Código SKU: #{p1.sku}"
    expect(page).to have_content 'Fornecedor: Vinícola Miolo'
    expect(page).to have_content 'Status: Inativo'
  end

  it 'e coloca status como ativo' do
    user = User.create!(email: 'joao@email.com', password: '12345678')
    category = Category.create!(name: 'Bebidas')
    warehouse = Warehouse.create!(name: 'Maceió', code: 'MCZ', description: 'Ótimo galpão numa linda cidade',
                                  address: 'Av Fernandes Lima', city: 'Maceió', state: 'AL',
                                  postal_code: '57050-000', total_area: 10000, useful_area: 8000, category_ids: [category.id])
    supplier = Supplier.create!(fantasy_name: 'Vinícola Miolo', legal_name: 'Miolo Fábrica de Bebidas LTDA', eni: '32.451.879/0001-77', address: 'Avenida Cabernet, 100', email: 'contato@miolovinhos.com', phone: '71 1234-5678')
    p1 = ProductModel.create!(name: 'Vinho Tinto Miolo', height: '30', width: '10', length: '10', weight: 800, supplier: supplier, category: category, status: 1)
    p2 = ProductModel.create!(name: 'Vinho Branco Miolo', height: '30', width: '10', length: '10', weight: 800, supplier: supplier, category: category, status: 1)

    login_as(user)
    visit root_path
    click_on 'Visualizar modelos de produtos'
    within("tr#product-model-#{p1.id}") do
      click_on 'Editar'
    end
    select 'Ativo', from: 'Status'
    click_button 'Gravar'

    expect(page).to have_content 'Modelo de produto alterado com sucesso'
    expect(page).to have_content 'Vinho Tinto Miolo'
    expect(page).to have_content '800 gramas'
    expect(page).to have_content 'Dimensões: 30 x 10 x 10'
    expect(page).to have_content "Código SKU: #{p1.sku}"
    expect(page).to have_content 'Fornecedor: Vinícola Miolo'
    expect(page).to have_content 'Status: Ativo'
  end
end