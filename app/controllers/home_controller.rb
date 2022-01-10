class HomeController < ApplicationController
  def index
    if !params[:term]
      @warehouses = Warehouse.all
    else
      @warehouses = Warehouse.where("name LIKE ? OR code LIKE ? OR city LIKE ?", "%#{params[:term]}%", "%#{params[:term]}%", "%#{params[:term]}%")
    end
  end
end