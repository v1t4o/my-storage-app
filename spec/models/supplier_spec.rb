require 'rails_helper'

RSpec.describe Supplier, type: :model do
  it 'fantasy_name é obrigatório' do
    supplier = Supplier.new(fantasy_name: '', legal_name: 'Samsung do BR LTDA',
                            eni: '32.451.879/0001-77', address: 'Av Industrial, 1000, São Paulo',
                            email: 'financeiro@samsung.com.br', phone: '11 1234-5678')
    result = supplier.valid?

    expect(result).to eq false
  end

  it 'legal_name é obrigatório' do
    supplier = Supplier.new(fantasy_name: 'Samsung', legal_name: '',
                            eni: '32.451.879/0001-77', address: 'Av Industrial, 1000, São Paulo',
                            email: 'financeiro@samsung.com.br', phone: '11 1234-5678')
    result = supplier.valid?

    expect(result).to eq false
  end
  
  context 'cnpj (eni) inválido não pode ser registrado' do
    it 'o cnpj(eni) é obrigatório' do
      supplier = Supplier.new(fantasy_name: 'Samsung', legal_name: 'Samsung do BR LTDA',
                              eni: '', address: 'Av Industrial, 1000, São Paulo',
                              email: 'financeiro@samsung.com.br', phone: '11 1234-5678')
      result = supplier.valid?
  
      expect(result).to eq false
    end
  
    it 'o cnpj(eni) é duplicado' do
      supplier = Supplier.create(fantasy_name: 'Samsung', legal_name: 'Samsung do BR LTDA',
                                 eni: '32.451.879/0001-77', address: 'Av Industrial, 1000, São Paulo',
                                 email: 'financeiro@samsung.com.br', phone: '11 1234-5678')
      supplier2 = Supplier.create(fantasy_name: 'Samsung', legal_name: 'Samsung do BR LTDA',
                                  eni: '32.451.879/0001-77', address: 'Av Industrial, 1000, São Paulo',
                                  email: 'financeiro@samsung.com.br', phone: '11 1234-5678')                       
      result = supplier2.valid?
  
      expect(result).to eq false
    end  

    it 'cnpj (eni) igual a 506598120000177' do
      supplier = Supplier.create(fantasy_name: 'Samsung', legal_name: 'Samsung do BR LTDA',
                                 eni: '506598120000177', address: 'Av Industrial, 1000, São Paulo',
                                 email: 'financeiro@samsung.com.br', phone: '11 1234-5678')
      result = supplier.valid?

      expect(result).to eq false
    end

    it 'cnpj (eni) igual a 50659812/00001-77' do
      supplier = Supplier.create(fantasy_name: 'Samsung', legal_name: 'Samsung do BR LTDA',
                                 eni: '50659812/00001-77', address: 'Av Industrial, 1000, São Paulo',
                                 email: 'financeiro@samsung.com.br', phone: '11 1234-5678')
      result = supplier.valid?

      expect(result).to eq false
    end

    it 'cnpj (eni) igual a aa.aaa.aaa/aaaa-aa' do
      supplier = Supplier.create(fantasy_name: 'Samsung', legal_name: 'Samsung do BR LTDA',
                                 eni: 'aa.aaa.aaa/aaaa-aa', address: 'Av Industrial, 1000, São Paulo',
                                 email: 'financeiro@samsung.com.br', phone: '11 1234-5678')
      result = supplier.valid?

      expect(result).to eq false
    end
  end

  it 'email é obrigatório' do
    supplier = Supplier.new(fantasy_name: 'Samsung', legal_name: 'Samsung do BR LTDA',
                            eni: '32.451.879/0001-77', address: 'Av Industrial, 1000, São Paulo',
                            email: '', phone: '11 1234-5678')
    result = supplier.valid?

    expect(result).to eq false
  end
end
