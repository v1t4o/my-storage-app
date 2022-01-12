class WarehousesController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit, :update]

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
    else
      flash.now[:alert] = 'Não foi possível gravar o galpão'
      render 'new'
    end
  end

  def show
    @warehouse = Warehouse.find(params[:id])
    @product_models = ProductModel.joins(:category).where('categories.id IN (?)', @warehouse.category_ids)
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
    else
      flash.now[:alert] = 'Não foi possível editar o galpão'
      render 'edit'
    end
  end

  def product_entry
    pe = ProductEntry.new(quantity: params[:quantity], product_model_id: params[:product_model_id], warehouse_id: params[:id])
    pe.process()
    redirect_to warehouse_path(pe.warehouse_id)
  end
end