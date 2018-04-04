require './train'

class Station
  attr_reader :trains, :name

  def initialize(name)
    @name = name
    @trains = []
  end

  def trains_on_the_station
    get_numbers trains
  end

  def take(train)
    @trains << train
  end

  def send(train)
    @trains.delete(train)
  end

  # freight or passanger
  def trains_by_type(type)
    get_numbers trains.select { |train| train.type == type }
  end

  private
  def get_numbers (list_of_trains)
    list_of_trains.map { |train| train.number }
  end
end
