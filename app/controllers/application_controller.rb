class ApplicationController < ActionController::Base
  rescue_from ActiveRecord::RecordNotFound, with: :return_404

  private 

  def return_404
    redirect_to root_path, notice: 'Objeto não encontrado'
  end
  
end
