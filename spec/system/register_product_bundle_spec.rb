require 'rails_helper'

describe 'Usuário registrar um kit' do
  
  it 'com sucesso' do
    supplier = Supplier.create!(fantasy_name: 'Vinícola Miolo', legal_name: 'Miolo Fábrica de Bebidas LTDA', eni: '32.451.879/0001-77', address: 'Avenida Cabernet, 100', email: 'contato@miolovinhos.com', phone: '71 1234-5678')

    ProductModel.new(name: 'Vinho Tinto Miolo', height: '30', width: '10', length: '10', weight: 800, supplier: supplier).save()
    ProductModel.new(name: 'Vinho Rose Miolo', height: '30', width: '10', length: '10', weight: 800, supplier: supplier).save()
    ProductModel.new(name: 'Vinho Branco Miolo', height: '30', width: '10', length: '10', weight: 800, supplier: supplier).save()

    visit root_path
    click_on 'Criar novo kit de produtos'
    fill_in 'Nome', with: 'Kit Degustação Miolo'
    fill_in 'Código SKU', with: 'KVIN1203921'
    check 'Vinho Tinto Miolo'
    check 'Vinho Branco Miolo'
    click_on 'Gravar'

    expect(page).to have_content 'Kit Degustação Miolo'
    expect(page).to have_content 'KVIN1203921'
    expect(page).to have_content 'Vinho Tinto Miolo'
    expect(page).to have_content 'Vinho Branco Miolo'
    expect(page).not_to have_content 'Vinho Rose Miolo'
  end

end