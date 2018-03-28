puts '--- If triangle is right ---'

puts "Enter three sides of the triangle with spaces: "
sides = gets.split(' ').map(&:to_i).sort

if sides[2] ** 2 == sides[0] ** 2 + sides[1] ** 2
  p sides[0] == sides[1] ? 'Right and equilateral triangle' : 'Right triangle'
else
  puts 'Triangle is not right'
end
  

