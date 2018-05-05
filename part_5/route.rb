require_relative 'instance_counter'
require_relative 'station'

class Route
  include InstanceCounter
  set_counter

  attr_reader :stations

  def initialize(start_station, end_station)
    @stations = [start_station, end_station]
    validate!
    register_instance
  end

  def show
    stations.map(&:name).join('-')
  end

  def add_station(station)
    @stations.insert(-2, station)
  end

  def delete_station(station)
    if [stations[0], stations[-1]].include? station
      return puts "You can't delete end stations"
    end
    @stations.delete(station)
  end

  def next_station(station)
    return if station == stations[-1]
    stations[stations.index(station) + 1]
  end

  def previous_station(station)
    return if station == stations[0]
    stations[stations.index(station) - 1]
  end

  def valid?
    validate!
  rescue StandardError
    false
  end

  private

  def validate!
    unless @stations.all? { |s| s.is_a? Station }
      raise "FAILED! The list of stations doesn't consist the station"
    end
    true
  end
end
