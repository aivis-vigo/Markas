require 'test/unit'
require_relative './markas'

class MailTest < Test::Unit::TestCase
    def test_set_value
        set_value = Mail.new(0, 8, [5, 3])
        
        assert_equal "Nav ievadīta derīga vertība", set_value.validate
    end
    
    def test_min_value
        min_value = Mail.new(5, 8, [5, 3])
        
        assert_equal "Pirkumam ir jābūt vismaz 0.08 €", min_value.validate
    end
    
    def test_buy
        bought_few = Mail.new(25, 8, [5, 3])
        
        assert_equal "5 piecu centu markas", bought_few.stamps
    end
    
    def test_buy_second
        bought_many = Mail.new(111, 8, [5, 3])
        
        assert_equal "21 piecu centu markas, 2 trīs centu markas", bought_many.stamps
    end
end
