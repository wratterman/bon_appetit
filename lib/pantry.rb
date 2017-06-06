require 'pry'
class Pantry

  attr_reader :stock

  def initialize
    @stock = {}
  end

  def check_stock(key)
    qty = @stock[key]
    if qty == nil
      0
    else
      qty
    end
  end

  def restock(key, amount)
    if @stock[key] == nil
      @stock[key] = amount
    else
      @stock[key] = @stock[key] + amount
    end
  end

  def convert_units(hash)
    hash = hash.ingredients
    new_list = {}
    hash.keys.each do |key|
      check_for_units(hash, key, new_list)
    end
    new_list
  end

  def check_for_units(hash, key, new_list)
    if hash[key] > 100
      new_list[key] = {:quantity => (hash[key] / 100), :units => "Centi-Units"}
    elsif hash[key] < 1
      new_list[key] = {:quantity => (hash[key] * 1000), :units => "Milli-Units"}
    else
      new_list[key] = {:quantity => hash[key], :units => "Universal-Units"}
    end
  end

end
