require 'rails_helper'

describe 'Usuário dá baixa de item do galpão' do
  it 'com sucesso' do
    user = create(:user)
    category = create(:category, name: 'Louças')
    warehouse = create(:warehouse, name: 'Guarulhos', code: 'GRU', category_ids: [category.id])
    supplier = create(:supplier, fantasy_name: 'Geek Factory', eni: '32.451.879/0002-88')
    product_model = create(:product_model, name: 'Caneca do Miranha', supplier: supplier, category: category)

    pe = ProductEntry.new(quantity: 10, product_model_id: product_model.id, warehouse_id: warehouse.id)
    pe.process()

    login_as(user)
    visit root_path
    click_on 'Visualizar galpões'
    click_on 'Guarulhos'
    within("div#checkout") do
      fill_in 'Quantidade', with: '2'
      select 'Caneca do Miranha', from: 'Produto'
      click_on 'Confirmar'
    end

    expect(current_path).to eq warehouse_path(warehouse.id)
    expect(page).to have_css('h4', text: 'Estoque')
    within("tr#product-#{product_model.id}") do
      expect(page).to have_content 'Caneca do Miranha'
      expect(page).to have_content '8'
    end
  end

  it 'e a quantidade é menor do que a disponível' do
    user = create(:user)
    category = create(:category, name: 'Louças')
    warehouse = create(:warehouse, name: 'Guarulhos', code: 'GRU', category_ids: [category.id])
    supplier = create(:supplier, fantasy_name: 'Geek Factory', eni: '32.451.879/0002-88')
    product_model = create(:product_model, name: 'Caneca do Miranha', supplier: supplier, category: category)

    pe = ProductEntry.new(quantity: 10, product_model_id: product_model.id, warehouse_id: warehouse.id)
    pe.process()

    login_as(user)
    visit root_path
    click_on 'Visualizar galpões'
    click_on 'Guarulhos'
    within("div#checkout") do
      fill_in 'Quantidade', with: '20'
      select 'Caneca do Miranha', from: 'Produto'
      click_on 'Confirmar'
    end

    expect(current_path).to eq warehouse_path(warehouse.id)
    expect(page).to have_content('Não foi possível dar baixa: quantidade menor do que a disponível')
    within("tr#product-#{product_model.id}") do
      expect(page).to have_content 'Caneca do Miranha'
      expect(page).to have_content '10'
    end
  end

  it 'a quantidade informada é menor ou igual a zero' do
    user = create(:user)
    category = create(:category, name: 'Louças')
    warehouse = create(:warehouse, name: 'Guarulhos', code: 'GRU', category_ids: [category.id])
    supplier = create(:supplier, fantasy_name: 'Geek Factory', eni: '32.451.879/0002-88')
    product_model = create(:product_model, name: 'Caneca do Miranha', supplier: supplier, category: category)

    pe = ProductEntry.new(quantity: 10, product_model_id: product_model.id, warehouse_id: warehouse.id)
    pe.process()

    login_as(user)
    visit root_path
    click_on 'Visualizar galpões'
    click_on 'Guarulhos'
    within("div#checkout") do
      fill_in 'Quantidade', with: '-1'
      select 'Caneca do Miranha', from: 'Produto'
      click_on 'Confirmar'
    end

    expect(current_path).to eq warehouse_path(warehouse.id)
    expect(page).to have_content('Não foi possível dar baixa: quantidade informada não é válida!')
    within("tr#product-#{product_model.id}") do
      expect(page).to have_content 'Caneca do Miranha'
      expect(page).to have_content '10'
    end
  end

  it 'usuário não consegue dar baixa em um produto que não está naquele galpão' do
    user = create(:user)
    category = create(:category, name: 'Louças')
    warehouse = create(:warehouse, name: 'Guarulhos', code: 'GRU', category_ids: [category.id])
    supplier = create(:supplier, fantasy_name: 'Geek Factory', eni: '32.451.879/0002-88')
    product_model = create(:product_model, name: 'Caneca do Miranha', supplier: supplier, category: category)

    pe = ProductEntry.new(quantity: 10, warehouse_id: warehouse.id, product_model_id: product_model.id)
    pe.process()

    login_as(user)
    visit root_path
    click_on 'Visualizar galpões'
    click_on 'Guarulhos'

    within("div#checkout") do
      expect(page).not_to have_content 'Caneca do Star Trek'
    end    
  end
end