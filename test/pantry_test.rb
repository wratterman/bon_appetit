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

  def test_it_can_check_against_stocks
    a = Pantry.new

    assert_equal 0, a.check_stock("Cheese")
  end

  def test_it_can_restock_its_stock
    a = Pantry.new
    a.restock("Cheese", 10)

    assert_equal 10, a.check_stock("Cheese")

    a.restock("Cheese", 20)

    assert_equal 30, a.check_stock("Cheese")
  end

  def test_it_can_restock_its_stock_again
    a = Pantry.new
    a.restock("Tacos", 20)

    assert_equal 20, a.check_stock("Tacos")
  end
end
