class Api::V1::ProductModelsController < Api::V1::ApiController
  def index
    product_models = ProductModel.all
    render json: product_models.as_json(except: [:created_at, :updated_at, :height, :width, :length, :supplier_id, :category_id], methods: [:dimensions], include: [{supplier: {only: :fantasy_name}}, {category: {only: :name}}]), status: 200
  end

  def show
    begin
      product_model = ProductModel.find(params[:id])
      render json: product_model.as_json(except: [:created_at, :updated_at, :height, :width, :length, :supplier_id, :category_id], methods: [:dimensions], include: [{supplier: {only: :fantasy_name}}, {category: {only: :name}}]), status: 200
    rescue ActiveRecord::RecordNotFound
      render json: '{}', status: 404
    end
  end
end