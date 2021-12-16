class Warehouse < ApplicationRecord
  validates :name, :code, :description, :address, :city, :state, :postal_code, :total_area, :useful_area, presence: true
end
