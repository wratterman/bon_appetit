require './lib/pantry'
require 'minitest/autorun'
require 'minitest/pride'

class PantryTest < Minitest::Test

  def test_it_exists
    a = Pantry.new

    assert_instance_of Pantry, a
  end
end
