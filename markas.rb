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
            
            stamps
        rescue RuntimeError, ArgumentError => error
            return "#{ error.message }"
        end
    end
    
    def stamps
        count_for = {}
        bought_stamps = []
        
        @available_stamps.each do |stamp|
            count = (@customer_input / stamp).floor
            
            if count >= 1
                count_for[stamp] = count
            end
            
            change = @customer_input - (count_for[stamp] * stamp)
            
            case change
            when 0
                count_for.each do |price, units|
                    case price
                    when 5
                        units = "#{units} piecu"
                    else
                        units = "#{units} trīs"
                    end
                    
                    bought_stamps << "#{units} centu markas"
                end
                return bought_stamps.join(', ')
            else
                count_for[stamp] -= 1
                @customer_input -= count_for[stamp] * stamp
            end
        end
    end
end

run = Mail.new(
    ARGV[0].to_i,
    8,
    [5, 3]
)
puts run.validate