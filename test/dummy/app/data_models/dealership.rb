module DataModels
  class Dealership < DataVirtualization::DataModels::Base
    class << self
      def price(key)
        if key == 'red_mustang_dealership_key'
          20000
        elsif key == 'black_a4_dealership_key'
          30000
        else
          raise "invalid key #{key}"
        end
      end
    end
  end
end
