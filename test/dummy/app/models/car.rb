require 'data_virtualization'

class Car < ActiveRecord::Base
  acts_as_virtualizable

  federate :color,
            :price,
                :to => :manufacturer

  federate :price,
                :to => :dealership,
                :overwrite => false

  class Audi < Car
    federate :color,
                :to => :audi_manufacturer,
                :overwrite => true
  end

end
