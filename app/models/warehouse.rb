class Warehouse < ApplicationRecord
  validates :name, :code, :description, :address, :city, :state, :postal_code, :total_area, :useful_area, presence: true
  validates :name, :code, uniqueness: true
  validates :postal_code, format: { with: /\d{5}-\d{3}/ }
  has_many :product_items
  has_many :warehouse_product_categories
  has_many :categories, through: :warehouse_product_categories
  has_many :product_models, through: :product_items
end
