module DataVirtualization
  module Cache
    class << self
      attr_accessor :database_valid_for,
                    :api_valid_for,
                    :cache_path
    end

    # Default values
    @database_valid_for = 8.weeks
    @api_valid_for = 1.week
    @cache_path = File.join 'tmp', 'cache', 'data_virtualization'

    def self.setup
      yield self if block_given?
    end
  end
end
