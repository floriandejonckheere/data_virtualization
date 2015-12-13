DataVirtualization::Cache.setup do |cache|
  ## How long the data in the database is considered valid
  # cache.database_valid_for = 8.weeks

  ## How long the data in the API cache is considered valid
  # cache.api_valid_for = 1.week

  ## Cache for API calls
  # cache.cache_path = Rails.root.join 'tmp', 'cache', 'data_virtualization'
end
