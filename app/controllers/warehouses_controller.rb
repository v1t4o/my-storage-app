class WarehousesController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit, :update]

  def index
    if params[:term]
      @warehouses = Warehouse.where("name LIKE ? OR code LIKE ? OR city LIKE ?", "%#{params[:term]}%", "%#{params[:term]}%", "%#{params[:term]}%")
      return
    end

    @warehouses = Warehouse.all
  end

  def new
    @warehouse = Warehouse.new
  end

  def create
    warehouse_params = params.require(:warehouse).permit(:name, :code, :address,
                                                         :state, :city, :postal_code, :description,
                                                         :useful_area, :total_area, category_ids: [])
    @warehouse = Warehouse.new(warehouse_params)
    if @warehouse.save()
      redirect_to warehouse_path(@warehouse.id), notice: 'Galpão registrado com sucesso'
      return
    end
    flash.now[:alert] = 'Não foi possível criar o galpão'
    render 'new'
  end

  def show
    @warehouse = Warehouse.find(params[:id])
    @product_models = ProductModel.where('category_id IN (?)', @warehouse.category_ids).active
  end

  def edit
    @warehouse = Warehouse.find(params[:id])
  end

  def update
    @warehouse = Warehouse.find(params[:id])
    warehouse_params = params.require(:warehouse).permit(:name, :code, :address,
                                                         :state, :city, :postal_code, :description,
                                                         :useful_area, :total_area, category_ids: [])
    if @warehouse.update(warehouse_params)
      redirect_to warehouse_path(@warehouse.id), notice: 'Galpão alterado com sucesso'
      return
    end
    flash.now[:alert] = 'Não foi possível alterar o galpão'
    render 'edit'
  end

  def product_entry
    pe = ProductEntry.new(quantity: params[:quantity], product_model_id: params[:product_model_id], warehouse_id: params[:id])
    pe.process()
    flash[:alert] = 'Entrada de produtos realizada com sucesso!'
    redirect_to warehouse_path(pe.warehouse_id)
  end

  def product_checkout
    warehouse_id = params[:id]
    quantity = params[:quantity].to_i
    product_model_id = params[:product_model_id]

    w = Warehouse.find(warehouse_id)
    pm = ProductModel.find(product_model_id)
    items = ProductItem.where("warehouse_id = ? AND product_model_id = ?", warehouse_id, product_model_id).count

    if quantity <= 0
      flash['alert'] = 'Não foi possível dar baixa: quantidade informada não é válida!'
    elsif quantity <= items
      quantity.times do 
        pi = ProductItem.where("warehouse_id = ? AND product_model_id = ?", warehouse_id, product_model_id).first
        pi.destroy
      end
    else
      flash['alert'] = 'Não foi possível dar baixa: quantidade menor do que a disponível'
    end
    redirect_to w
  end
end