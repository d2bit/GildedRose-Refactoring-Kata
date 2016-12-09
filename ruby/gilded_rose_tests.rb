require File.join(File.dirname(__FILE__), 'gilded_rose')
require 'test/unit'

class TestUntitled < Test::Unit::TestCase
  def test_sell_in_decreases
    a_name = 'foo'
    a_sell_in = 10
    a_quality = 10
    time_passed = 1
    items = [Item.new(a_name, a_sell_in, a_quality)]

    GildedRose.new(items).update_quality

    assert_equal items.first.sell_in, a_sell_in - time_passed
  end

  def test_items_decrease_quality
    a_name = 'foo'
    a_sell_in = 10
    a_quality = 10
    standard_degradation = 1
    items = [Item.new(a_name, a_sell_in, a_quality)]

    GildedRose.new(items).update_quality

    assert_equal items.first.quality, a_quality - standard_degradation
  end

  def test_outdated_items_decrease_quality_twice_faster
    a_name = 'foo'
    a_sell_in = 0
    a_quality = 10
    standard_degradation = 1
    outdated_degradation = standard_degradation * 2
    items = [Item.new(a_name, a_sell_in, a_quality)]

    GildedRose.new(items).update_quality

    assert_equal items.first.quality, a_quality - outdated_degradation
  end

  def test_items_quality_cannot_be_negative
    a_name = 'foo'
    a_sell_in = 10
    a_quality = 0
    minimum_quality = 0
    items = [Item.new(a_name, a_sell_in, a_quality)]

    GildedRose.new(items).update_quality

    assert_equal items.first.quality, minimum_quality
  end
end
