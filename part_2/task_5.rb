print 'Число: '
day = gets.to_i
print 'Месяц: '
month = gets.to_i
print 'Год: '
year = gets.to_i

days_in_month = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]

days_in_month[1] = 29 if (year % 400).zero? || (year % 4).zero? && !(year % 100).zero?

puts month > 1 ? day + days_in_month[0...month - 1].sum : day
