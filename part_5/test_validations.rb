require_relative 'train'
require_relative 'station'

t1 = Train.new(11223)
t2 = Train.new(11224)
p '---------'
puts "**Testing of current_speed_history"
t1.speed_up_by 150.5
# t1.current_speed = '150.5'
t1.speed_down_by 100
t1.speed_up_by 50
p t1.current_speed_history
p '---------'

s1 = Station.new("Kyiv")
s2 = Station.new("Nizhyn")

puts "**Testing of current_station_history"
r = Route.new(s1, s2)
t1.route = r
t1.move_to_next_station
t1.move_to_previous_station
p t1.current_station_history.map { |st| st.name }
p '---------'

puts "**Testing of strong_attr_accessor :name, String"
# s1.name = 1111

p '---------'
puts "**Testing of validate :name, type: String, presence: true"
s3 = Station.new(333)



