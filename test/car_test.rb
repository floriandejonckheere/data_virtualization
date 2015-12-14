require 'test_helper'
require 'active_record/fixtures'

class VirtualizableTest < ActiveSupport::TestCase
  setup :setup_car

  def setup_car
    @mustang = Car.find ActiveRecord::FixtureSet.identify('red-mustang')
    raise 'Test car not found' unless @mustang
  end

  def test_simple_attributes
    @mustang.clear_cache!
    assert_nil @mustang.read_attribute :price
    assert_nil @mustang.read_attribute :color

    assert_equal ['red'], @mustang.color
    assert_equal [20000, 23895], @mustang.price.sort!
  end

  def test_cache_validity
    ds = @mustang.data_sources.find_by(:name => 'manufacturer')
    @mustang.invalidate_cache!
    ds.invalidate_cache!

    assert_not @mustang.valid_cache?
    assert_not ds.valid_cache?
    @mustang.color
    assert_not @mustang.valid_cache?
    assert ds.valid_cache?
  end
end
