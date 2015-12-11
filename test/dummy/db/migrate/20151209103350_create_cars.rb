class CreateCars < ActiveRecord::Migration
  def change
    create_table :cars do |t|
      t.text :color
      t.integer :price

      t.timestamps null: false
    end
  end
end
