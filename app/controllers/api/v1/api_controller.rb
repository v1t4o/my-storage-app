class Api::V1::ApiController < ActionController::API
  rescue_from ActiveRecord::RecordNotFound, with: :return_404
  rescue_from ActiveRecord::ConnectionNotEstablished, with: :return_500

  
  private 

  def return_404
    render json: {"error": "Objeto não encontrado"}, status: 404
  end

  def return_500
    render json: {"error": "Não foi possível conectar no banco de dados"}, status: 500
  end
end