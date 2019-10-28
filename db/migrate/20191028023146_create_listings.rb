class CreateListings < ActiveRecord::Migration[5.2]
  def change
    create_table :listings do |t|
      t.string :title
      t.date :posted_date
      t.integer :sold
      t.text :description
      t.references :condition, foreign_key: true
      t.references :category, foreign_key: true

      t.timestamps
    end
  end
end
