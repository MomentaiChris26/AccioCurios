class AddPriceToListings < ActiveRecord::Migration[5.2]
  def change
    add_column :listings, :price, :float, default: 0.0, null: false
  end
end
