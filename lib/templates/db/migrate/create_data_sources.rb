class CreateDataSources < ActiveRecord::Migration
  def change
    create_table :data_sources do |t|
      t.string :name,               :index => true,   :null => false
      t.string :keys,               :array => true
      t.timestamp :cache_timestamp

      t.references :data_model,     :index => true,   :polymorphic => true

      t.timestamps null: false
    end

    add_index :data_sources, [:name, :data_model_id], unique: true
  end
end
