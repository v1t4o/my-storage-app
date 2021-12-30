class ProductModelsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit, :update]

  def index
    @product_models = ProductModel.all
  end
  
  def show
    @product_model = ProductModel.find(params[:id])
  end
  
  def new
    @product_model = ProductModel.new
  end

  def create
    product_model_params = params.require(:product_model).permit(:name, :weight, :height, :length, :width, :sku, :supplier_id, :category_id)
    @product_model = ProductModel.new(product_model_params)
    if @product_model.save()
      redirect_to @product_model, notice: 'Modelo de produto registrado com sucesso'
    end
  end

  def edit
    @product_model = ProductModel.find(params[:id])
  end

  def update
    product_model_params = params.require(:product_model).permit(:name, :weight, :height, :length, :width, :sku, :supplier_id, :category_id)
    @product_model = ProductModel.find(params[:id])
    if @product_model.update(product_model_params)
      redirect_to @product_model, notice: 'Modelo de produto alterado com sucesso'
    end
  end
end