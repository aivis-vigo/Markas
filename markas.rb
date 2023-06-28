class Mail
    def initialize(
        customer_input,
        min_price,
        available_stamps
    )
        @customer_input = customer_input
        @min_price = min_price
        @available_stamps = available_stamps
    end
    
    def validate(customer_input)
        begin
            if customer_input == 0
                raise ArgumentError, "Value has not been set."
            end
            
            if customer_input.to_i < @min_price
                raise RuntimeError, "Lowest transaction price is set to #{@min_price}"
            end
        rescue RuntimeError => error
            puts "#{ error.message }"
            exit
        rescue ArgumentError => error
            puts "#{ error.message}"
            exit
        end
    end
    
    def stamps
        collected = {}
        customer_stamps = []
        
        @available_stamps.each do |stamp_price|
            count = (@customer_input / stamp_price).floor
            
            if count >= 1
                collected[stamp_price] = count
            end
            
            change = @customer_input - (collected[stamp_price] * stamp_price)
            
            case change
            when 0
                collected.each do |final, value|
                    # todo: handle messages
                    customer_stamps << "#{value} piecu centu markas"
                end
                
                return customer_stamps.join(', ')
            else
                collected[stamp_price] = collected[stamp_price] - 1
                @customer_input -= collected[stamp_price] * stamp_price
            end
        end
    end
end


customer_input = ARGV[0].to_i
min_transaction = 8
available_stamps = [5, 3]

buy = Mail.new(customer_input, min_transaction, available_stamps)
buy.validate(customer_input)
puts buy.stamps