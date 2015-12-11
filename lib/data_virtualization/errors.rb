module DataVirtualization
  module Errors
    class Error < StandardError; end

    class InvalidMappingError < Error; end
    class NoDataKeyError < Error; end
    class NoDataSourceError < Error; end
  end
end
