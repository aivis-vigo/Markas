# frozen_string_literal: true

require 'test/unit'
require_relative './markas'

# Class representing tests for the Mail class
class MailTest < Test::Unit::TestCase
  def setup
    @set_value = Mail.new(0, 8, [5, 3])
    @min_value = Mail.new(5, 8, [5, 3])
    @same_as_min = Mail.new(8, 8, [5, 3])
    @second_coin = Mail.new(12, 8, [5, 3])
    @bought_few = Mail.new(25, 8, [5, 3])
    @many_coins = Mail.new(105, 8, [5, 3])
    @bought_many = Mail.new(111, 8, [5, 3])
    @more_than_one_argument = Mail.new('145 937 542', 8, [5, 3])
    @float_argument = Mail.new('10.5', 8, [5, 3])
    @prefixed_argument = Mail.new('0010', 8, [5, 3])
  end

  def test_set_value
    assert_equal nil, @set_value.validate, 'Invalid input'
  end

  def test_min_value
    assert_equal nil, @min_value.validate, "Shouldn't be able to buy"
  end

  def test_same_as_min
    assert_equal '1 piecu centu marka, 1 trīs centu marka.', @same_as_min.validate,
                 '8 should be 1 five cent and 1 three cent stamps'
  end

  def test_second_coin
    assert_equal '4 trīs centu markas.', @second_coin.validate, '12 should be 4 three cent stamps'
  end

  def test_bought_few
    assert_equal '5 piecu centu markas.', @bought_few.validate, '25 should be 5 five cent stamps'
  end

  def test_buy_with_two_coins
    assert_equal '21 piecu centu marka, 2 trīs centu markas.', @bought_many.validate,
                 '111 should be 21 five cent and 2 three cent stamps'
  end

  def test_many_coin
    assert_equal '21 piecu centu marka.', @many_coins.validate, '105 should be 21 stamps'
  end

  def test_more_than_one_argument
    assert_equal '29 piecu centu markas.', @more_than_one_argument.validate, '145 should be 29 stamps'
  end

  def test_float_argument
    assert_equal '2 piecu centu markas.', @float_argument.validate, '10.5 should be 2 stamps'
  end

  def test_prefixed_argument
    assert_equal '2 piecu centu markas.', @prefixed_argument.validate, '0010 should be 2 stamps'
  end
end
