class Route
  attr_reader :stations_list, :start_station, :end_station

  def initialize(start_station, end_station)
    @start_station = start_station
    @end_station = end_station
    @stations_list = [@start_station, @end_station]
  end

  def display_route
    stations_list.each { |station| puts station }
  end

  def add_station_before (station, before_station)
    @stations_list.insert(index(before_station), station)
  end

  def delete_station(station)
    return "You can't delete end stations" if [@start_station, @end_station].include? station
    @stations_list.delete(station)
    stations_list
  end

  def next_station(station)
    return "#{station} is the last station of the route" if station == end_station
    stations_list[index(station) + 1]
  end

  def previous_station(station)
    return "#{station} is the first station of the route" if station == start_station
    stations_list[index(station) - 1]
  end

  private
  def index(station)
    stations_list.index(station)
  end
end
