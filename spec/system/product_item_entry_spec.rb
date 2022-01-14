require 'rails_helper'

describe 'Usuário dá entrada em novos itens' do
  it 'com sucesso' do
    user = User.create!(email: 'joao@email.com', password: '12345678')
    category = Category.create!(name: 'Bebidas')
    warehouse = Warehouse.create(name: 'Maceió', code: 'MCZ', description: 'Ótimo galpão numa linda cidade',
                     address: 'Av Fernandes Lima', city: 'Maceió', state: 'AL',
                     postal_code: '57050-000', total_area: 10000, useful_area: 8000, category_ids: [category.id])
    supplier = Supplier.create!(fantasy_name: 'Vinícola Miolo', legal_name: 'Miolo Fábrica de Bebidas LTDA', eni: '32.451.879/0001-77', address: 'Avenida Cabernet, 100', email: 'contato@miolovinhos.com', phone: '71 1234-5678')
    p1 = ProductModel.create!(name: 'Vinho Tinto Miolo', height: '30', width: '10', length: '10', weight: 800, supplier: supplier, category: category)
    p2 = ProductModel.create!(name: 'Vinho Branco Miolo', height: '30', width: '10', length: '10', weight: 800, supplier: supplier, category: category)

    login_as(user)
    visit root_path
    click_on 'Entrada de Itens'
    fill_in 'Quantidade', with: 100
    select 'MCZ', from: 'Galpão Destino'
    select 'Vinho Tinto Miolo', from: 'Produto'
    click_on 'Confirmar'

    expect(current_path).to eq warehouse_path(warehouse.id)
    expect(page).to have_css('h2', text: 'Estoque')
    within("div#product-#{p1.id}") do
      expect(page).to have_content('Vinho Tinto Miolo')
      expect(page).to have_content('Quantidade: 100')
    end
  end

  context 'a partir da tela do galpão' do
    it 'mas não visualiza formulário caso não esteja logado' do
      category = Category.create!(name: 'Bebidas')
      warehouse = Warehouse.create!(name: 'Maceió', code: 'MCZ', description: 'Ótimo galpão numa linda cidade',
                      address: 'Av Fernandes Lima', city: 'Maceió', state: 'AL',
                      postal_code: '57050-000', total_area: 10000, useful_area: 8000, category_ids: [category.id])
      supplier = Supplier.create!(fantasy_name: 'Vinícola Miolo', legal_name: 'Miolo Fábrica de Bebidas LTDA', eni: '32.451.879/0001-77', address: 'Avenida Cabernet, 100', email: 'contato@miolovinhos.com', phone: '71 1234-5678')
      p1 = ProductModel.create!(name: 'Vinho Tinto Miolo', height: '30', width: '10', length: '10', weight: 800, supplier: supplier, category: category)
      p2 = ProductModel.create!(name: 'Vinho Branco Miolo', height: '30', width: '10', length: '10', weight: 800, supplier: supplier, category: category)

      visit root_path
      click_on 'Visualizar galpões'
      click_on 'Maceió'

      expect(current_path).to eq warehouse_path(warehouse.id)
      expect(page).not_to have_css('h2#label-product-entry', text: 'Entrada de Itens')
      expect(page).not_to have_field('Quantidade:')
      expect(page).not_to have_field('Produto:')
      expect(page).not_to have_button('Confirmar')
    end

    it 'com sucesso' do
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
      click_on 'Visualizar galpões'
      click_on 'Maceió'
      fill_in 'Quantidade', with: 2
      select 'Vinho Tinto Miolo', from: 'Produto'
      click_on 'Confirmar'

      expect(current_path).to eq warehouse_path(warehouse.id)
      expect(page).to have_css('h2', text: 'Estoque')
      within("div#product-#{p1.id}") do
        expect(page).to have_content('Vinho Tinto Miolo')
        expect(page).to have_content('Quantidade: 2')
      end
    end

    it 'e lista produtos de acordo com as categorias do galpão' do
      user = User.create!(email: 'joao@email.com', password: '12345678')
      category = Category.create!(name: 'Bebidas')
      category2 = Category.create!(name: 'Alimentos')
      category3 = Category.create!(name: 'Utensílios')
      warehouse = Warehouse.create!(name: 'Maceió', code: 'MCZ', description: 'Ótimo galpão numa linda cidade',
                      address: 'Av Fernandes Lima', city: 'Maceió', state: 'AL',
                      postal_code: '57050-000', total_area: 10000, useful_area: 8000, category_ids: [category.id, category2.id])
      Warehouse.create(name: 'Guarulhos', code: 'GRU', description: 'Ótimo galpão numa linda cidade',
                       address: 'Av Fernandes Lima', city: 'Maceió', state: 'AL',
                       postal_code: '57050-000',
                       total_area: 10000, useful_area: 8000, category_ids: [category3.id])
      supplier = Supplier.create!(fantasy_name: 'Vinícola Miolo', legal_name: 'Miolo Fábrica de Bebidas LTDA', eni: '32.451.879/0001-77', address: 'Avenida Cabernet, 100', email: 'contato@miolovinhos.com', phone: '71 1234-5678')
      supplier2 = Supplier.create!(fantasy_name: 'Yoki Alimentos', legal_name: 'Yoki Alimentos LTDA', eni: '48.785.156/0001-33', address: 'Avenida Cotia, 100', email: 'contato@yoki.com', phone: '17 8568-9654')
      supplier3 = Supplier.create!(fantasy_name: 'Cerâmicas Geek', legal_name: 'Geek Comercio de Ceramicas LTDA', eni: '85.785.465/0001-44', email: 'contato@geek.com', phone: '17 4568-5648')
      p1 = ProductModel.create!(name: 'Vinho Tinto Miolo', height: '30', width: '10', length: '10', weight: 800, supplier: supplier, category: category)
      p2 = ProductModel.create!(name: 'Farinha Yoki', height: '30', width: '10', length: '10', weight: 800, supplier: supplier2, category: category2)
      p2 = ProductModel.create!(name: 'Caneca Star Wars', height: '14', width: '10', length: '8', weight: 300, supplier: supplier3, category: category3)

      login_as(user)
      visit root_path
      click_on 'Visualizar galpões'
      click_on 'Maceió'

      expect(page).to have_content('Vinho Tinto Miolo')
      expect(page).to have_content('Farinha Yoki')
      expect(page).not_to have_content('Caneca Star Wars')
    end
  end
end