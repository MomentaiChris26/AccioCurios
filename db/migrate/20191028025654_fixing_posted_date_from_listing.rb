class FixingPostedDateFromListing < ActiveRecord::Migration[5.2]
  def change
    change_column :listings, :posted_date, :date
  end
end
