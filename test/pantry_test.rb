require './lib/pantry'
require 'minitest/autorun'
require 'minitest/pride'

class PantryTest < Minitest::Test

  def test_it_exists
    a = Pantry.new

    assert_instance_of Pantry, a
  end

  def test_it_has_stock
    a = Pantry.new

    assert_instance_of Hash, a.stock
    assert_equal 0, a.stock.length
  end
end
