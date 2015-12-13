class CreateCars < ActiveRecord::Migration
  def change
    create_table :cars do |t|
      t.string    :color,       :array => true
      t.integer   :price,       :array => true

      # Type attribute for STI
      t.string    :type

      t.timestamps null: false
    end
  end
end
