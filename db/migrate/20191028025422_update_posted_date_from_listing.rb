class UpdatePostedDateFromListing < ActiveRecord::Migration[5.2]
  def change
    change_column :listings, :posted_date, :date, default: Time.now
  end
end
