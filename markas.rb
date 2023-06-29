class Mail
    def initialize(
        customer_input,
        min_price,
        available_stamps
    )
        @customer_input = customer_input.to_i
        @min_price = min_price
        @available_stamps = available_stamps
    end
    
    def validate
        begin
            if @customer_input == 0
                raise ArgumentError, "Nav ievadīta derīga vertība"
            end
            
            if @customer_input < @min_price
                raise RuntimeError, "Pirkumam ir jābūt vismaz #{@min_price.to_f / 100} €"
            end
        rescue RuntimeError => error
            return "#{ error.message }"
        rescue ArgumentError => error
            return "#{ error.message}"
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
                    case final
                    when 5
                        value = "#{value} piecu"
                    else
                        value = "#{value} trīs"
                    end
                    
                    customer_stamps << "#{value} centu markas"
                end
                
                return customer_stamps.join(', ')
            else
                collected[stamp_price] = collected[stamp_price] - 1
                @customer_input -= collected[stamp_price] * stamp_price
            end
        end
    end
end

p '17resrt'.to_i