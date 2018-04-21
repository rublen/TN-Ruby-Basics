require_relative 'instance_counter'

class Route
  include InstanceCounter
  set_counter

  attr_reader :stations

  def initialize(start_station, end_station)
    @stations = [start_station, end_station]
    register_instance
  end

  def show
    stations.map(&:name).join('-')
  end

  def add_station(station)
    @stations.insert(-2, station)
  end

  def delete_station(station)
    return puts "You can't delete end stations" if [stations[0], stations[-1]].include? station
    @stations.delete(station)
  end

  def next_station(station)
    return nil if station == stations[-1]
    stations[stations.index(station) + 1]
  end

  def previous_station(station)
    return nil if station == stations[0]
    stations[stations.index(station) - 1]
  end
end
