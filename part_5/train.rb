class Train
  attr_reader :number, :type, :current_speed, :carriages, :route, :current_station

  def initialize(number)
    @number = number.to_s
    @type = 'cargo'
    @carriages = []
    @current_speed = 0
    @route = nil
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
    return puts "Carriage type doesn't match train type" if carriage.type != type
    return puts "Stop the train before adding a carriage" unless current_speed.zero?
    @carriages << carriage
  end

  def remove_one_carriage
    return puts "This train has no carriages" if carriages.empty?
    return puts "Stop the train before removing a carriage" unless current_speed.zero?
    @carriages.pop
  end

  def route=(route)
    @route = route
    @current_station = @route.stations[0]
    @current_station.take(self)
  end

  def next_station
    return puts "Route hasn't set" unless route
    route.next_station(current_station)
  end

  def previous_station
    return puts "Route hasn't set" unless route
    route.previous_station(current_station)
  end

  def move_to_next_station
    return unless next_station
    current_station.send_off(self)
    self.current_station = next_station
    current_station.take(self)
  end

  def move_to_previous_station
    return unless previous_station
    current_station.send_off(self)
    self.current_station = previous_station
    current_station.take(self)
  end

  protected
  # извне эти сеттер не должны быть недоступны,
  # изменять скорость - только через методы увеличения/снижения скорости,
  # изменять станцию - через методы move_to_next/previous_station
  # дочерние классы должны иметь доступ к этим сеттерам
  attr_writer :current_speed, :current_station
end
