class ProductEntry
  attr_reader :quantity, :product_model_id, :warehouse_id

  def initialize(quantity:, product_model_id:, warehouse_id:)
    @quantity = quantity.to_i
    @product_model_id = product_model_id
    @warehouse_id = warehouse_id
  end

  def process
    warehouse = Warehouse.find(warehouse_id)
    product_model = ProductModel.find(product_model_id)

    ProductItem.transaction do
      quantity.times do
        #ProductItem.create!(warehouse: warehouse, product_model: product_model)
        #warehouse.product_items.create(product_model: product_model)
        product_model.product_items.create(warehouse: warehouse)
      end
    end
  end
end