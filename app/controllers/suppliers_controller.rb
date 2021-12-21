class SuppliersController < ApplicationController
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
end