class Route
  attr_reader :stations

  def initialize(start_station, end_station)
    @stations = [start_station, end_station]
  end

  def show
    stations.map(&:name)
  end

  def add_station(station)
    @stations.insert(-2, station)
  end

  def delete_station(station)
    return puts 'There is no such station in this route' unless stations.include? station
    return puts "You can't delete end stations" if [stations[0], stations[-1]].include? station
    @stations.delete(station)
    stations
  end

  def next_station(station)
    return puts "#{station.name} is the last station of the route" if station == stations[-1]
    stations[stations.index(station) + 1]
  end

  def previous_station(station)
    return puts "#{station.name} is the first station of the route" if station == stations[0]
    stations[stations.index(station) - 1]
  end
end
