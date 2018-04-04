require './route'

class Train
  attr_accessor :current_speed, :current_station, :route
  attr_reader :number, :carriages

  # type: enter '0' for freight train and '1' (or any other value), for passanger train
  def initialize(number, carriages, type = 0)
    @number = number.to_s
    @type = type == 0 ? "freight" : "passenger"
    @carriages = carriages
    @current_speed = 0
  end

  def accelerate_to(speed)
    self.current_speed = speed
  end

  def stop
    self.current_speed = 0
  end

  def add_one_carriage
    current_speed.zero? ? @carriages += 1 : (puts "Stop the train to add a carriage")
  end

  def remove_one_carriage
    current_speed.zero? ? @carriages -= 1 : (puts "Stop the train to remove a carriage")
  end

  def set_route(route)
    @route = route
    @current_station = @route.start_station
  end

   def next_station
    route.next_station(current_station)
  end

  def previous_station
    route.previous_station(current_station)
  end

  def move_to_next_station
    self.current_station = next_station
  end

  def move_to_previous_station
    self.current_station = previous_station
  end
end
# -----
t1 = Train.new(1478, 12)
r1 = Route.new(Station.new('q'), Station.new('w'))
t1.set_route(r1)
p t1

