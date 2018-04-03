class Route
  attr_reader :stations_list

  def initialize(start_station, end_station)
    @start_station = start_station
    @end_station = end_station
    @stations_list = [@start_station, @end_station]
  end

  def add_station_before (station, before_station)
    @stations_list.insert(index(before_station), station)
  end

  def delete_station(station)
    return puts "You can't delete end stations" if [@start_station, @end_station].include? station
    @stations_list.delete(station)
  end

  def next(station)
    @stations_list[index(station) + 1]
  end

  def previous(station)
    @stations_list[index(station) - 1]
  end

  private
  def index(station)
    @stations_list.index(station)
  end
end

# r = Route.new('a', 'z')
# p r.stations_list
# r.add_station_before('b', 'z')
# p r.stations_list
# r.delete_station('a')
# r.delete_station('b')
# p r.stations_list
