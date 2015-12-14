class DataSource < ActiveRecord::Base
  include DataVirtualization::DataSource

  belongs_to :data_entity, :polymorphic => true

  validates :name, :presence => true
end
