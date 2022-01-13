class Api::V1::ProductModelsController < Api::V1::ApiController
  def index
    product_models = ProductModel.all
    render json: product_models.as_json(except: [:created_at, :updated_at, :supplier_id, :category_id], methods: [:dimensions], include: [{supplier: {except: [:created_at, :updated_at, :cnpj]}}, {category: {only: :name}}]), status: 200
  end

  def show
    product_model = ProductModel.find(params[:id])
    render json: product_model.as_json(except: [:created_at, :updated_at, :supplier_id, :category_id], methods: [:dimensions], include: [{supplier: {except: [:created_at, :updated_at, :cnpj]}}, {category: {only: :name}}]), status: 200
  end

  def create
    product_model_params = params.permit(:name, :weight, :height, :length, :width, :supplier_id, :category_id)
    product_model = ProductModel.new(product_model_params)
    if product_model.save
      render json: product_model.as_json(except: [:created_at, :updated_at, :supplier_id, :category_id], methods: [:dimensions], include: [{supplier: {except: [:created_at, :updated_at, :cnpj]}}, {category: {only: :name}}]), status: 201
    else
      render status: 422, json: product_model.errors.full_messages
    end
  end
end