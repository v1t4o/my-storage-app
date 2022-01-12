class Api::V1::WarehousesController < Api::V1::ApiController
  def index
    warehouses = Warehouse.all
    render json: warehouses.as_json(except: [:address, :created_at, :updated_at]), status: 200
  end

  def show
    @warehouse = Warehouse.find(params[:id])
    #render json: warehouse.as_json(except: [:created_at, :updated_at]), status: 200
  end

  def create
    warehouse_params = params.permit(:name, :code, :description, :postal_code, :address, :city, :state, :total_area, :useful_area)
    warehouse = Warehouse.new(warehouse_params)
    if warehouse.save
      render json: warehouse, status: 201
    else
      render status: 422, json: warehouse.errors.full_messages
    end
  end
end