puts '--- Square Equation ---'

print "Enter а: "
a = gets.to_f

print "Enter b: "
b = gets.to_f

print "Enter c: "
c = gets.to_f

d = b ** 2 - 4 * a * c

puts "D = #{d}"

if d < 0
  puts 'Equaton has no roots'
elsif d == 0
  puts "x = #{(-b / 2 / a).round(2)}"
else
  sqrt_d = Math.sqrt(d)
  puts "x1 = #{((-b + sqrt_d) / 2 / a).round(2)}"
  puts "x2 = #{((-b - sqrt_d) / 2 / a).round(2)}"
end
