FactoryBot.define do
  factory :product_model do
    name {'Vinho Tinto Miolo'} 
    height {'30'} 
    width {'10'} 
    length {'10'} 
    weight {800} 
    supplier
    category
  end
end