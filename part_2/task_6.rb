invoice = {}
loop do
  puts 'If you want to stop entering data type "stop" instead product'
  print 'Product: '
  product = gets.chomp.capitalize
  break if product == 'Stop'
  print 'Price: '
  price = gets.to_f
  print 'Amount: '
  amount = gets.to_f
  invoice[product] = { price: price, amount: amount }
end

puts invoice
puts

total = 0
prod_total = 0

invoice.each do |prod, money|
  prod_total = money[:price] * money[:amount]
  puts "#{prod}: #{prod_total}"
  total += prod_total
end

puts '_______________'
puts "Total: #{total}"
