class AddNullToTables < ActiveRecord::Migration[5.2]
  def change
    change_column :categories, :name, :string, null: false
    change_column :comments, :body, :text, null: false
    change_column :conditions, :status, :string, null: false
    change_column :listings, :title, :string, null: false
    change_column :listings, :posted_date, :date, null: false
    change_column :listings, :description, :text, null: false
  end
end
