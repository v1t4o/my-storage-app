class Api::WarehousesController < Api::ApiController
  def index
    warehouses = Warehouse.all
    render json: warehouses, status: 200
  end
end