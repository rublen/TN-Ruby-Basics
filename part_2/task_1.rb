months = {}
(1..12).each do |m|
  case m
  when 2 then months[Time.new(2018, m).strftime("%B")] = 28
  when 4, 6, 9, 11 then months[Time.new(2018, m).strftime("%B")] = 30
  else months[Time.new(2018, m).strftime("%B")] = 31
  end
end

months.each { |k, v| puts k if v == 30 }
