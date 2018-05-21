require_relative 'manufacturer'
require_relative 'instance_counter'
require_relative 'accessors'
require_relative 'validation'
require_relative 'route'

class Train
  include Manufacturer
  include InstanceCounter
  extend Accessors
  include Validation

  NUMBER_FORMAT = /^[a-z0-9]{3}-?[a-z0-9]{2}$/i

  attr_reader :number, :type, :carriages, :route #, :current_station, :current_speed
  attr_accessor_with_history :current_station, :current_speed
  # strong_attr_accessor :current_speed, Numeric
  validate :number, :presence
  validate :number, :format, NUMBER_FORMAT

  @@all = {}
  set_counter

  def initialize(number)
    @number = number.to_s
    @type = nil
    @carriages = []
    @current_speed = 0
    @route = nil
    @current_station = nil
    validate!
    @@all[@number] = self
    register_instance
  end

  def speed_up_by(speed)
    self.current_speed += speed
  end

  def speed_down_by(speed)
    self.current_speed -= speed
  end

  def stop
    self.current_speed = 0
  end

  def add_one_carriage(carriage)
    return puts 'Stop train before adding a carriage' unless current_speed.zero?
    @carriages << carriage
  end

  def remove_one_carriage
    return puts 'Stop train before removing carriage' unless current_speed.zero?
    @carriages.pop
  end

  def route=(route)
    @route = route
    self.current_station = @route.stations[0]
    current_station.take(self)
  end

  def next_station
    return nil unless route
    route.next_station(current_station)
  end

  def previous_station
    return nil unless route
    route.previous_station(current_station)
  end

  def move_to_next_station
    st = next_station
    return unless st
    current_station.send_off(self)
    st.take(self)
    self.current_station = st
  end

  def move_to_previous_station
    st = previous_station
    return unless st
    current_station.send_off(self)
    st.take(self)
    self.current_station = st
  end

  def each_carriage
    return carriages.to_enum(:each) unless block_given?
    carriages.each { |car| yield car }
  end

  def self.all
    @@all
  end

  def self.find(number)
    raise 'FAILED! There is no such station in the list' unless all[number.to_s]
    all[number.to_s]
  end
end
