class Category < ApplicationRecord
  has_many :product_models
  has_many :warehouse_product_categories
  has_many :warehouses, through: :warehouse_product_categories
  validates :name, presence: true, uniqueness: true
end
