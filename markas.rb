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
            $stderr.print "#{ error.message }"
        end
    end
    
    # todo: 12 should be 4 three cent coins
    
    def stamps
        count_for = {}
        bought_stamps = []
        left = 0
        
        @available_stamps.each do |stamp|
            count = (@customer_input / stamp).floor
            
            if count >= 1
                count_for[stamp] = count
            end
            
            change = @customer_input - (count_for[stamp] * stamp)
            
            case change
            when 0
                
                # todo: fix if both loops change = 0 then duplicate
                
                count_for.each do |price, units|
                    case price
                    when 5
                        units = pluralize('marka', 'piecu', units)
                    else
                        units = pluralize('marka', 'trīs', units)
                    end
                    
                    bought_stamps << "#{units}"
                end
                
                return bought_stamps.join(', ')
            when 3
                count_for[change] = 1
                @customer_input = change
                
                left = change
            else
                count_for[stamp] -= 1
                @customer_input -= count_for[stamp] * stamp
                
                left = change
            end
        end
        return "Atlikums... Nav iespējams veikt pirkumu!"
    end
    
    def pluralize(word, other_word, count)
        if count == 1
            "#{count} #{other_word} centu #{word}"
        elsif count % 10 == 1 && count % 100 != 11
            "#{count} #{other_word} centu #{word}"
        else
            "#{count} #{other_word} centu #{word}s"
        end
    end
end

run = Mail.new(
    ARGV[0].to_i,
    8,
    [5, 3]
)
puts run.validate