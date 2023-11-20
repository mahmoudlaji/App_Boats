class CreateBoats < ActiveRecord::Migration[7.0]
  def change
    create_table :boats do |t|
      t.string :category
      t.string :name
      t.text :description
      t.string :address
      t.integer :price

      t.timestamps
    end
  end
end
