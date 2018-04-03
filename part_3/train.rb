class Train
  attr_reader :number, :carriages, :speed

  # type: enter '0' for freight train and '1' (or any other value), for passanger train
  def initialize(number, type, carriages)
    @number = number.to_s
    @type = type == 0 ? "freight" : "passenger"
    @carriages = carriages
    @speed = 0
  end

  def accelerate_to(speed)
    @speed = speed
  end

  def stop
    @speed = 0
  end

  def add_one_carriage
    @carriages += 1 if @speed.zero?
  end

  def remove_one_carriage
    @carriages -= 1 if @speed.zero?
  end

  def set_route(route)
    @route = route
    @station = @route.start_station
  end

  def move_to_next_station
    @station = @station.next
  end

  def move_to_previous_station
    @station = @station.previous
  end

  def next_station
    @station.station.next
  end

  def previous_station
    @station.previous
  end
end
