require 'test/unit'
require_relative './markas'

class MailTest < Test::Unit::TestCase
    def setup
        @set_value = Mail.new(0, 8, [5, 3])
        @min_value = Mail.new(5, 8, [5, 3])
        @check_empty = Mail.new(9, 8, [5, 3])
        @bought_few = Mail.new(25, 8, [5, 3])
        @bought_many = Mail.new(111, 8, [5, 3])
    end
    
    def test_set_value
        assert_equal "Nav ievadīta derīga vertība", @set_value.validate
    end
    
    def test_min_value
        assert_equal "Pirkumam ir jābūt vismaz 0.08 €", @min_value.validate
    end
    
    def test_check_empty
        assert_equal "3 trīs centu markas", @check_empty.validate
    end
    
    def test_buy
        assert_equal "5 piecu centu markas", @bought_few.validate
    end
    
    def test_buy_second
        assert_equal "21 piecu centu markas, 2 trīs centu markas", @bought_many.validate
    end
end
