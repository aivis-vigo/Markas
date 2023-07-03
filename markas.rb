# frozen_string_literal: true

# This class represents a Mail object that handles customer input, minimum price, and available stamps.

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

  # Validates the customer input, raising errors if necessary.
  def validate
    raise ArgumentError, 'Nav ievadīta derīga vertība' if @customer_input.zero?

    raise "Pirkumam ir jābūt vismaz #{@min_price.to_f / 100} €" if @customer_input < @min_price

    stamps
  rescue RuntimeError, ArgumentError => e
    $stderr.print e.message.to_s
  end

  # Calculates and returns the stamps based on the customer input.
  def stamps
    count_for = {}
    bought_stamps = []

    @available_stamps.each do |stamp|
      count = (@customer_input / stamp).floor

      count_for[stamp] = count if count >= 1

      change = @customer_input - (count_for[stamp] * stamp)

      case change
      when 0
        count_for.each do |price, units|
          units = case price
                  when 5
                    pluralize('marka', 'piecu', units)
                  else
                    pluralize('marka', 'trīs', units)
                  end

          bought_stamps << units.to_s
        end

        return bought_stamps.join(', ')
      when 3
        count_for[change] = 1
        @customer_input = change

      else
        count_for[stamp] -= 1
        @customer_input -= count_for[stamp] * stamp

      end
    end
    'Atlikums... Nav iespējams veikt pirkumu!'
  end

  # Pluralizes the word based on the count.
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
