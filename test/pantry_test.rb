require './lib/pantry'
require './lib/recipe'
require 'minitest/autorun'
require 'minitest/pride'

class PantryTest < Minitest::Test

  def setup
    @pan = Pantry.new
    rec = Recipe.new("Cheese Pizza")
    bi_1 = rec.add_ingredient("Cayenne Pepper", 0.025)
    bi_2 = rec.add_ingredient("Cheese", 75)
    bi_3 = rec.add_ingredient("Flour", 500)
    @rec = rec
  end

  def test_it_exists
    assert_instance_of Pantry, @pan
  end

  def test_it_has_stock
    assert_instance_of Hash, @pan.stock
    assert_equal 0, @pan.stock.length
  end

  def test_it_can_check_against_stocks
    assert_equal 0, @pan.check_stock("Cheese")
  end

  def test_it_can_restock_its_stock
    @pan.restock("Cheese", 10)

    assert_equal 10, @pan.check_stock("Cheese")

    @pan.restock("Cheese", 20)

    assert_equal 30, @pan.check_stock("Cheese")
  end

  def test_it_can_restock_its_stock_again
    @pan.restock("Tacos", 20)

    assert_equal 20, @pan.check_stock("Tacos")
  end

  def test_it_can_convert_units_from_recipe_class
    assert_instance_of Hash, @pan.convert_units(@rec)
    assert_equal 3, @pan.convert_units(@rec).length
  end
end
