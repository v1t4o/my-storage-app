class CategoriesController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create]

  def index
    @categories = Category.all
  end
  
  def show
    @category = Category.find(params[:id])
  end

  def new
    @category = Category.new
  end

  def create
    category_params = params.require(:category).permit(:name)
    @category = Category.new(category_params)
    if @category.save()
      redirect_to @category, notice: 'Categoria cadastrada com sucesso'
    else
      flash[:alert] = 'Não foi possível cadastrar categoria'
      render 'new'
    end
  end
end