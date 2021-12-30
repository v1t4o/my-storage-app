class ProductBundle < ApplicationRecord
  has_many :product_bundle_items
  has_many :product_models, through: :product_bundle_items

  validates :name, presence: true
  validates :sku, uniqueness: true

  before_validation :set_sku

  def set_sku
    self.sku = 'K' + SecureRandom.hex(20).upcase!
    set_sku if ProductBundle.exists?(sku: sku)
  end
end
