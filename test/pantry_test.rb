require './lib/pantry'
require './lib/recipe'
require 'minitest/autorun'
require 'minitest/pride'

class PantryTest < Minitest::Test

  def setup
    @pan = Pantry.new
    rec_1 = Recipe.new("Cheese Pizza")
    bi_1 = rec_1.add_ingredient("Cayenne Pepper", 0.025)
    bi_2 = rec_1.add_ingredient("Cheese", 75)
    bi_3 = rec_1.add_ingredient("Flour", 500)
    @rec_1 = rec_1
    rec_2 = Recipe.new("Lame Pizza")
    bi_1 = rec_2.add_ingredient("Olives", 3)
    bi_2 = rec_2.add_ingredient("Cheese", 0.75)
    bi_3 = rec_2.add_ingredient("Sauce", 101)
    @rec_2 = rec_2
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
    assert_instance_of Hash, @pan.convert_units(@rec_1)
    assert_equal 3, @pan.convert_units(@rec_1).length
    assert_equal 5, @pan.convert_units(@rec_1)["Flour"][:quantity]
    assert_equal "Centi-Units", @pan.convert_units(@rec_1)["Flour"][:units]
    assert_equal 25, @pan.convert_units(@rec_1)["Cayenne Pepper"][:quantity]
    assert_equal "Milli-Units", @pan.convert_units(@rec_1)["Cayenne Pepper"][:units]
    assert_equal 75, @pan.convert_units(@rec_1)["Cheese"][:quantity]
    assert_equal "Universal-Units", @pan.convert_units(@rec_1)["Cheese"][:units]
  end

  def test_it_can_convert_units_from_recipe_class_2
    assert_instance_of Hash, @pan.convert_units(@rec_2)
    assert_equal 3, @pan.convert_units(@rec_2).length
    assert_equal 3, @pan.convert_units(@rec_2)["Olives"][:quantity]
    assert_equal "Universal-Units", @pan.convert_units(@rec_2)["Olives"][:units]
    assert_equal 750, @pan.convert_units(@rec_2)["Cheese"][:quantity]
    assert_equal "Milli-Units", @pan.convert_units(@rec_2)["Cheese"][:units]
    assert_equal 1, @pan.convert_units(@rec_2)["Sauce"][:quantity]
    assert_equal "Centi-Units", @pan.convert_units(@rec_2)["Sauce"][:units]
  end

  def test_it_can_add_to_grocery_list
    r = Recipe.new("Cheese Pizza")
    r.add_ingredient("Cheese", 20)
    r.add_ingredient("Flour", 20)
    @pan.add_to_shopping_list(r)

    assert_instance_of Hash, @pan.shopping_list
    assert_equal 20, @pan.shopping_list["Cheese"]
  end

  def test_it_can_add_to_grocery_list_with_two_recipes
    r = Recipe.new("Cheese Pizza")
    r.add_ingredient("Cheese", 20)
    r.add_ingredient("Flour", 20)

    r_1 = Recipe.new("Spaghetti")
    r_1.add_ingredient("Noodles", 10)
    r_1.add_ingredient("Sauce", 10)
    r_1.add_ingredient("Cheese", 5)
    @pan.add_to_shopping_list(r)
    @pan.add_to_shopping_list(r_1)

    assert_instance_of Hash, @pan.shopping_list
    assert_equal 25, @pan.shopping_list["Cheese"]
  end

  def test_it_can_print_shopping_list
    r = Recipe.new("Cheese Pizza")
    r.add_ingredient("Cheese", 20)
    r.add_ingredient("Flour", 20)

    r_1 = Recipe.new("Spaghetti")
    r_1.add_ingredient("Noodles", 10)
    r_1.add_ingredient("Sauce", 10)
    r_1.add_ingredient("Cheese", 5)
    @pan.add_to_shopping_list(r)
    @pan.add_to_shopping_list(r_1)

    assert_equal "* Cheese: 25\n* Flour: 20", @pan.print_shopping_list[0..23]
  end
end
