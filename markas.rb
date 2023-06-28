customer_input = ARGV[0].to_i
min_price = 8
stamps = [5, 3]

begin
  if customer_input.nil?
    raise ArgumentError, "Value has not been set."
  end

  customer_input  = customer_input

  if customer_input < min_price
    raise RuntimeError, "Lowest transaction price is set to #{min_price}"
  end
rescue RuntimeError => error
  puts "#{ error.message }"
rescue ArgumentError => error
  puts "#{ error.message}"
end

collected = {}


stamps.each do |stamp_price|
  count = (customer_input / stamp_price).floor

  if count >= 1
    collected[stamp_price] = count
  end

  change = customer_input - (collected[stamp_price] * stamp_price)

  # found the first time
  # adjust message
  if change == 0
    collected.each do |final, value|
      puts "#{value} piecu centu markas, #{value} trīs centu markas."
    end
    break
  end

  # if change is the same as next value

  # continue counting
  if change != 0
    collected[stamp_price] = collected[stamp_price] - 1
    customer_input -= collected[stamp_price] * stamp_price
  end
end