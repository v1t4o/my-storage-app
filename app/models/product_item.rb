class ProductItem < ApplicationRecord
  belongs_to :warehouse
  belongs_to :product_model

  validates :warehouse_id, :product_model_id, presence: true
  validates :sku, uniqueness: true

  before_create :generate_sku

  private

  def generate_sku
    warehouse = Warehouse.find(self.warehouse_id)
    product_model = ProductModel.find(self.product_model_id)
    prefix = product_model.supplier.fantasy_name.slice(0..2).upcase
    sufix = warehouse.code.upcase
    self.sku = "#{prefix}#{SecureRandom.alphanumeric(14).upcase!}#{sufix}"
    generate_sku if ProductItem.exists?(sku: sku)
  end
end
