class Supplier < ApplicationRecord
  has_many :product_models

  validates :fantasy_name, :legal_name, :eni, :email, presence: true
  validates :eni, uniqueness: true
  validates :eni, format: { with: /\d{2}\.\d{3}\.\d{3}\/\d{4}\-\d{2}/ }
end
