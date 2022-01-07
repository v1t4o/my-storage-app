class ProductItemsController < ApplicationController
  def new_entry
    @warehouses = Warehouse.all
    @product_models = ProductModel.all
  end

  def process_entry
    quantity = params[:quantity].to_i
    warehouse_id = params[:warehouse_id]
    product_model_id = params[:product_model_id]

    warehouse = Warehouse.find(warehouse_id)
    product_model = ProductModel.find(product_model_id)

    quantity.times do
      ProductItem.create(warehouse: warehouse, product_model: product_model)
    end

    redirect_to warehouse
  end
end