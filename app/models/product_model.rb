class ProductModel < ApplicationRecord
  belongs_to :supplier
  has_many :product_bundle_items
  has_many :product_bundles, through: :product_bundle_items

  def dimensions
    "#{height} x #{width} x #{length}"
  end
end
