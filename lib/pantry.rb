require 'pry'
class Pantry

  attr_reader :stock, :shopping_list

  def initialize
    @stock = {}
    @shopping_list = {}
  end

  def check_stock(key)
    qty = @stock[key]
    find_stock(qty)
  end

  def restock(key, amount)
    if @stock[key] == nil
      @stock[key] = amount
    else
      @stock[key] = @stock[key] + amount
    end
  end

  def convert_units(recipe)
    recipe = recipe.ingredients; new_list = {}
    recipe.keys.each do |key|
      check_for_units(recipe, key, new_list)
    end
    new_list
  end

  def add_to_shopping_list(recipe)
    recipe = recipe.ingredients
    @shopping_list.empty? ? add_to_empty(recipe) : add_new_to_existing_list(recipe)
    @shopping_list
  end

  def print_shopping_list
    printed_list = ""
    @shopping_list.keys.each do |key|
      printed_list << "* #{key}: #{@shopping_list[key]}\n"
    end
    p printed_list.chomp
  end

  private

  def find_stock(qty)
    if qty == nil
      0
    else
      qty
    end
  end

  def check_for_units(recipe, key, new_list)
    if recipe[key] > 100
      new_list[key] = {:quantity => (recipe[key] / 100), :units => "Centi-Units"}
    elsif recipe[key] < 1
      new_list[key] = {:quantity => (recipe[key] * 1000), :units => "Milli-Units"}
    else
      new_list[key] = {:quantity => recipe[key], :units => "Universal-Units"}
    end
  end

  def add_to_empty(recipe)
    @shopping_list = recipe
  end

  def add_new_to_existing_list(recipe)
    recipe.keys.each do |key|
      if @shopping_list.key?(key) == true
        @shopping_list[key] = (@shopping_list[key] + recipe[key])
      else
        @shopping_list[key] = recipe[key]
      end
    end
  end
end
