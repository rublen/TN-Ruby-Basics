class Route
  attr_reader :stations, :start_station, :end_station

  def initialize(start_station, end_station)
    @stations = [start_station, end_station]
  end

  def display_route
    stations.each { |station| puts station }
  end

  def add_station(station)
    @stations.insert(-2, station)
  end

  def delete_station(station)
    return puts "You can't delete end stations" if [stations[0], stations[-1]].include? station
    @stations.delete(station)
    stations
  end

  def next_station(station)
    return puts "#{station} is the last station of the route" if station == end_station
    stations[stations.index(station) + 1]
  end

  def previous_station(station)
    return "#{station} is the first station of the route" if station == start_station
    stations[stations.index(station) - 1]
  end
end
