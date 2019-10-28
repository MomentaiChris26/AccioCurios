class ChangeSoldFromListing < ActiveRecord::Migration[5.2]
  def change
    change_column :listings, :sold, :integer, default: 0
  end
end
