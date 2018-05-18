require_relative 'train'
require_relative 'station'

t = Train.new(11223)
p t
t.speed_up_by 150
p t.current_speed

s1 = Station.new("Nizhyn")
s2 = Station.new("Nosivka")

r = Route.new(s1, s2)
t.route = r
p t.current_station


