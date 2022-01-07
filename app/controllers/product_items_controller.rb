class ProductItemsController < ApplicationController
  def new_entry
    @warehouses = Warehouse.all
    @product_models = ProductModel.all
  end

  def process_entry
    pe = ProductEntry.new(quantity: params[:quantity], product_model_id: params[:product_model_id], warehouse_id: params[:warehouse_id])
    pe.process()
    redirect_to warehouse_path(pe.warehouse_id)
  end
end