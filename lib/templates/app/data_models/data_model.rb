module DataModels
  class <%= class_name %> < DataVirtualization::DataModels::Base
    class << self
      # def my_attribute(key)
        # if key == 'key1'
          # return 'my_attribute_value_1'
        # else
          # return 'my_attribute_value_2'
        # end
      # end

      # Add your methods here

      ## Override default cache timeout
      # def valid_for
        # super
      # end
    end
  end
end
