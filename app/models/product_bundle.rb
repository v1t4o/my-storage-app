class ProductBundle < ApplicationRecord
  has_many :product_bundle_items
  has_many :product_models, through: :product_bundle_items

  validates :name, presence: true
  validates :sku, uniqueness: true

  before_create :generate_sku

  def generate_sku
    self.sku = "K#{SecureRandom.alphanumeric(20).upcase!}"
    generate_sku if ProductBundle.exists?(sku: sku)
  end
end
