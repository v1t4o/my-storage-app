class ProductBundlesController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create]

  def index
    @product_bundles = ProductBundle.all
  end

  def show
    @product_bundle = ProductBundle.find(params[:id])
  end
  
  def new
    @product_bundle = ProductBundle.new
  end

  def create
    bundle_params = params.require(:product_bundle).permit(:name, :sku, product_model_ids: [])
    @product_bundle = ProductBundle.new(bundle_params)
    if @product_bundle.save
      set_total_weight(@product_bundle.id)
      redirect_to @product_bundle
    else
      flash['alert'] = 'Não foi possível gravar o kit de produtos'
      render 'new'
    end
  end
  
  private

  def set_total_weight(id)
    product_bundle = ProductBundle.find(id)
    total = 0
    product_bundle.product_models.each do |product|
      total += product.weight
    end
    attribute = {total_weight: total}
    product_bundle.update(attribute)
  end
end