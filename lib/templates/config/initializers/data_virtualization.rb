DataVirtualization.setup do |setup|
  ## Parent module of your DataModels
  # setup.data_model_module = 'DataModels'

  ## How long the data in the database is considered valid
  # setup.database_valid_for = 8.weeks

  ## How long the data in the API cache is considered valid
  # setup.api_valid_for = 1.week

  ## Cache for API calls
  # setup.cache_path = Rails.root.join 'tmp', 'cache', 'data_virtualization'
end
