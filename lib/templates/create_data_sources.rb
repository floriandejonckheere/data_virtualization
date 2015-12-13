class CreateDataSources < ActiveRecord::Migration
  def change
    create_table :data_sources do |t|
      t.string :name,               :null => false
      t.string :key
      t.timestamp :cache_timestamp

      t.references :data_model,     :index => true,   :polymorphic => true

      t.timestamps null: false
    end
  end
end
