require_relative 'train'
require_relative 'passtrain_cargotrain_carriages'
require_relative 'station'
require_relative 'optional_methods'
require_relative 'rail_road'
p "-___________-"
# -----
# a = 'A'
s1 = Station.new('A')
a = s1
z = Station.new 'Z'
b = Station.new 'B'
route_1 = Route.new(a, z)
p route_1.stations
route_1.add_station(b)
p route_1.stations
p 'next st', route_1.next_station(a)
p route_1.next_station(z)
p 'prev', route_1.previous_station(a)
p route_1.previous_station(b)
route_1.delete_station(a)
route_1.delete_station(b)
p route_1.stations
route_1.add_station(b)
route_1.display
p "-___________-"
# -----
t1 = PassengerTrain.new(1478)
t1.route = route_1
p t1
p t1.next_station
p t1.move_to_next_station
t1.speed_up_by(30)
p t1.current_speed
p t1.current_station
p "-___________-"
pc = PassCarriage.new
cc = CargoCarriage.new
t1.remove_one_carriage
t1.add_one_carriage(cc)
t1.add_one_carriage(pc)
t1.stop
t1.add_one_carriage(pc)
t1.add_one_carriage(pc)
p t1.carriages
t1.remove_one_carriage
p t1.carriages

p "-___________-"

# --- Testing ---

s1.take t1
p s1.trains_on_the_station
p s1.trains_by_type('passenger')
s1.send_off(t1)
p s1.trains_on_the_station

rr = RailRoad.new
p rr.trains

