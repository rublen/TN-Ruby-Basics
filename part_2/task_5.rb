print 'Число: '
day = gets.to_i
print 'Месяц: '
month = gets.to_i
print 'Год: '
year = gets.to_i

days_in_month = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]

if (year % 4).zero?
  if (year % 400).zero?
    days_in_month[1] = 29
  else
    days_in_month[1] = 29 unless (year % 100).zero?
  end
end

num = day + days_in_month[0...month - 1].inject { |sum, m| sum + m }

puts num
