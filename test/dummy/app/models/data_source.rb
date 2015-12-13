class DataSource < ActiveRecord::Base
  include DataVirtualization::DataSource

  belongs_to :data_model, :polymorphic => true

  validates :name, :presence => true
end
