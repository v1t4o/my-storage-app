class AddTotalWeightToProductBundle < ActiveRecord::Migration[6.1]
  def change
    add_column :product_bundles, :total_weight, :integer, null: true
  end
end
