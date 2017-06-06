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
  end

end
