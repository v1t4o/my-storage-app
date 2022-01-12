class Api::V1::ProductModelsController < Api::V1::ApiController
  def index
    product_models = ProductModel.all
    render json: product_models.as_json(except: [:created_at, :updated_at, :supplier_id, :category_id], methods: [:dimensions], include: [{supplier: {except: [:created_at, :updated_at, :cnpj]}}, {category: {only: :name}}]), status: 200
  end

  def show
    product_model = ProductModel.find(params[:id])
    render json: product_model.as_json(except: [:created_at, :updated_at, :supplier_id, :category_id], methods: [:dimensions], include: [{supplier: {except: [:created_at, :updated_at, :cnpj]}}, {category: {only: :name}}]), status: 200
  end
end