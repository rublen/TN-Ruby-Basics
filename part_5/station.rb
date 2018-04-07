class Station
  attr_reader :name, :trains

  def initialize(name)
    @name = name
    @trains = []
  end

  def trains_on_the_station
    get_numbers trains
  end

  def take(train)
    @trains << train until trains.include? train
  end

  def send_off(train)
    @trains.delete(train) if trains.include? train
  end

  # cargo or passanger
  def trains_by_type(type)
    get_numbers trains.select { |train| train.class == eval("#{type.capitalize}Train") }
  end

  private
  # for DRYing code of some methods
  def get_numbers (list_of_trains)
    list_of_trains.map { |train| train.number }
  end
end
