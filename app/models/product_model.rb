class ProductModel < ApplicationRecord
  belongs_to :supplier
  belongs_to :category
  has_many :product_bundle_items
  has_many :product_bundles, through: :product_bundle_items
  has_many :product_items

  before_create :generate_sku

  validates :name, :weight, :height, :length, :width, :supplier_id, :category_id, :status, presence: true
  validates :sku, uniqueness: true
  validates :weight, :height, :length, :width, exclusion: {in: [0] }
  
  enum status: { active: 0, inactive: 1 }

  def dimensions
    "#{height} x #{width} x #{length}"
  end

  private

  def generate_sku
    self.sku = SecureRandom.alphanumeric(20).upcase!
    generate_sku if ProductModel.exists?(sku: sku)
  end
end
