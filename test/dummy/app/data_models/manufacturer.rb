module DataModels
  class Manufacturer < DataVirtualization::DataModels::Base
    class << self
      def color(key)
        if key == 'red_mustang_manufacturer_key'
          'red'
        elsif key == 'black_a4_manufacturer_key'
          'black'
        end
      end

      def price(key)
        if key == 'red_mustang_manufacturer_key'
          23895
        elsif key == 'black_a4_manufacturer_key'
          35900
        end
      end
    end
  end
end
