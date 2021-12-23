require 'rails_helper'

RSpec.describe Category, type: :model do
  it 'name é obrigatório' do
    category = Category.new(name: '')
    result = category.valid?

    expect(result).to eq false
  end

  it 'name é duplicado' do
    Category.create!(name: 'Eletrônicos')
    category = Category.new(name: 'Eletrônicos')
    result = category.valid?

    expect(result).to eq false
  end
end
