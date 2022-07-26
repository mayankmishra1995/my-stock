class AddPricePerWeightToItem < ActiveRecord::Migration[5.1]
  def change
    add_column :items, :price_per_weight, :float
  end
end
