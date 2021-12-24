class AddColumnCategoryToProductModel < ActiveRecord::Migration[6.1]
  def change
    add_reference :product_models, :category, null: true, foreign_key: true
  end
end
