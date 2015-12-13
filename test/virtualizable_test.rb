require 'test_helper'

class VirtualizableTest < ActiveSupport::TestCase
  def test_act_as_virtualizable
    assert_respond_to ActiveRecord::Base, :acts_as_virtualizable
    assert_respond_to Car, :federate
  end

  def test_simple_mapping
    assert Car.data_mapping.key? :color
    assert_equal [:manufacturer], Car.data_mapping[:color]
  end

  def test_aggregated_mapping
    assert Car::Audi.data_mapping.key? :price
    assert_equal [:manufacturer, :dealership].sort, Car::Audi.data_mapping[:price].sort
  end

  def test_attributes
    assert_respond_to Car.new, :color
    assert_respond_to Car.new, :price
  end

  def test_has_many_data_sources
    assert_respond_to Car.new, :data_sources
    assert_equal 0, Car.new.data_sources.count
  end
end
