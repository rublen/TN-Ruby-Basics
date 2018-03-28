puts '--- Ideal Weight ---'

print 'Your name: '
name = gets.chomp.capitalize

print 'Your height: '
height = gets.to_i

ideal_weight = height - 110

if ideal_weight < 0 
  puts "#{name}, Ваш вес уже оптимальный"
else
  puts "#{name}, your ideal weight is #{ideal_weight}."
end
