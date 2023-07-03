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
    @count_for = {}
    @bought_stamps = []
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
      count = calculate_stamp_count(stamp)

      count_for[stamp] = count if count >= 1

      change = @customer_input - (count_for[stamp] * stamp)

      case change
      when 0
        add_stamps_to_bought_stamps(count_for, bought_stamps)
        return bought_stamps.join(', ')
      when 3
        handle_change(change, count_for)
      else
        change_left(count_for, stamp)
      end
    end

    'Atlikums... Nav iespējams veikt pirkumu!'
  end

  private

  # Calculates the count of stamps for a given price.
  def calculate_stamp_count(stamp)
    (@customer_input / stamp).floor
  end

  # Adds stamps to the bought_stamps array based on the count_for hash
  def add_stamps_to_bought_stamps(count_for, bought_stamps)
    count_for.each do |price, units|
      units = case price
              when 5
                pluralize('marka', 'piecu', units)
              else
                pluralize('marka', 'trīs', units)
              end

      bought_stamps << units.to_s
    end
  end

  # Handles the change of 3 by adding it as a stamp.
  def handle_change(change, count_for)
    count_for[change] = 1
    @customer_input = change
  end

  # Decreases the count for a stamp and updates the remaining customer input.
  def change_left(count_for, stamp)
    count_for[stamp] -= 1
    @customer_input -= count_for[stamp] * stamp
  end

  # Pluralizes the word based on the count.
  def pluralize(word, number_as_word, count)
    if count == 1
      "#{count} #{number_as_word} centu #{word}"
    elsif count % 10 == 1 && count % 100 != 11
      "#{count} #{number_as_word} centu #{word}"
    else
      "#{count} #{number_as_word} centu #{word}s"
    end
  end
end

run = Mail.new(
  ARGV[0].to_i,
  8,
  [5, 3]
)
puts run.validate
