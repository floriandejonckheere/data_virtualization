class DataSource < ActiveRecord::Base
  belongs_to :data_model, :polymorphic => true

  validates :name, :presence => true
end
