class Api::V1::SuppliersController < Api::V1::ApiController
  def index
    suppliers = Supplier.all
    render json: suppliers.as_json(except: [:created_at, :updated_at]), status: 200
  end

  def show
    begin
      supplier = Supplier.find(params[:id])
      render json: supplier.as_json(except: [:created_at, :updated_at]), status: 200
    rescue ActiveRecord::RecordNotFound
      render json: '{}', status: 404
    end
  end
end