require 'rails_helper'

RSpec.describe Warehouse, type: :model do
  it 'name é obrigatório' do
    warehouse = Warehouse.new(name: '', code: 'CWB', description: 'Ótimo galpão mas é frio', 
                              address: 'Av Coritiba', city: 'Curitiba', state: 'PR',
                              postal_code: '45000-000', total_area: 5000, useful_area: 4000)
    result = warehouse.valid?

    expect(result).to eq false
  end

  it 'o nome é duplicado' do
    warehouse = Warehouse.create(name: 'Curitibox', code: 'CWB', description: 'Ótimo galpão mas é frio', 
                              address: 'Av Coritiba', city: 'Curitiba', state: 'PR',
                              postal_code: '45000-000', total_area: 5000, useful_area: 4000)
    warehouse2 = Warehouse.new(name: 'Curitibox', code: 'CRT', description: 'Ótimo galpão mas é frio', 
                              address: 'Av Coritiba', city: 'Curitiba', state: 'PR',
                              postal_code: '45000-000', total_area: 5000, useful_area: 4000)                         
    result = warehouse2.valid?

    expect(result).to eq false
  end

  it 'code é obrigatório' do
    warehouse = Warehouse.new(name: 'Curitibox', code: '', description: 'Ótimo galpão mas é frio', 
                              address: 'Av Coritiba', city: 'Curitiba', state: 'PR',
                              postal_code: '45000-000', total_area: 5000, useful_area: 4000)
    result = warehouse.valid?

    expect(result).to eq false
  end

  it 'o código é duplicado' do
    warehouse = Warehouse.create(name: 'Curitibox', code: 'CWB', description: 'Ótimo galpão mas é frio', 
                              address: 'Av Coritiba', city: 'Curitiba', state: 'PR',
                              postal_code: '45000-000', total_area: 5000, useful_area: 4000)
    warehouse2 = Warehouse.new(name: 'Curitibox 2', code: 'CWB', description: 'Ótimo galpão mas é frio', 
                              address: 'Av Coritiba', city: 'Curitiba', state: 'PR',
                              postal_code: '45000-000', total_area: 5000, useful_area: 4000)                         
    result = warehouse2.valid?

    expect(result).to eq false
  end

  it 'description é obrigatório' do
    warehouse = Warehouse.new(name: 'Curitibox', code: 'CWB', description: '', 
                              address: 'Av Coritiba', city: 'Curitiba', state: 'PR',
                              postal_code: '45000-000', total_area: 5000, useful_area: 4000)
    result = warehouse.valid?

    expect(result).to eq false
  end

  it 'address é obrigatório' do
    warehouse = Warehouse.new(name: 'Curitibox', code: 'CWB', description: 'Ótimo galpão mas é frio', 
                              address: '', city: 'Curitiba', state: 'PR',
                              postal_code: '45000-000', total_area: 5000, useful_area: 4000)
    result = warehouse.valid?

    expect(result).to eq false
  end

  it 'city é obrigatório' do
    warehouse = Warehouse.new(name: 'Curitibox', code: 'CWB', description: 'Ótimo galpão mas é frio', 
                              address: 'Av Coritiba', city: '', state: 'PR',
                              postal_code: '45000-000', total_area: 5000, useful_area: 4000)
    result = warehouse.valid?

    expect(result).to eq false
  end

  it 'state é obrigatório' do
    warehouse = Warehouse.new(name: 'Curitibox', code: 'CWB', description: 'Ótimo galpão mas é frio', 
                              address: 'Av Coritiba', city: 'Curitiba', state: '',
                              postal_code: '45000-000', total_area: 5000, useful_area: 4000)
    result = warehouse.valid?

    expect(result).to eq false
  end

  it 'postal_code é obrigatório' do
    warehouse = Warehouse.new(name: 'Curitibox', code: 'CWB', description: 'Ótimo galpão mas é frio', 
                              address: 'Av Coritiba', city: 'Curitiba', state: 'PR',
                              postal_code: '', total_area: 5000, useful_area: 4000)
    result = warehouse.valid?

    expect(result).to eq false
  end

  context 'cep inválido não pode ser registrado' do
    it 'cep igual a 755' do
      warehouse = Warehouse.new(name: 'Curitibox', code: 'CWB', description: 'Ótimo galpão mas é frio', 
                              address: 'Av Coritiba', city: 'Curitiba', state: 'PR',
                              postal_code: '755', total_area: 5000, useful_area: 4000)
      result = warehouse.valid?

      expect(result).to eq false
    end

    it 'cep igual a 700000-00' do
      warehouse = Warehouse.new(name: 'Curitibox', code: 'CWB', description: 'Ótimo galpão mas é frio', 
                              address: 'Av Coritiba', city: 'Curitiba', state: 'PR',
                              postal_code: '700000-00', total_area: 5000, useful_area: 4000)
      result = warehouse.valid?

      expect(result).to eq false
    end

    it 'cep igual a aaaaa-aaa' do
      warehouse = Warehouse.new(name: 'Curitibox', code: 'CWB', description: 'Ótimo galpão mas é frio', 
                              address: 'Av Coritiba', city: 'Curitiba', state: 'PR',
                              postal_code: 'aaaaa-aaa', total_area: 5000, useful_area: 4000)
      result = warehouse.valid?

      expect(result).to eq false
    end
  end

  it 'total_area é obrigatório' do
    warehouse = Warehouse.new(name: 'Curitibox', code: 'CWB', description: 'Ótimo galpão mas é frio', 
                              address: 'Av Coritiba', city: 'Curitiba', state: 'PR',
                              postal_code: '45000-000', total_area: '', useful_area: 4000)
    result = warehouse.valid?

    expect(result).to eq false
  end

  it 'useful_area é obrigatório' do
    warehouse = Warehouse.new(name: 'Curitibox', code: 'CWB', description: 'Ótimo galpão mas é frio', 
                              address: 'Av Coritiba', city: 'Curitiba', state: 'PR',
                              postal_code: '45000-000', total_area: 5000, useful_area: '')
    result = warehouse.valid?

    expect(result).to eq false
  end
end
