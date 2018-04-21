require_relative 'manufacturer'
require_relative 'instance_counter'

class Train
  include Manufacturer
  include InstanceCounter

  attr_reader :number, :type, :current_speed, :carriages, :route, :current_station

  NUMBER_FORMAT = /^[a-z0-9]{3}-?[a-z0-9]{2}$/i
  @@all = {}
  set_counter

 def initialize(number)
    @number = valid?(number)
    raise 'Rejected. Got ivalid object' unless @number
    @type = 'cargo'
    @carriages = []
    @current_speed = 0
    @route = nil
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
    return puts "Stop the train before adding a carriage" unless current_speed.zero?
    @carriages << carriage
  end

  def remove_one_carriage
    return puts "Stop the train before removing a carriage" unless current_speed.zero?
    @carriages.pop
  end

  def route=(route)
    @route = route
    @current_station = @route.stations[0]
    @current_station.take(self)
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

  def self.find(number)
    @@all[number.to_s]
  end

  def valid?(value)
    validate(value)
  rescue
    false
  end

  protected
  attr_writer :current_speed, :current_station

  def validate(value)
    raise "Your value has invalid format, use one of patterns: XXX-XX or XXXXX" unless value =~ NUMBER_FORMAT
    value
  rescue RuntimeError => e
    puts e
    print "Try again. Enter another value: "
    value = gets.chomp
  retry
  end
end
