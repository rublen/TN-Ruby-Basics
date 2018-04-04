# require './train'

class Station
  attr_reader :trains, :name

  def initialize(name)
    @name = name
    @trains = []
  end

  def trains_on_the_station
    trains.map { |train| train.number }
  end

  def take (train)
    @trains << train
  end

  def send(train)
    @trains.delete(train)
  end

  # freight or passanger
  def trains_by_type(type)
    trains.select { |train| train.type = type }
  end
end
# p Station.new('A').trains
