class Api::V1::SuppliersController < Api::V1::ApiController
  def index
    suppliers = Supplier.all
    render json: suppliers.as_json(except: [:created_at, :updated_at]), status: 200
  end

  def show
    supplier = Supplier.find(params[:id])
    render json: supplier.as_json(except: [:created_at, :updated_at]), status: 200
  end

  def create
    supplier_params = params.permit(:fantasy_name, :legal_name, :eni, :address, :email, :phone)
    supplier = Supplier.new(supplier_params)
    if supplier.save
      render json: supplier.as_json(except: [:created_at, :updated_at]), status: 201
    else
      render status: 422, json: supplier.errors.full_messages
    end
  end
end