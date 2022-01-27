class ProductItemsController < ApplicationController
  def new_entry
    @warehouses = Warehouse.all
    @product_models = ProductModel.active
  end

  def process_entry
    @warehouses = Warehouse.all
    @product_models = ProductModel.active
    if params[:quantity].to_i <= 0
      flash.now['alert'] = 'Quantidade não pode ser menor ou igual a 0!'
      return render 'new_entry'
    else
      pe = ProductEntry.new(quantity: params[:quantity], product_model_id: params[:product_model_id], warehouse_id: params[:warehouse_id])

      if pe.process()
        flash['alert'] = 'Entrada de produtos realizada com sucesso!'
        return redirect_to warehouse_path(pe.warehouse_id)
      end
    end
    flash.now['alert'] = 'Não foi possível dar entrada de items, pois o item não pertence a uma categoria válida!'
    render 'new_entry'
  end
end