class ProductModel < ApplicationRecord
  belongs_to :supplier
  belongs_to :category
  has_many :product_bundle_items
  has_many :product_bundles, through: :product_bundle_items
  
  before_validation :set_sku

  validates :name, :weight, :height, :length, :width, :supplier_id, :category_id, presence: true
  validates :sku, uniqueness: true
  validates :weight, :height, :length, :width, exclusion: {in: [0] }
  
  def dimensions
    "#{height} x #{width} x #{length}"
  end

  private

  def set_sku
    self.sku = SecureRandom.hex(20).upcase!
    set_sku if ProductModel.exists?(sku: sku)
  end
end
