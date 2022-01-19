FactoryBot.define do
  factory :warehouse do
    name {'Santos'}
    code {'SAN'}
    description {'Ótimo galpão numa linda cidade'}
    address {'Av Fernandes Lima'}
    city {'Santos'}
    state {'SP'}
    postal_code {'57050-000'}
    total_area {10000}
    useful_area {8000}
    category_ids {nil}
  end
end