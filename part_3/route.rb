require './station'

class Route
  attr_reader :stations_list, :start_station, :end_station

  def initialize(start_station, end_station)
    @start_station = start_station
    @end_station = end_station
    @stations_list = [@start_station, @end_station]
  end

  def display_route
    stations_list.each { |station| puts station.name }
  end

  def add_station_before (station, before_station)
    @stations_list.insert(index(before_station), station)
  end

  def delete_station(station)
    return puts "You can't delete end stations" if [@start_station, @end_station].include? station
    @stations_list.delete(station)
    stations_list
  end

  def next_station(station)
    return puts "#{station.name} is the last station of the route" if station == end_station
    stations_list[index(station) + 1]
  end

  def previous_station(station)
    return puts "#{station.name} is the first station of the route" if station == start_station
    stations_list[index(station) - 1]
  end

  private
  def index(station)
    stations_list.index(station)
  end
end

a = Station.new('A')
z = Station.new('Z')
b = Station.new('B')
route_1 = Route.new(a, z)
# p route_1.stations_list
route_1.add_station_before(b, z)
# p route_1.stations_list
p 'next st', route_1.next_station(a)
p route_1.next_station(z)
p 'prev', route_1.previous_station(a)
p route_1.previous_station(b)
route_1.delete_station(a)
route_1.delete_station(b)
# p route_1.stations_list

