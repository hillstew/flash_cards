require 'minitest/autorun'
require 'minitest/pride'
require './lib/card'
require './lib/turn'
require './lib/deck'
require './lib/round'

class RoundTest < Minitest::Test
  def setup
    card_1 = Card.new("What is the capital of Alaska?", "Juneau", :Geography)
    card_2 = Card.new("The Viking spacecraft sent back to Earth photographs and reports about the surface of which planet?", "Mars", :STEM)
    card_3 = Card.new("Describe in words the exact direction that is 697.5° clockwise from due north?", "North north west", :STEM)
    @deck = Deck.new([card_1, card_2, card_3])
    @round = Round.new(@deck)
  end

  def test_it_exists
    assert_instance_of Round, @round
  end

  def test_it_has_a_deck
    assert_equal @deck, @round.deck
  end

  def test_it_returns_new_turn
    assert_instance_of Turn, @round.take_turn("Juneau")
  end

  def test_it_has_turns
    assert_equal [], @round.turns
  end

  def test_it_has_number_correct
    assert_equal 0, @round.number_correct
  end

  def test_number_correct_if_correct
    @round.take_turn("Juneau")
    assert_equal 1, @round.number_correct
  end

  def test_number_correct_if_incorrect
    @round.take_turn("Bob")
    assert_equal 0, @round.number_correct
  end

  def test_number_correct_by_category
    @round.take_turn("Juneau")
    expected = @round.number_correct_by_category(:Geography)
    assert_equal 1, expected
  end

  def test_percent_correct
    @round.take_turn("Juneau")
    expected = @round.percent_correct
    assert_equal 100.0, expected

    @round.take_turn("Bob")
    expected = @round.percent_correct
    assert_equal 50.0, expected
  end

  def test_percent_correct_by_category
    @round.take_turn("Juneau")
    @round.take_turn("Bob")
    @round.take_turn("Hi")
    expected = @round.percent_correct_by_category(:Geography)
    assert_equal 100.0, expected
  end
end
