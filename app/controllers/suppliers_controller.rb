class SuppliersController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create]
  
  def index
    @suppliers = Supplier.all
  end
  
  def show
    @supplier = Supplier.find(params[:id])
  end
  
  def new
    @supplier = Supplier.new
  end

  def create
    supplier_params = params.require(:supplier).permit(:fantasy_name, :legal_name, :eni, :address, :email, :phone)
    @supplier = Supplier.new(supplier_params)
    if @supplier.save()
      redirect_to @supplier, notice: 'Fornecedor registrado com sucesso'
    else
      flash[:alert] = 'Não foi possível gravar o fornecedor'
      render 'new'
    end
  end

  def edit
    @supplier = Supplier.find(params[:id])
  end

  def update
    supplier_params = params.require(:supplier).permit(:fantasy_name, :legal_name, :eni, :address, :email, :phone)
    @supplier = Supplier.find(params[:id])
    if @supplier.update(supplier_params)
      redirect_to @supplier, notice: 'Fornecedor alterado com sucesso'
    else
      flash[:alert] = 'Não foi possível alterar o fornecedor'
      render 'edit'
    end
  end
end