class WarehousesController < ApplicationController
  
  def new
    @warehouse = Warehouse.new
  end

  def create
    warehouse_params = params.require(:warehouse).permit(:name, :code, :address,
                                                         :state, :city, :postal_code, :description,
                                                         :useful_area, :total_area)
    warehouse = Warehouse.create(warehouse_params)
    redirect_to warehouse_path(warehouse.id), notice: 'Galpão registrado com sucesso'
  end

  def show
    @warehouse = Warehouse.find(params[:id])
  end
end