module DataVirtualization
  module DataModels
    class Base
      class << self
        def valid_for
          DataVirtualization.database_valid_for
        end
      end
    end
  end
end
