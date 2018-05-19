require_relative 'train'
require_relative 'station'

t1 = Train.new(11223)
t2 = Train.new(11224)
p t1
t1.current_speed = 150.5
# t1.current_speed = '150.5'
p t1.current_speed

s1 = Station.new("Nizhyn")
s2 = Station.new("Nosivka")

r = Route.new(s1, s2)
t1.route = r
p t1.current_station.trains
p '---------'
t2.route = r
p s1.trains
p s1.trains_history
p t1.current_station_history


